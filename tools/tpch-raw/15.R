load("tools/tpch/001.rda")
con <- DBI::dbConnect(duckdb::duckdb())
experimental <- FALSE
invisible(DBI::dbExecute(con, "CREATE MACRO \">=\"(a, b) AS a >= b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"as.Date\"(x) AS strptime(x, '%Y-%m-%d')"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"<\"(a, b) AS a < b"))
invisible(
  DBI::dbExecute(con, "CREATE MACRO \"sum\"(x) AS (CASE WHEN SUM(x) IS NULL THEN 0 ELSE SUM(x) END)")
)
invisible(DBI::dbExecute(con, "CREATE MACRO \"==\"(a, b) AS a = b"))
df1 <- lineitem
rel1 <- duckdb:::rel_from_df(con, df1, experimental = experimental)
rel2 <- duckdb:::rel_filter(
  rel1,
  list(
    duckdb:::expr_function(
      ">=",
      list(
        duckdb:::expr_reference("l_shipdate"),
        duckdb:::expr_function(
          "as.Date",
          list(
            if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
              duckdb:::expr_constant("1996-01-01", experimental = experimental)
            } else {
              duckdb:::expr_constant("1996-01-01")
            }
          )
        )
      )
    ),
    duckdb:::expr_function(
      "<",
      list(
        duckdb:::expr_reference("l_shipdate"),
        duckdb:::expr_function(
          "as.Date",
          list(
            if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
              duckdb:::expr_constant("1996-04-01", experimental = experimental)
            } else {
              duckdb:::expr_constant("1996-04-01")
            }
          )
        )
      )
    )
  )
)
rel3 <- duckdb:::rel_aggregate(
  rel2,
  list(duckdb:::expr_reference("l_suppkey")),
  list(
    total_revenue = {
      tmp_expr <- duckdb:::expr_function(
        "sum",
        list(
          duckdb:::expr_function(
            "*",
            list(
              duckdb:::expr_reference("l_extendedprice"),
              duckdb:::expr_function(
                "-",
                list(
                  if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                    duckdb:::expr_constant(1, experimental = experimental)
                  } else {
                    duckdb:::expr_constant(1)
                  },
                  duckdb:::expr_reference("l_discount")
                )
              )
            )
          )
        )
      )
      duckdb:::expr_set_alias(tmp_expr, "total_revenue")
      tmp_expr
    }
  )
)
rel4 <- duckdb:::rel_project(
  rel3,
  list(
    l_suppkey = {
      tmp_expr <- duckdb:::expr_reference("l_suppkey")
      duckdb:::expr_set_alias(tmp_expr, "l_suppkey")
      tmp_expr
    },
    total_revenue = {
      tmp_expr <- duckdb:::expr_reference("total_revenue")
      duckdb:::expr_set_alias(tmp_expr, "total_revenue")
      tmp_expr
    }, {
      tmp_expr <- if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
        duckdb:::expr_constant(1L, experimental = experimental)
      } else {
        duckdb:::expr_constant(1L)
      }
      duckdb:::expr_set_alias(tmp_expr, "global_agr_key")
      tmp_expr
    }
  )
)
rel5 <- duckdb:::rel_aggregate(
  rel4,
  list(duckdb:::expr_reference("global_agr_key")),
  list(
    max_total_revenue = {
      tmp_expr <- duckdb:::expr_function("max", list(duckdb:::expr_reference("total_revenue")))
      duckdb:::expr_set_alias(tmp_expr, "max_total_revenue")
      tmp_expr
    }
  )
)
rel6 <- duckdb:::rel_project(
  rel3,
  list(
    l_suppkey = {
      tmp_expr <- duckdb:::expr_reference("l_suppkey")
      duckdb:::expr_set_alias(tmp_expr, "l_suppkey")
      tmp_expr
    },
    total_revenue = {
      tmp_expr <- duckdb:::expr_reference("total_revenue")
      duckdb:::expr_set_alias(tmp_expr, "total_revenue")
      tmp_expr
    }, {
      tmp_expr <- if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
        duckdb:::expr_constant(1L, experimental = experimental)
      } else {
        duckdb:::expr_constant(1L)
      }
      duckdb:::expr_set_alias(tmp_expr, "global_agr_key")
      tmp_expr
    }
  )
)
rel7 <- duckdb:::rel_set_alias(rel6, "lhs")
rel8 <- duckdb:::rel_set_alias(rel5, "rhs")
rel9 <- duckdb:::rel_project(
  rel7,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("l_suppkey")
      duckdb:::expr_set_alias(tmp_expr, "l_suppkey_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("total_revenue")
      duckdb:::expr_set_alias(tmp_expr, "total_revenue_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("global_agr_key")
      duckdb:::expr_set_alias(tmp_expr, "global_agr_key_x")
      tmp_expr
    }
  )
)
rel10 <- duckdb:::rel_project(
  rel8,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("global_agr_key")
      duckdb:::expr_set_alias(tmp_expr, "global_agr_key_y")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("max_total_revenue")
      duckdb:::expr_set_alias(tmp_expr, "max_total_revenue_y")
      tmp_expr
    }
  )
)
rel11 <- duckdb:::rel_join(
  rel9,
  rel10,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("global_agr_key_x", rel9), duckdb:::expr_reference("global_agr_key_y", rel10))
    )
  ),
  "inner"
)
rel12 <- duckdb:::rel_project(
  rel11,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("l_suppkey_x")
      duckdb:::expr_set_alias(tmp_expr, "l_suppkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("total_revenue_x")
      duckdb:::expr_set_alias(tmp_expr, "total_revenue")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("global_agr_key_x")
      duckdb:::expr_set_alias(tmp_expr, "global_agr_key")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("max_total_revenue_y")
      duckdb:::expr_set_alias(tmp_expr, "max_total_revenue")
      tmp_expr
    }
  )
)
rel13 <- duckdb:::rel_filter(
  rel12,
  list(
    duckdb:::expr_function(
      "<",
      list(
        duckdb:::expr_function(
          "abs",
          list(
            duckdb:::expr_function(
              "-",
              list(duckdb:::expr_reference("total_revenue"), duckdb:::expr_reference("max_total_revenue"))
            )
          )
        ),
        if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
          duckdb:::expr_constant(1e-09, experimental = experimental)
        } else {
          duckdb:::expr_constant(1e-09)
        }
      )
    )
  )
)
rel14 <- duckdb:::rel_set_alias(rel13, "lhs")
df2 <- supplier
rel15 <- duckdb:::rel_from_df(con, df2, experimental = experimental)
rel16 <- duckdb:::rel_set_alias(rel15, "rhs")
rel17 <- duckdb:::rel_join(
  rel14,
  rel16,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("l_suppkey", rel14), duckdb:::expr_reference("s_suppkey", rel16))
    )
  ),
  "inner"
)
rel18 <- duckdb:::rel_project(
  rel17,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("l_suppkey")
      duckdb:::expr_set_alias(tmp_expr, "l_suppkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("total_revenue")
      duckdb:::expr_set_alias(tmp_expr, "total_revenue")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("global_agr_key")
      duckdb:::expr_set_alias(tmp_expr, "global_agr_key")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("max_total_revenue")
      duckdb:::expr_set_alias(tmp_expr, "max_total_revenue")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_name")
      duckdb:::expr_set_alias(tmp_expr, "s_name")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_address")
      duckdb:::expr_set_alias(tmp_expr, "s_address")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_nationkey")
      duckdb:::expr_set_alias(tmp_expr, "s_nationkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_phone")
      duckdb:::expr_set_alias(tmp_expr, "s_phone")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_acctbal")
      duckdb:::expr_set_alias(tmp_expr, "s_acctbal")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_comment")
      duckdb:::expr_set_alias(tmp_expr, "s_comment")
      tmp_expr
    }
  )
)
rel19 <- duckdb:::rel_project(
  rel18,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("l_suppkey")
      duckdb:::expr_set_alias(tmp_expr, "s_suppkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_name")
      duckdb:::expr_set_alias(tmp_expr, "s_name")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_address")
      duckdb:::expr_set_alias(tmp_expr, "s_address")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("s_phone")
      duckdb:::expr_set_alias(tmp_expr, "s_phone")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("total_revenue")
      duckdb:::expr_set_alias(tmp_expr, "total_revenue")
      tmp_expr
    }
  )
)
rel19
duckdb:::rel_to_altrep(rel19)