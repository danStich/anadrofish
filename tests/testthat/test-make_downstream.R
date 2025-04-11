test_that("Returns numeric of length 1 between 0 and 1", {
  
  expect_type(
    make_downstream(
      river = "Hudson",
      species = c("BBH"),
      downstream = 0.90,
      upstream = 1.00,
      historical = FALSE,
      custom_habitat = NULL),
  "double")
  
  expect_length(
    make_downstream(
      river = "Hudson",
      species = c("BBH"),
      downstream = 0.90,
      upstream = 1.00,
      historical = FALSE,
      custom_habitat = NULL),
    1)  
  
  expect_gt(
    make_downstream(
      river = "Hudson",
      species = c("BBH"),
      downstream = 0.90,
      upstream = 1.00,
      historical = FALSE,
      custom_habitat = NULL),
    -0.0001)    
  
  expect_lt(
    make_downstream(
      river = "Hudson",
      species = c("BBH"),
      downstream = 0.90,
      upstream = 1.00,
      historical = FALSE,
      custom_habitat = NULL),
      1.00001)    
  
})
