load("tools/tpch/001.rda")
con <- DBI::dbConnect(duckdb::duckdb())
experimental <- FALSE
invisible(DBI::dbExecute(con, "CREATE MACRO \"&\"(x, y) AS (x AND y)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"|\"(x, y) AS (x OR y)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"==\"(a, b) AS a = b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \">\"(a, b) AS a > b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"n\"() AS (COUNT(*))"))
invisible(
  DBI::dbExecute(con, "CREATE MACRO \"sum\"(x) AS (CASE WHEN SUM(x) IS NULL THEN 0 ELSE SUM(x) END)")
)
df1 <- customer
rel1 <- duckdb:::rel_from_df(con, df1, experimental = experimental)
rel2 <- duckdb:::rel_filter(
  rel1,
  list(
    duckdb:::expr_function(
      "&",
      list(
        duckdb:::expr_function(
          "|",
          list(
            duckdb:::expr_function(
              "|",
              list(
                duckdb:::expr_function(
                  "|",
                  list(
                    duckdb:::expr_function(
                      "|",
                      list(
                        duckdb:::expr_function(
                          "|",
                          list(
                            duckdb:::expr_function(
                              "|",
                              list(
                                duckdb:::expr_function(
                                  "==",
                                  list(
                                    if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                      duckdb:::expr_constant("13", experimental = experimental)
                                    } else {
                                      duckdb:::expr_constant("13")
                                    },
                                    duckdb:::expr_function(
                                      "substr",
                                      list(
                                        duckdb:::expr_reference("c_phone"),
                                        if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                          duckdb:::expr_constant(1L, experimental = experimental)
                                        } else {
                                          duckdb:::expr_constant(1L)
                                        },
                                        if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                          duckdb:::expr_constant(2L, experimental = experimental)
                                        } else {
                                          duckdb:::expr_constant(2L)
                                        }
                                      )
                                    )
                                  )
                                ),
                                duckdb:::expr_function(
                                  "==",
                                  list(
                                    if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                      duckdb:::expr_constant("31", experimental = experimental)
                                    } else {
                                      duckdb:::expr_constant("31")
                                    },
                                    duckdb:::expr_function(
                                      "substr",
                                      list(
                                        duckdb:::expr_reference("c_phone"),
                                        if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                          duckdb:::expr_constant(1L, experimental = experimental)
                                        } else {
                                          duckdb:::expr_constant(1L)
                                        },
                                        if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                          duckdb:::expr_constant(2L, experimental = experimental)
                                        } else {
                                          duckdb:::expr_constant(2L)
                                        }
                                      )
                                    )
                                  )
                                )
                              )
                            ),
                            duckdb:::expr_function(
                              "==",
                              list(
                                if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                  duckdb:::expr_constant("23", experimental = experimental)
                                } else {
                                  duckdb:::expr_constant("23")
                                },
                                duckdb:::expr_function(
                                  "substr",
                                  list(
                                    duckdb:::expr_reference("c_phone"),
                                    if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                      duckdb:::expr_constant(1L, experimental = experimental)
                                    } else {
                                      duckdb:::expr_constant(1L)
                                    },
                                    if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                      duckdb:::expr_constant(2L, experimental = experimental)
                                    } else {
                                      duckdb:::expr_constant(2L)
                                    }
                                  )
                                )
                              )
                            )
                          )
                        ),
                        duckdb:::expr_function(
                          "==",
                          list(
                            if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                              duckdb:::expr_constant("29", experimental = experimental)
                            } else {
                              duckdb:::expr_constant("29")
                            },
                            duckdb:::expr_function(
                              "substr",
                              list(
                                duckdb:::expr_reference("c_phone"),
                                if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                  duckdb:::expr_constant(1L, experimental = experimental)
                                } else {
                                  duckdb:::expr_constant(1L)
                                },
                                if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                  duckdb:::expr_constant(2L, experimental = experimental)
                                } else {
                                  duckdb:::expr_constant(2L)
                                }
                              )
                            )
                          )
                        )
                      )
                    ),
                    duckdb:::expr_function(
                      "==",
                      list(
                        if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                          duckdb:::expr_constant("30", experimental = experimental)
                        } else {
                          duckdb:::expr_constant("30")
                        },
                        duckdb:::expr_function(
                          "substr",
                          list(
                            duckdb:::expr_reference("c_phone"),
                            if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                              duckdb:::expr_constant(1L, experimental = experimental)
                            } else {
                              duckdb:::expr_constant(1L)
                            },
                            if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                              duckdb:::expr_constant(2L, experimental = experimental)
                            } else {
                              duckdb:::expr_constant(2L)
                            }
                          )
                        )
                      )
                    )
                  )
                ),
                duckdb:::expr_function(
                  "==",
                  list(
                    if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                      duckdb:::expr_constant("18", experimental = experimental)
                    } else {
                      duckdb:::expr_constant("18")
                    },
                    duckdb:::expr_function(
                      "substr",
                      list(
                        duckdb:::expr_reference("c_phone"),
                        if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                          duckdb:::expr_constant(1L, experimental = experimental)
                        } else {
                          duckdb:::expr_constant(1L)
                        },
                        if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                          duckdb:::expr_constant(2L, experimental = experimental)
                        } else {
                          duckdb:::expr_constant(2L)
                        }
                      )
                    )
                  )
                )
              )
            ),
            duckdb:::expr_function(
              "==",
              list(
                if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                  duckdb:::expr_constant("17", experimental = experimental)
                } else {
                  duckdb:::expr_constant("17")
                },
                duckdb:::expr_function(
                  "substr",
                  list(
                    duckdb:::expr_reference("c_phone"),
                    if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                      duckdb:::expr_constant(1L, experimental = experimental)
                    } else {
                      duckdb:::expr_constant(1L)
                    },
                    if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                      duckdb:::expr_constant(2L, experimental = experimental)
                    } else {
                      duckdb:::expr_constant(2L)
                    }
                  )
                )
              )
            )
          )
        ),
        duckdb:::expr_function(
          ">",
          list(
            duckdb:::expr_reference("c_acctbal"),
            if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
              duckdb:::expr_constant(0, experimental = experimental)
            } else {
              duckdb:::expr_constant(0)
            }
          )
        )
      )
    )
  )
)
rel3 <- duckdb:::rel_aggregate(
  rel2,
  list(),
  list(
    acctbal_min = {
      tmp_expr <- duckdb:::expr_function("mean", list(duckdb:::expr_reference("c_acctbal")))
      duckdb:::expr_set_alias(tmp_expr, "acctbal_min")
      tmp_expr
    },
    join_id = {
      tmp_expr <- if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
        duckdb:::expr_constant(1L, experimental = experimental)
      } else {
        duckdb:::expr_constant(1L)
      }
      duckdb:::expr_set_alias(tmp_expr, "join_id")
      tmp_expr
    }
  )
)
rel4 <- duckdb:::rel_from_df(con, df1, experimental = experimental)
rel5 <- duckdb:::rel_project(
  rel4,
  list(
    c_custkey = {
      tmp_expr <- duckdb:::expr_reference("c_custkey")
      duckdb:::expr_set_alias(tmp_expr, "c_custkey")
      tmp_expr
    },
    c_name = {
      tmp_expr <- duckdb:::expr_reference("c_name")
      duckdb:::expr_set_alias(tmp_expr, "c_name")
      tmp_expr
    },
    c_address = {
      tmp_expr <- duckdb:::expr_reference("c_address")
      duckdb:::expr_set_alias(tmp_expr, "c_address")
      tmp_expr
    },
    c_nationkey = {
      tmp_expr <- duckdb:::expr_reference("c_nationkey")
      duckdb:::expr_set_alias(tmp_expr, "c_nationkey")
      tmp_expr
    },
    c_phone = {
      tmp_expr <- duckdb:::expr_reference("c_phone")
      duckdb:::expr_set_alias(tmp_expr, "c_phone")
      tmp_expr
    },
    c_acctbal = {
      tmp_expr <- duckdb:::expr_reference("c_acctbal")
      duckdb:::expr_set_alias(tmp_expr, "c_acctbal")
      tmp_expr
    },
    c_mktsegment = {
      tmp_expr <- duckdb:::expr_reference("c_mktsegment")
      duckdb:::expr_set_alias(tmp_expr, "c_mktsegment")
      tmp_expr
    },
    c_comment = {
      tmp_expr <- duckdb:::expr_reference("c_comment")
      duckdb:::expr_set_alias(tmp_expr, "c_comment")
      tmp_expr
    }, {
      tmp_expr <- duckdb:::expr_function(
        "substr",
        list(
          duckdb:::expr_reference("c_phone"),
          if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
            duckdb:::expr_constant(1L, experimental = experimental)
          } else {
            duckdb:::expr_constant(1L)
          },
          if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
            duckdb:::expr_constant(2L, experimental = experimental)
          } else {
            duckdb:::expr_constant(2L)
          }
        )
      )
      duckdb:::expr_set_alias(tmp_expr, "cntrycode")
      tmp_expr
    }
  )
)
rel6 <- duckdb:::rel_project(
  rel5,
  list(
    c_custkey = {
      tmp_expr <- duckdb:::expr_reference("c_custkey")
      duckdb:::expr_set_alias(tmp_expr, "c_custkey")
      tmp_expr
    },
    c_name = {
      tmp_expr <- duckdb:::expr_reference("c_name")
      duckdb:::expr_set_alias(tmp_expr, "c_name")
      tmp_expr
    },
    c_address = {
      tmp_expr <- duckdb:::expr_reference("c_address")
      duckdb:::expr_set_alias(tmp_expr, "c_address")
      tmp_expr
    },
    c_nationkey = {
      tmp_expr <- duckdb:::expr_reference("c_nationkey")
      duckdb:::expr_set_alias(tmp_expr, "c_nationkey")
      tmp_expr
    },
    c_phone = {
      tmp_expr <- duckdb:::expr_reference("c_phone")
      duckdb:::expr_set_alias(tmp_expr, "c_phone")
      tmp_expr
    },
    c_acctbal = {
      tmp_expr <- duckdb:::expr_reference("c_acctbal")
      duckdb:::expr_set_alias(tmp_expr, "c_acctbal")
      tmp_expr
    },
    c_mktsegment = {
      tmp_expr <- duckdb:::expr_reference("c_mktsegment")
      duckdb:::expr_set_alias(tmp_expr, "c_mktsegment")
      tmp_expr
    },
    c_comment = {
      tmp_expr <- duckdb:::expr_reference("c_comment")
      duckdb:::expr_set_alias(tmp_expr, "c_comment")
      tmp_expr
    },
    cntrycode = {
      tmp_expr <- duckdb:::expr_reference("cntrycode")
      duckdb:::expr_set_alias(tmp_expr, "cntrycode")
      tmp_expr
    }, {
      tmp_expr <- if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
        duckdb:::expr_constant(1L, experimental = experimental)
      } else {
        duckdb:::expr_constant(1L)
      }
      duckdb:::expr_set_alias(tmp_expr, "join_id")
      tmp_expr
    }
  )
)
rel7 <- duckdb:::rel_set_alias(rel6, "lhs")
rel8 <- duckdb:::rel_set_alias(rel3, "rhs")
rel9 <- duckdb:::rel_project(
  rel7,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("c_custkey")
      duckdb:::expr_set_alias(tmp_expr, "c_custkey_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_name")
      duckdb:::expr_set_alias(tmp_expr, "c_name_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_address")
      duckdb:::expr_set_alias(tmp_expr, "c_address_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_nationkey")
      duckdb:::expr_set_alias(tmp_expr, "c_nationkey_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_phone")
      duckdb:::expr_set_alias(tmp_expr, "c_phone_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_acctbal")
      duckdb:::expr_set_alias(tmp_expr, "c_acctbal_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_mktsegment")
      duckdb:::expr_set_alias(tmp_expr, "c_mktsegment_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_comment")
      duckdb:::expr_set_alias(tmp_expr, "c_comment_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("cntrycode")
      duckdb:::expr_set_alias(tmp_expr, "cntrycode_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("join_id")
      duckdb:::expr_set_alias(tmp_expr, "join_id_x")
      tmp_expr
    }
  )
)
rel10 <- duckdb:::rel_project(
  rel8,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("acctbal_min")
      duckdb:::expr_set_alias(tmp_expr, "acctbal_min_y")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("join_id")
      duckdb:::expr_set_alias(tmp_expr, "join_id_y")
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
      list(duckdb:::expr_reference("join_id_x", rel9), duckdb:::expr_reference("join_id_y", rel10))
    )
  ),
  "left"
)
rel12 <- duckdb:::rel_project(
  rel11,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("c_custkey_x")
      duckdb:::expr_set_alias(tmp_expr, "c_custkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_name_x")
      duckdb:::expr_set_alias(tmp_expr, "c_name")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_address_x")
      duckdb:::expr_set_alias(tmp_expr, "c_address")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_nationkey_x")
      duckdb:::expr_set_alias(tmp_expr, "c_nationkey")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_phone_x")
      duckdb:::expr_set_alias(tmp_expr, "c_phone")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_acctbal_x")
      duckdb:::expr_set_alias(tmp_expr, "c_acctbal")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_mktsegment_x")
      duckdb:::expr_set_alias(tmp_expr, "c_mktsegment")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_comment_x")
      duckdb:::expr_set_alias(tmp_expr, "c_comment")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("cntrycode_x")
      duckdb:::expr_set_alias(tmp_expr, "cntrycode")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("join_id_x")
      duckdb:::expr_set_alias(tmp_expr, "join_id")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("acctbal_min_y")
      duckdb:::expr_set_alias(tmp_expr, "acctbal_min")
      tmp_expr
    }
  )
)
rel13 <- duckdb:::rel_filter(
  rel12,
  list(
    duckdb:::expr_function(
      "&",
      list(
        duckdb:::expr_function(
          "|",
          list(
            duckdb:::expr_function(
              "|",
              list(
                duckdb:::expr_function(
                  "|",
                  list(
                    duckdb:::expr_function(
                      "|",
                      list(
                        duckdb:::expr_function(
                          "|",
                          list(
                            duckdb:::expr_function(
                              "|",
                              list(
                                duckdb:::expr_function(
                                  "==",
                                  list(
                                    if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                      duckdb:::expr_constant("13", experimental = experimental)
                                    } else {
                                      duckdb:::expr_constant("13")
                                    },
                                    duckdb:::expr_reference("cntrycode")
                                  )
                                ),
                                duckdb:::expr_function(
                                  "==",
                                  list(
                                    if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                      duckdb:::expr_constant("31", experimental = experimental)
                                    } else {
                                      duckdb:::expr_constant("31")
                                    },
                                    duckdb:::expr_reference("cntrycode")
                                  )
                                )
                              )
                            ),
                            duckdb:::expr_function(
                              "==",
                              list(
                                if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                                  duckdb:::expr_constant("23", experimental = experimental)
                                } else {
                                  duckdb:::expr_constant("23")
                                },
                                duckdb:::expr_reference("cntrycode")
                              )
                            )
                          )
                        ),
                        duckdb:::expr_function(
                          "==",
                          list(
                            if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                              duckdb:::expr_constant("29", experimental = experimental)
                            } else {
                              duckdb:::expr_constant("29")
                            },
                            duckdb:::expr_reference("cntrycode")
                          )
                        )
                      )
                    ),
                    duckdb:::expr_function(
                      "==",
                      list(
                        if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                          duckdb:::expr_constant("30", experimental = experimental)
                        } else {
                          duckdb:::expr_constant("30")
                        },
                        duckdb:::expr_reference("cntrycode")
                      )
                    )
                  )
                ),
                duckdb:::expr_function(
                  "==",
                  list(
                    if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                      duckdb:::expr_constant("18", experimental = experimental)
                    } else {
                      duckdb:::expr_constant("18")
                    },
                    duckdb:::expr_reference("cntrycode")
                  )
                )
              )
            ),
            duckdb:::expr_function(
              "==",
              list(
                if ("experimental" %in% names(formals(duckdb:::expr_constant))) {
                  duckdb:::expr_constant("17", experimental = experimental)
                } else {
                  duckdb:::expr_constant("17")
                },
                duckdb:::expr_reference("cntrycode")
              )
            )
          )
        ),
        duckdb:::expr_function(
          ">",
          list(duckdb:::expr_reference("c_acctbal"), duckdb:::expr_reference("acctbal_min"))
        )
      )
    )
  )
)
rel14 <- duckdb:::rel_set_alias(rel13, "lhs")
df2 <- orders
rel15 <- duckdb:::rel_from_df(con, df2, experimental = experimental)
rel16 <- duckdb:::rel_set_alias(rel15, "rhs")
rel17 <- duckdb:::rel_join(
  rel14,
  rel16,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("c_custkey", rel14), duckdb:::expr_reference("o_custkey", rel16))
    )
  ),
  "anti"
)
rel18 <- duckdb:::rel_project(
  rel17,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("cntrycode")
      duckdb:::expr_set_alias(tmp_expr, "cntrycode")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_acctbal")
      duckdb:::expr_set_alias(tmp_expr, "c_acctbal")
      tmp_expr
    }
  )
)
rel19 <- duckdb:::rel_aggregate(
  rel18,
  list(duckdb:::expr_reference("cntrycode")),
  list(
    numcust = {
      tmp_expr <- duckdb:::expr_function("n", list())
      duckdb:::expr_set_alias(tmp_expr, "numcust")
      tmp_expr
    },
    totacctbal = {
      tmp_expr <- duckdb:::expr_function("sum", list(duckdb:::expr_reference("c_acctbal")))
      duckdb:::expr_set_alias(tmp_expr, "totacctbal")
      tmp_expr
    }
  )
)
rel20 <- duckdb:::rel_order(rel19, list(duckdb:::expr_reference("cntrycode")))
rel20
duckdb:::rel_to_altrep(rel20)