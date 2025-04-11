test_that("Returns numeric vector", {
  
  expect_type(
    make_mortality(river = "Hudson", sex = "female", species = "BBH"), 
    "double")
  expect_vector(
    make_mortality(river = "Hudson", sex = "female", species = "BBH"))
  
})
