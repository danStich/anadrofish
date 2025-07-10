test_that("Function returns a data.frame", {
  expect_s3_class(get_dams("Hudson"), "data.frame")
})
