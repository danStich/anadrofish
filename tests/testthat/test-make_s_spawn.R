test_that("Numeric vector of length 1", {
  
  expect_length(make_s_spawn(0.68, 0.92), 1)
  expect_vector(make_s_spawn(0.68, 0.92))
  expect_type(make_s_spawn(0.68, 0.92), "double")
  
})
