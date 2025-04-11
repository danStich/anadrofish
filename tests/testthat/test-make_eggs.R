test_that("Numeric vector is returned", {
  
  expect_type(make_eggs(river = "Hudson", species = "ALE"), "double")
  expect_type(make_eggs(river = "Hudson", species = "AMS"), "double")
  expect_type(make_eggs(river = "Hudson", species = "BBH"), "double")
  
})
