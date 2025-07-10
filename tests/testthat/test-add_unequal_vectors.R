test_that("Element-wise addition returns length of longer vector", {
  expect_length(
    add_unequal_vectors(c(1, 2, 3, 4, 5), c(1, 2, 3)),
    n = 5
  )
})

test_that("Adding unequal vectors does not return warning", {
  expect_no_warning(add_unequal_vectors(c(1, 2, 3, 4, 5), c(1, 2, 3)))
})
