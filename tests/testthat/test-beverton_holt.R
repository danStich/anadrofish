test_that("Recruitment function returns correct type", {
  expect_type(
    beverton_holt(
      a = 250000,
      S = 100,
      b = 0.21904,
      acres = 1,
      error = c("multiplicative", "additive"),
      age_structured = FALSE
    ),
    "double"
  )
})
