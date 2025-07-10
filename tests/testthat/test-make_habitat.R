test_that("Returns numeric of length 1", {
  expect_length(
    make_habitat(river = "Hudson", species = "AMS", upstream = 0.50), 1
  )
  expect_type(
    make_habitat(river = "Hudson", species = "AMS", upstream = 0.50), "double"
  )
})
