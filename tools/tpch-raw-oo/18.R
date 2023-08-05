qloadm("tools/tpch/001.qs")
con <- DBI::dbConnect(duckdb::duckdb())
experimental <- FALSE
invisible(DBI::dbExecute(con, "CREATE MACRO \">\"(a, b) AS a > b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"==\"(a, b) AS a = b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"___coalesce\"(a, b) AS COALESCE(a, b)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"desc\"(x) AS (-x)"))
df1 <- lineitem
rel1 <- duckdb:::rel_from_df(con, df1, experimental = experimental)
rel2 <- duckdb:::rel_aggregate(
  rel1,
  groups = list(duckdb:::expr_reference("l_orderkey")),
  aggregates = list(
    {
      tmp_expr <- duckdb:::expr_function("sum", list(duckdb:::expr_reference("l_quantity")))
      duckdb:::expr_set_alias(tmp_expr, "sum")
      tmp_expr
    }
  )
)
rel3 <- duckdb:::rel_filter(
  rel2,
  list(
    duckdb:::expr_function(
      ">",
      list(
        duckdb:::expr_reference("sum"),
        if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
          duckdb:::expr_constant(300, experimental = experimental)
        } else {
          duckdb:::expr_constant(300)
        }
      )
    )
  )
)
df2 <- orders
rel4 <- duckdb:::rel_from_df(con, df2, experimental = experimental)
rel5 <- duckdb:::rel_set_alias(rel4, "lhs")
rel6 <- duckdb:::rel_set_alias(rel3, "rhs")
rel7 <- duckdb:::rel_project(
  rel5,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("o_orderkey")
      duckdb:::expr_set_alias(tmp_expr, "o_orderkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_custkey")
      duckdb:::expr_set_alias(tmp_expr, "o_custkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderstatus")
      duckdb:::expr_set_alias(tmp_expr, "o_orderstatus")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_totalprice")
      duckdb:::expr_set_alias(tmp_expr, "o_totalprice")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderdate")
      duckdb:::expr_set_alias(tmp_expr, "o_orderdate")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderpriority")
      duckdb:::expr_set_alias(tmp_expr, "o_orderpriority")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_clerk")
      duckdb:::expr_set_alias(tmp_expr, "o_clerk")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_shippriority")
      duckdb:::expr_set_alias(tmp_expr, "o_shippriority")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_comment")
      duckdb:::expr_set_alias(tmp_expr, "o_comment")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_window(duckdb:::expr_function("row_number", list()), list(), list(), offset_expr = NULL, default_expr = NULL)
      duckdb:::expr_set_alias(tmp_expr, "___row_number_x")
      tmp_expr
    }
  )
)
rel8 <- duckdb:::rel_project(
  rel6,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("l_orderkey")
      duckdb:::expr_set_alias(tmp_expr, "l_orderkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("sum")
      duckdb:::expr_set_alias(tmp_expr, "sum")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_window(duckdb:::expr_function("row_number", list()), list(), list(), offset_expr = NULL, default_expr = NULL)
      duckdb:::expr_set_alias(tmp_expr, "___row_number_y")
      tmp_expr
    }
  )
)
rel9 <- duckdb:::rel_join(
  rel7,
  rel8,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("o_orderkey", rel7), duckdb:::expr_reference("l_orderkey", rel8))
    )
  ),
  "inner"
)
rel10 <- duckdb:::rel_order(
  rel9,
  list(duckdb:::expr_reference("___row_number_x", rel7), duckdb:::expr_reference("___row_number_y", rel8))
)
rel11 <- duckdb:::rel_project(
  rel10,
  list(
    {
      tmp_expr <- duckdb:::expr_function(
        "___coalesce",
        list(duckdb:::expr_reference("o_orderkey", rel7), duckdb:::expr_reference("l_orderkey", rel8))
      )
      duckdb:::expr_set_alias(tmp_expr, "o_orderkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_custkey")
      duckdb:::expr_set_alias(tmp_expr, "o_custkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderstatus")
      duckdb:::expr_set_alias(tmp_expr, "o_orderstatus")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_totalprice")
      duckdb:::expr_set_alias(tmp_expr, "o_totalprice")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderdate")
      duckdb:::expr_set_alias(tmp_expr, "o_orderdate")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderpriority")
      duckdb:::expr_set_alias(tmp_expr, "o_orderpriority")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_clerk")
      duckdb:::expr_set_alias(tmp_expr, "o_clerk")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_shippriority")
      duckdb:::expr_set_alias(tmp_expr, "o_shippriority")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_comment")
      duckdb:::expr_set_alias(tmp_expr, "o_comment")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("sum")
      duckdb:::expr_set_alias(tmp_expr, "sum")
      tmp_expr
    }
  )
)
rel12 <- duckdb:::rel_set_alias(rel11, "lhs")
df3 <- customer
rel13 <- duckdb:::rel_from_df(con, df3, experimental = experimental)
rel14 <- duckdb:::rel_set_alias(rel13, "rhs")
rel15 <- duckdb:::rel_project(
  rel12,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("o_orderkey")
      duckdb:::expr_set_alias(tmp_expr, "o_orderkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_custkey")
      duckdb:::expr_set_alias(tmp_expr, "o_custkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderstatus")
      duckdb:::expr_set_alias(tmp_expr, "o_orderstatus")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_totalprice")
      duckdb:::expr_set_alias(tmp_expr, "o_totalprice")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderdate")
      duckdb:::expr_set_alias(tmp_expr, "o_orderdate")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderpriority")
      duckdb:::expr_set_alias(tmp_expr, "o_orderpriority")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_clerk")
      duckdb:::expr_set_alias(tmp_expr, "o_clerk")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_shippriority")
      duckdb:::expr_set_alias(tmp_expr, "o_shippriority")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_comment")
      duckdb:::expr_set_alias(tmp_expr, "o_comment")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("sum")
      duckdb:::expr_set_alias(tmp_expr, "sum")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_window(duckdb:::expr_function("row_number", list()), list(), list(), offset_expr = NULL, default_expr = NULL)
      duckdb:::expr_set_alias(tmp_expr, "___row_number_x")
      tmp_expr
    }
  )
)
rel16 <- duckdb:::rel_project(
  rel14,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("c_custkey")
      duckdb:::expr_set_alias(tmp_expr, "c_custkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_name")
      duckdb:::expr_set_alias(tmp_expr, "c_name")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_address")
      duckdb:::expr_set_alias(tmp_expr, "c_address")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_nationkey")
      duckdb:::expr_set_alias(tmp_expr, "c_nationkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_phone")
      duckdb:::expr_set_alias(tmp_expr, "c_phone")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_acctbal")
      duckdb:::expr_set_alias(tmp_expr, "c_acctbal")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_mktsegment")
      duckdb:::expr_set_alias(tmp_expr, "c_mktsegment")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_comment")
      duckdb:::expr_set_alias(tmp_expr, "c_comment")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_window(duckdb:::expr_function("row_number", list()), list(), list(), offset_expr = NULL, default_expr = NULL)
      duckdb:::expr_set_alias(tmp_expr, "___row_number_y")
      tmp_expr
    }
  )
)
rel17 <- duckdb:::rel_join(
  rel15,
  rel16,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("o_custkey", rel15), duckdb:::expr_reference("c_custkey", rel16))
    )
  ),
  "inner"
)
rel18 <- duckdb:::rel_order(
  rel17,
  list(duckdb:::expr_reference("___row_number_x", rel15), duckdb:::expr_reference("___row_number_y", rel16))
)
rel19 <- duckdb:::rel_project(
  rel18,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("o_orderkey")
      duckdb:::expr_set_alias(tmp_expr, "o_orderkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_function(
        "___coalesce",
        list(duckdb:::expr_reference("o_custkey", rel15), duckdb:::expr_reference("c_custkey", rel16))
      )
      duckdb:::expr_set_alias(tmp_expr, "o_custkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderstatus")
      duckdb:::expr_set_alias(tmp_expr, "o_orderstatus")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_totalprice")
      duckdb:::expr_set_alias(tmp_expr, "o_totalprice")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderdate")
      duckdb:::expr_set_alias(tmp_expr, "o_orderdate")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderpriority")
      duckdb:::expr_set_alias(tmp_expr, "o_orderpriority")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_clerk")
      duckdb:::expr_set_alias(tmp_expr, "o_clerk")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_shippriority")
      duckdb:::expr_set_alias(tmp_expr, "o_shippriority")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_comment")
      duckdb:::expr_set_alias(tmp_expr, "o_comment")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("sum")
      duckdb:::expr_set_alias(tmp_expr, "sum")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_name")
      duckdb:::expr_set_alias(tmp_expr, "c_name")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_address")
      duckdb:::expr_set_alias(tmp_expr, "c_address")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_nationkey")
      duckdb:::expr_set_alias(tmp_expr, "c_nationkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_phone")
      duckdb:::expr_set_alias(tmp_expr, "c_phone")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_acctbal")
      duckdb:::expr_set_alias(tmp_expr, "c_acctbal")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_mktsegment")
      duckdb:::expr_set_alias(tmp_expr, "c_mktsegment")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_comment")
      duckdb:::expr_set_alias(tmp_expr, "c_comment")
      tmp_expr
    }
  )
)
rel20 <- duckdb:::rel_project(
  rel19,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("c_name")
      duckdb:::expr_set_alias(tmp_expr, "c_name")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_custkey")
      duckdb:::expr_set_alias(tmp_expr, "c_custkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderkey")
      duckdb:::expr_set_alias(tmp_expr, "o_orderkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_orderdate")
      duckdb:::expr_set_alias(tmp_expr, "o_orderdate")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("o_totalprice")
      duckdb:::expr_set_alias(tmp_expr, "o_totalprice")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("sum")
      duckdb:::expr_set_alias(tmp_expr, "sum")
      tmp_expr
    }
  )
)
rel21 <- duckdb:::rel_order(
  rel20,
  list(duckdb:::expr_function("desc", list(duckdb:::expr_reference("o_totalprice"))), duckdb:::expr_reference("o_orderdate"))
)
rel22 <- duckdb:::rel_limit(rel21, 100)
rel22
duckdb:::rel_to_altrep(rel22)