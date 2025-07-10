test_that("Numeric of length 1 greater than zero", {
  expect_length(
    make_maxage(river = "Hudson", sex = "female", species = "AMS"), 1
  )
  expect_type(
    make_maxage(river = "Hudson", sex = "female", species = "AMS"), "double"
  )
  expect_gt(
    make_maxage(river = "Hudson", sex = "female", species = "AMS"), 0
  )
})
