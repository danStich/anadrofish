test_that("Returns numeric vector of length 1", {
  
  expect_type(make_pop("BBH", 9, 0.1, 0, 100), 
              "double")
  
  expect_length(make_pop("BBH", 9, 0.1, 0, 100), 1)  
  
})
