qloadm("tools/tpch/001.qs")
con <- DBI::dbConnect(duckdb::duckdb())
experimental <- FALSE
invisible(DBI::dbExecute(con, "CREATE MACRO \"&\"(x, y) AS (x AND y)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"|\"(x, y) AS (x OR y)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"==\"(a, b) AS a = b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \">\"(a, b) AS a > b"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"___coalesce\"(a, b) AS COALESCE(a, b)"))
invisible(DBI::dbExecute(con, "CREATE MACRO \"n\"() AS (COUNT(*))"))
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
  groups = list(),
  aggregates = list(
    {
      tmp_expr <- duckdb:::expr_function("mean", list(duckdb:::expr_reference("c_acctbal")))
      duckdb:::expr_set_alias(tmp_expr, "acctbal_min")
      tmp_expr
    },
    {
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
rel4 <- duckdb:::rel_distinct(rel3)
rel5 <- duckdb:::rel_from_df(con, df1, experimental = experimental)
rel6 <- duckdb:::rel_project(
  rel5,
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
rel7 <- duckdb:::rel_project(
  rel6,
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
      tmp_expr <- duckdb:::expr_reference("cntrycode")
      duckdb:::expr_set_alias(tmp_expr, "cntrycode")
      tmp_expr
    },
    {
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
rel8 <- duckdb:::rel_set_alias(rel7, "lhs")
rel9 <- duckdb:::rel_set_alias(rel4, "rhs")
rel10 <- duckdb:::rel_project(
  rel8,
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
rel11 <- duckdb:::rel_project(
  rel9,
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
rel12 <- duckdb:::rel_project(
  rel10,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("c_custkey_x")
      duckdb:::expr_set_alias(tmp_expr, "c_custkey_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_name_x")
      duckdb:::expr_set_alias(tmp_expr, "c_name_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_address_x")
      duckdb:::expr_set_alias(tmp_expr, "c_address_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_nationkey_x")
      duckdb:::expr_set_alias(tmp_expr, "c_nationkey_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_phone_x")
      duckdb:::expr_set_alias(tmp_expr, "c_phone_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_acctbal_x")
      duckdb:::expr_set_alias(tmp_expr, "c_acctbal_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_mktsegment_x")
      duckdb:::expr_set_alias(tmp_expr, "c_mktsegment_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("c_comment_x")
      duckdb:::expr_set_alias(tmp_expr, "c_comment_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("cntrycode_x")
      duckdb:::expr_set_alias(tmp_expr, "cntrycode_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("join_id_x")
      duckdb:::expr_set_alias(tmp_expr, "join_id_x")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_window(duckdb:::expr_function("row_number", list()), list(), list(), offset_expr = NULL, default_expr = NULL)
      duckdb:::expr_set_alias(tmp_expr, "___row_number_x")
      tmp_expr
    }
  )
)
rel13 <- duckdb:::rel_project(
  rel11,
  list(
    {
      tmp_expr <- duckdb:::expr_reference("acctbal_min_y")
      duckdb:::expr_set_alias(tmp_expr, "acctbal_min_y")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("join_id_y")
      duckdb:::expr_set_alias(tmp_expr, "join_id_y")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_window(duckdb:::expr_function("row_number", list()), list(), list(), offset_expr = NULL, default_expr = NULL)
      duckdb:::expr_set_alias(tmp_expr, "___row_number_y")
      tmp_expr
    }
  )
)
rel14 <- duckdb:::rel_join(
  rel12,
  rel13,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("join_id_x", rel12), duckdb:::expr_reference("join_id_y", rel13))
    )
  ),
  "left"
)
rel15 <- duckdb:::rel_order(
  rel14,
  list(duckdb:::expr_reference("___row_number_x", rel12), duckdb:::expr_reference("___row_number_y", rel13))
)
rel16 <- duckdb:::rel_project(
  rel15,
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
      tmp_expr <- duckdb:::expr_function(
        "___coalesce",
        list(duckdb:::expr_reference("join_id_x", rel12), duckdb:::expr_reference("join_id_y", rel13))
      )
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
rel17 <- duckdb:::rel_filter(
  rel16,
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
rel18 <- duckdb:::rel_set_alias(rel17, "lhs")
df2 <- orders
rel19 <- duckdb:::rel_from_df(con, df2, experimental = experimental)
rel20 <- duckdb:::rel_set_alias(rel19, "rhs")
rel21 <- duckdb:::rel_project(
  rel18,
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
      tmp_expr <- duckdb:::expr_reference("cntrycode")
      duckdb:::expr_set_alias(tmp_expr, "cntrycode")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("join_id")
      duckdb:::expr_set_alias(tmp_expr, "join_id")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("acctbal_min")
      duckdb:::expr_set_alias(tmp_expr, "acctbal_min")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_window(duckdb:::expr_function("row_number", list()), list(), list(), offset_expr = NULL, default_expr = NULL)
      duckdb:::expr_set_alias(tmp_expr, "___row_number_x")
      tmp_expr
    }
  )
)
rel22 <- duckdb:::rel_join(
  rel21,
  rel20,
  list(
    duckdb:::expr_function(
      "==",
      list(duckdb:::expr_reference("c_custkey", rel21), duckdb:::expr_reference("o_custkey", rel20))
    )
  ),
  "anti"
)
rel23 <- duckdb:::rel_order(rel22, list(duckdb:::expr_reference("___row_number_x", rel21)))
rel24 <- duckdb:::rel_project(
  rel23,
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
      tmp_expr <- duckdb:::expr_reference("cntrycode")
      duckdb:::expr_set_alias(tmp_expr, "cntrycode")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("join_id")
      duckdb:::expr_set_alias(tmp_expr, "join_id")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_reference("acctbal_min")
      duckdb:::expr_set_alias(tmp_expr, "acctbal_min")
      tmp_expr
    }
  )
)
rel25 <- duckdb:::rel_project(
  rel24,
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
rel26 <- duckdb:::rel_aggregate(
  rel25,
  groups = list(duckdb:::expr_reference("cntrycode")),
  aggregates = list(
    {
      tmp_expr <- duckdb:::expr_function("n", list())
      duckdb:::expr_set_alias(tmp_expr, "numcust")
      tmp_expr
    },
    {
      tmp_expr <- duckdb:::expr_function("sum", list(duckdb:::expr_reference("c_acctbal")))
      duckdb:::expr_set_alias(tmp_expr, "totacctbal")
      tmp_expr
    }
  )
)
rel27 <- duckdb:::rel_order(rel26, list(duckdb:::expr_reference("cntrycode")))
rel27
duckdb:::rel_to_altrep(rel27)