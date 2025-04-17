test_that("Function returns numeric vector", {
  
  expect_vector(rtrunc_norm(1, a = 0, b = 10, mean = 6.1, sd = 0.5))
  
})
