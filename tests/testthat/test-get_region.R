test_that("Single value returned", {
  expect_length(get_region("Hudson", "BBH"), 1)
})

test_that("Character returned", {
  expect_type(get_govt("Hudson", "BBH"), "character")
})
