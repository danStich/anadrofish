test_that("Returns numeric vector of length max_age", {
  expect_length(
    project_pop(c(100, 30, 20),
      species = "ALE",
      nM = 0.50,
      fM = 0,
      age0 = 1000,
      max_age = 10
    ),
    10
  )

  expect_vector(
    project_pop(c(100, 30, 20),
      species = "ALE",
      nM = 0.50,
      fM = 0,
      age0 = 1000,
      max_age = 10
    )
  )

  expect_type(
    project_pop(c(100, 30, 20),
      species = "ALE",
      nM = 0.50,
      fM = 0,
      age0 = 1000,
      max_age = 10
    ),
    "double"
  )
})
