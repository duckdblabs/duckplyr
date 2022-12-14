#' Partially evaluate an expression.
#'
#' This function partially evaluates an expression, using information from
#' the tbl to determine whether names refer to local expressions
#' or remote variables. This simplifies SQL translation because expressions
#' don't need to carry around their environment - all relevant information
#' is incorporated into the expression.
#'
#' @section Symbol substitution:
#'
#' `partial_eval()` needs to guess if you're referring to a variable on the
#' server (remote), or in the current environment (local). It's not possible to
#' do this 100% perfectly. `partial_eval()` uses the following heuristic:
#'
#' \itemize{
#'   \item If the tbl variables are known, and the symbol matches a tbl
#'     variable, then remote.
#'   \item If the symbol is defined locally, local.
#'   \item Otherwise, remote.
#' }
#'
#' You can override the guesses using `local()` and `remote()` to force
#' computation, or by using the `.data` and `.env` pronouns of tidy evaluation.
#'
#' @param call an unevaluated expression, as produced by [quote()]
#' @param vars character vector of variable names.
#' @param env environment in which to search for local values
#' @export
#' @keywords internal
#' @examples
#' vars <- c("year", "id")
#' partial_eval(quote(year > 1980), vars = vars)
#'
#' ids <- c("ansonca01", "forceda01", "mathebo01")
#' partial_eval(quote(id %in% ids), vars = vars)
#'
#' # cf.
#' partial_eval(quote(id == .data$ids), vars = vars)
#'
#' # You can use local() or .env to disambiguate between local and remote
#' # variables: otherwise remote is always preferred
#' year <- 1980
#' partial_eval(quote(year > year), vars = vars)
#' partial_eval(quote(year > local(year)), vars = vars)
#' partial_eval(quote(year > .env$year), vars = vars)
#'
#' # Functions are always assumed to be remote. Use local to force evaluation
#' # in R.
#' f <- function(x) x + 1
#' partial_eval(quote(year > f(1980)), vars = vars)
#' partial_eval(quote(year > local(f(1980))), vars = vars)
#'
#' # For testing you can also use it with the tbl omitted
#' partial_eval(quote(1 + 2 * 3))
#' x <- 1
#' partial_eval(quote(x ^ y))
partial_eval <- function(call, vars = character(), env = caller_env()) {
  if (is_null(call)) {
    NULL
  } else if (is_atomic(call) || blob::is_blob(call)) {
    call
  } else if (is_symbol(call)) {
    partial_eval_sym(call, vars, env)
  } else if (is_quosure(call)) {
    partial_eval(get_expr(call), vars, get_env(call))
  } else if (is_call(call)) {
    partial_eval_call(call, vars, env)
  } else {
    abort(glue("Unknown input type: ", typeof(call)))
  }
}

partial_eval_dots <- function(dots, vars) {
  stopifnot(inherits(dots, "quosures"))

  dots <- lapply(dots, partial_eval_quo, vars = vars)

  # Flatten across() calls
  is_list <- vapply(dots, is.list, logical(1))
  dots[!is_list] <- lapply(dots[!is_list], list)
  names(dots)[is_list] <- ""

  unlist(dots, recursive = FALSE)
}

partial_eval_quo <- function(x, vars) {
  expr <- partial_eval(get_expr(x), vars, get_env(x))
  if (is.list(expr)) {
    lapply(expr, new_quosure, env = get_env(x))
  } else {
    new_quosure(expr, get_env(x))
  }
}

partial_eval_sym <- function(sym, vars, env) {
  name <- as_string(sym)
  if (name %in% vars) {
    sym
  } else if (env_has(env, name, inherit = TRUE)) {
    eval_bare(sym, env)
  } else {
    sym
  }
}

is_namespaced_dplyr_call <- function(call) {
  is_symbol(call[[1]], "::") && is_symbol(call[[2]], "dplyr")
}

is_tidy_pronoun <- function(call) {
  is_symbol(call[[1]], c("$", "[[")) && is_symbol(call[[2]], c(".data", ".env"))
}

partial_eval_call <- function(call, vars, env) {
  fun <- call[[1]]

  # Try to find the name of inlined functions
  if (inherits(fun, "inline_colwise_function")) {
    dot_var <- vars[[attr(call, "position")]]
    call <- replace_dot(attr(fun, "formula")[[2]], dot_var)
    env <- get_env(attr(fun, "formula"))
  } else if (is.function(fun)) {
    fun_name <- find_fun(fun)
    if (is.null(fun_name)) {
      # This probably won't work, but it seems like it's worth a shot.
      return(eval_bare(call, env))
    }

    call[[1]] <- fun <- sym(fun_name)
  }

  # So are compound calls, EXCEPT dplyr::foo()
  if (is.call(fun)) {
    if (is_namespaced_dplyr_call(fun)) {
      call[[1]] <- fun[[3]]
    } else if (is_tidy_pronoun(fun)) {
      abort("Use local() or remote() to force evaluation of functions")
    } else {
      return(eval_bare(call, env))
    }
  }

  # .data$, .data[[]], .env$, .env[[]] need special handling
  if (is_tidy_pronoun(call)) {
    if (is_symbol(call[[1]], "$")) {
      idx <- call[[3]]
    } else {
      idx <- as.name(eval_bare(call[[3]], env))
    }

    if (is_symbol(call[[2]], ".data")) {
      idx
    } else {
      eval_bare(idx, env)
    }
  }  else if (is_call(call, "if_any")) {
    db_squash_if(call, env, vars, reduce = "|")
  } else if (is_call(call, "if_all")) {
    db_squash_if(call, env, vars, reduce = "&")
  } else if (is_call(call, "across")) {
    partial_eval_across(call, vars, env)
  } else {
    # Process call arguments recursively, unless user has manually called
    # remote/local
    name <- as_string(call[[1]])
    if (name == "local") {
      eval_bare(call[[2]], env)
    } else if (name == "remote") {
      call[[2]]
    } else {
      call[-1] <- lapply(call[-1], partial_eval, vars = vars, env = env)
      call
    }
  }
}

