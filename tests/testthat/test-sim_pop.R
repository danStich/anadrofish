test_that("Function returning output", {
  
  expect_s3_class(sim_pop(species = "BBH", nyears = 2, river = "Hudson"),
                  "data.frame")
  
})
