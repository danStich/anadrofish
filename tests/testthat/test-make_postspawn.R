test_that("Returns numeric of length 1", {
  
  expect_length(make_postspawn(river = "Hudson", species = "AMS"), 1)
  expect_type(make_postspawn(river = "Hudson", species = "AMS"), 'double')
  
})
