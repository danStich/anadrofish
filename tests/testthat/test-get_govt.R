test_that("Single value returned", {
  expect_length(get_govt("Hudson", "ALE"), 1)
})

test_that("Character returned", {
  expect_type(get_govt("Hudson", "ALE"), "character")
})
