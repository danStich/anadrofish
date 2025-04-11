test_that("Function returns a dataframe", {
  
  expect_s3_class(
    custom_habitat_template("BBH", built_in = TRUE, river = "Hudson"),
    "data.frame"
  )
  
})
