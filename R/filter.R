#' Subset rows using column values
#'
#' The `filter()` function is used to subset a data frame,
#' retaining all rows that satisfy your conditions.
#' To be retained, the row must produce a value of `TRUE` for all conditions.
#' Note that when a condition evaluates to `NA`
#' the row will be dropped, unlike base subsetting with `[`.
#'
#' The `filter()` function is used to subset the rows of
#' `.data`, applying the expressions in `...` to the column values to determine which
#' rows should be retained. It can be applied to both grouped and ungrouped data (see [group_by()] and
#' [ungroup()]). However, dplyr is not yet smart enough to optimise the filtering
#' operation on grouped datasets that do not need grouped calculations. For this
#' reason, filtering is often considerably faster on ungrouped data.
#'
#' @section Useful filter functions:
#'
#' There are many functions and operators that are useful when constructing the
#' expressions used to filter the data:
#'
#' * [`==`], [`>`], [`>=`] etc
#' * [`&`], [`|`], [`!`], [xor()]
#' * [is.na()]
#' * [between()], [near()]
#'
#' @section Grouped tibbles:
#'
#' Because filtering expressions are computed within groups, they may
#' yield different results on grouped tibbles. This will be the case
#' as soon as an aggregating, lagging, or ranking function is
#' involved. Compare this ungrouped filtering:
#'
#' ```
#' starwars %>% filter(mass > mean(mass, na.rm = TRUE))
#' ```
#'
#' With the grouped equivalent:
#'
#' ```
#' starwars %>% group_by(gender) %>% filter(mass > mean(mass, na.rm = TRUE))
#' ```
#'
#' In the ungrouped version, `filter()` compares the value of `mass` in each row to
#' the global average (taken over the whole data set), keeping only the rows with
#' `mass` greater than this global average. In contrast, the grouped version calculates
#' the average mass separately for each `gender` group, and keeps rows with `mass` greater
#' than the relevant within-gender average.
#'
#' @family single table verbs
#' @inheritParams arrange
#' @param ... <[`data-masking`][dplyr_data_masking]> Expressions that return a
#'   logical value, and are defined in terms of the variables in `.data`.
#'   If multiple expressions are included, they are combined with the `&` operator.
#'   Only rows for which all conditions evaluate to `TRUE` are kept.
#' @param .preserve Relevant when the `.data` input is grouped.
#'   If `.preserve = FALSE` (the default), the grouping structure
#'   is recalculated based on the resulting data, otherwise the grouping is kept as is.
#' @return
#' An object of the same type as `.data`. The output has the following properties:
#'
#' * Rows are a subset of the input, but appear in the same order.
#' * Columns are not modified.
#' * The number of groups may be reduced (if `.preserve` is not `TRUE`).
#' * Data frame attributes are preserved.
#'
#' @section Methods:
#' This function is a **generic**, which means that packages can provide
#' implementations (methods) for other classes. See the documentation of
#' individual methods for extra arguments and differences in behaviour.
#'
#' The following methods are currently available in loaded packages:
#' \Sexpr[stage=render,results=rd]{dplyr:::methods_rd("filter")}.
#' @export
#' @examples
#' # Filtering by one criterion
#' filter(starwars, species == "Human")
#' filter(starwars, mass > 1000)
#'
#' # Filtering by multiple criteria within a single logical expression
#' filter(starwars, hair_color == "none" & eye_color == "black")
#' filter(starwars, hair_color == "none" | eye_color == "black")
#'
#' # When multiple expressions are used, they are combined using &
#' filter(starwars, hair_color == "none", eye_color == "black")
#'
#'
#' # The filtering operation may yield different results on grouped
#' # tibbles because the expressions are computed within groups.
#' #
#' # The following filters rows where `mass` is greater than the
#' # global average:
#' starwars %>% filter(mass > mean(mass, na.rm = TRUE))
#'
#' # Whereas this keeps rows with `mass` greater than the gender
#' # average:
#' starwars %>% group_by(gender) %>% filter(mass > mean(mass, na.rm = TRUE))
#'
#'
#' # To refer to column names that are stored as strings, use the `.data` pronoun:
#' vars <- c("mass", "height")
#' cond <- c(80, 150)
#' starwars %>%
#'   filter(
#'     .data[[vars[[1]]]] > cond[[1]],
#'     .data[[vars[[2]]]] > cond[[2]]
#'   )
#' # Learn more in ?dplyr_data_masking
filter <- function(.data, ..., .preserve = FALSE) {
  UseMethod("filter")
}

#' @export
filter.data.frame <- function(.data, ..., .preserve = FALSE) {
  filter.duckdb_relation(duckdb::rel_from_df(get_default_duckdb_connection(), .data), ..., .preserve=.preserve)
}

#' @export
filter.duckdb_relation <- function(.data, ..., .preserve = FALSE) {
    error_call <- dplyr_error_call(caller_env())

  dots <- dplyr_quosures(...)
  check_filter(dots, error_call = caller_env())

  filter_exprs <- lapply(dots, function(q) {
    duckdb_encode_expression(rlang::quo_get_expr(q), rlang::quo_get_env(q), .data)
    })
  duckdb::rel_filter(.data, filter_exprs)
}


check_filter <- function(dots, error_call = error_call) {
  named <- have_name(dots)

  for (i in which(named)) {
    quo <- dots[[i]]

    # only allow named logical vectors, anything else
    # is suspicious
    expr <- quo_get_expr(quo)
    if (!is.logical(expr)) {
      name <- names(dots)[i]
      bullets <- c(
        "We detected a named input.",
        i = glue("This usually means that you've used `=` instead of `==`."),
        i = glue("Did you mean `{name} == {as_label(expr)}`?")
      )
      abort(bullets, call = error_call)
    }

  }
}

