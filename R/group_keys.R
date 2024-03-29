# Generated by 02-duckplyr_df-methods.R
#' @export
group_keys.duckplyr_df <- function(.tbl, ...) {
  # Our implementation
  rel_try(
    # Always fall back to dplyr
    "No relational implementation for group_keys()" = TRUE,
    {
      return(out)
    }
  )

  # dplyr forward
  group_keys <- dplyr$group_keys.data.frame
  out <- group_keys(.tbl, ...)
  return(out)

  # dplyr implementation
  if (dots_n(...) > 0) {
    lifecycle::deprecate_warn(
      "1.0.0", "group_keys(... = )",
      details = "Please `group_by()` first",
      always = TRUE
    )
    .tbl <- group_by(.tbl, ...)
  }
  out <- group_data(.tbl)
  group_keys0(out)
}

duckplyr_group_keys <- function(.tbl, ...) {
  try_fetch(
    .tbl <- as_duckplyr_df(.tbl),
    error = function(e) {
      testthat::skip(conditionMessage(e))
    }
  )
  out <- group_keys(.tbl, ...)
  class(out) <- setdiff(class(out), "duckplyr_df")
  out
}
