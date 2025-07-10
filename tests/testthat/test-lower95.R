test_that("Returns numeric vector of length 1", {
  expect_type(lower95(c(1, 2, 3)), "double")
  expect_length(lower95(c(1, 2, 3)), 1)
})
