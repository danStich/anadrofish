test_that("Return numeric vector with values between 0 and 1", {
  expect_gt(
    min(make_spawnrecruit_rh(river = "Hudson", sex = "female", species = "BBH")),
    -0.0000000001
  )
  expect_lt(
    max(make_spawnrecruit_rh(river = "Hudson", sex = "female", species = "BBH")),
    1.0000000001
  )
  expect_vector(
    make_spawnrecruit_rh(river = "Hudson", sex = "female", species = "BBH")
  )
  expect_type(
    make_spawnrecruit_rh(river = "Hudson", sex = "female", species = "BBH"),
    "double"
  )
})
