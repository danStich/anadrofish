test_that("Numeric of length 1 between zero and 90", {
  
  expect_length(make_lat(river = "Hudson", species = "AMS"), 1)
  expect_type(make_lat(river = "Hudson", species = "AMS"), "double")
  expect_gt(make_lat(river = "Hudson", species = "AMS"), 0)
  expect_lt(make_lat(river = "Hudson", species = "AMS"),  90)
  
})
