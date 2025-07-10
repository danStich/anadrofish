test_that("Returns numeric vector of length 1 between one and zero", {
  expect_type(sim_juvenile_s("BBH"), "double")
  expect_length(sim_juvenile_s("BBH"), 1)
  expect_gt(sim_juvenile_s("BBH"), -0.000000001)
  expect_lt(sim_juvenile_s("BBH"), 1.000000001)
})
