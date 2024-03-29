# Generated by 02-duckplyr_df-methods.R
#' @export
select.duckplyr_df <- function(.data, ...) {
  force(.data)

  error_call <- dplyr_error_call()

  loc <- tidyselect::eval_select(
    expr(c(...)),
    data = .data,
    error_call = error_call
  )

  exprs <- exprs_from_loc(.data, loc)

  rel_try(call = list(name = "select", x = .data, args = list(dots = enquos(...))),
    "Can't use relational with zero-column result set." = (length(exprs) == 0),
    {
      rel <- duckdb_rel_from_df(.data)
      out <- exprs_project(rel, exprs, .data)
      return(out)
    }
  )


  # dplyr forward
  select <- dplyr$select.data.frame
  out <- select(.data, ...)
  return(out)

  # dplyr implementation
  error_call <- dplyr_error_call()

  loc <- tidyselect::eval_select(
    expr(c(...)),
    data = .data,
    error_call = error_call
  )
  loc <- ensure_group_vars(loc, .data, notify = TRUE)

  out <- dplyr_col_select(.data, loc)
  out <- set_names(out, names(loc))

  out
}

duckplyr_select <- function(.data, ...) {
  try_fetch(
    .data <- as_duckplyr_df(.data),
    error = function(e) {
      testthat::skip(conditionMessage(e))
    }
  )
  out <- select(.data, ...)
  class(out) <- setdiff(class(out), "duckplyr_df")
  out
}
