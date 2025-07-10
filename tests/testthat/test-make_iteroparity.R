test_that("Numeric of length 1 between zero and 1", {
  expect_length(make_iteroparity(44), 1)
  expect_type(make_iteroparity(44), "double")
  expect_gt(make_iteroparity(44), -0.000000001)
  expect_lt(make_iteroparity(44), 1.000000001)
})