partial_eval_across <- function(call, vars, env) {
  call <- match.call(dplyr::across, call, expand.dots = FALSE, envir = env)

  tbl <- as_tibble(rep_named(vars, list(logical())))
  cols <- syms(vars)[tidyselect::eval_select(call$.cols, tbl, allow_rename = FALSE)]

  funs <- across_funs(call$.fns, env)

  # Generate grid of expressions
  out <- vector("list", length(cols) * length(funs))
  k <- 1
  for (i in seq_along(cols)) {
    for (j in seq_along(funs)) {
      out[[k]] <- exec(funs[[j]], cols[[i]], !!!call$...)
      k <- k + 1
    }
  }

  .names <- eval(call$.names, env)
  names(out) <- across_names(cols, names(funs), .names, env)
  out
}

capture_if_all <- function(data, x) {
  x <- enquo(x)
  db_squash_if(get_expr(x), get_env(x), colnames(data))
}

db_squash_if <- function(call, env, vars, reduce = "&") {
  call <- match.call(dplyr::if_any, call, expand.dots = FALSE, envir = env)

  tbl <- as_tibble(rep_named(vars, list(logical())))
  .cols <- call$.cols %||% expr(everything())
  locs <- tidyselect::eval_select(.cols, tbl, allow_rename = FALSE)
  cols <- syms(names(tbl))[locs]

  if (is.null(call$.fns)) {
    return(Reduce(function(x, y) call2(reduce, x, y), cols))
  }

  fun <- across_fun(call$.fns, env)

  out <- vector("list", length(cols))
  for (i in seq_along(cols)) {
    out[[i]] <- exec(fun, cols[[i]], !!!call$...)
  }

  Reduce(function(x, y) call2(reduce, x, y), out)
}

across_funs <- function(funs, env = caller_env()) {
  if (is.null(funs)) {
    list(function(x, ...) x)
  } else if (is_symbol(funs)) {
    set_names(list(across_fun(funs, env)), as.character(funs))
  } else if (is.character(funs)) {
    names(funs)[names2(funs) == ""] <- funs
    lapply(funs, across_fun, env)
  } else if (is_call(funs, "~")) {
    set_names(list(across_fun(funs, env)), expr_name(f_rhs(funs)))
  } else if (is_call(funs, "list")) {
    args <- rlang::exprs_auto_name(funs[-1])
    lapply(args, across_fun, env)
  } else if (!is.null(env)) {
    # Try evaluating once, just in case
    funs <- eval(funs, env)
    across_funs(funs, NULL)
  } else {
    abort("`.fns` argument to dbplyr::across() must be a NULL, a function name, formula, or list")
  }
}

across_fun <- function(fun, env) {
  if (is_symbol(fun) || is_string(fun)) {
    function(x, ...) call2(fun, x, ...)
  } else if (is_call(fun, "~")) {
    fun <- across_formula_fn(f_rhs(fun))
    function(x, ...) expr_interp(fun, child_env(emptyenv(), .x = x))
  } else {
    abort(c(
      ".fns argument to dbplyr::across() contain a function name or a formula",
      x = paste0("Problem with ", expr_deparse(fun))
    ))
  }
}


across_formula_fn <- function(x) {
  if (is_symbol(x, ".") || is_symbol(x, ".x")) {
    quote(!!.x)
  } else if (is_call(x)) {
    x[-1] <- lapply(x[-1], across_formula_fn)
    x
  } else {
    x
  }
}

across_names <- function(cols, funs, names = NULL, env = parent.frame()) {
  if (length(funs) == 1) {
    names <- names %||% "{.col}"
  } else {
    names <- names %||% "{.col}_{.fn}"
  }

  glue_env <- child_env(env,
    .col = rep(cols, each = length(funs)),
    .fn = rep(funs %||% seq_along(funs), length(cols))
  )
  glue(names, .envir = glue_env)
}

find_fun <- function(fun) {
  if (is_lambda(fun)) {
    body <- body(fun)
    if (!is_call(body)) {
      return(NULL)
    }

    fun_name <- body[[1]]
    if (!is_symbol(fun_name)) {
      return(NULL)
    }

    as.character(fun_name)
  } else if (is.function(fun)) {
    fun_name(fun)
  }
}

fun_name <- function(fun) {
  pkg_env <- env_parent(global_env())
  known <- c(ls(base_agg), ls(base_scalar))

  for (x in known) {
    if (!env_has(pkg_env, x, inherit = TRUE))
      next

    fun_x <- env_get(pkg_env, x, inherit = TRUE)
    if (identical(fun, fun_x))
      return(x)
  }

  NULL
}

replace_dot <- function(call, var) {
  if (is_symbol(call, ".")) {
    sym(var)
  } else if (is_call(call)) {
    call[] <- lapply(call, replace_dot, var = var)
    call
  } else {
    call
  }
}