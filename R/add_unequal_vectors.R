#' @title Add vectors of unequal length
#'
#' @description Function used to add aligned vectors of unequal length without
#' recycling elements of the shorter vector. Used to combine male and
#' female cohorts when \code{max_age} is not equal in
#' the \code{\link{max_ages}} dataset.
#'
#' @param x,y Paired numeric vectors of same or different length.
#'
#' @return A vector of length one containing pre-spawn survival.
#'
#' @examples
#' x <- c(1, 2)
#' y <- c(1, 2, 3)
#' add_unequal_vectors(x, y)
#'
#' @references https://stackoverflow.com/questions/2307443/how-to-add-two-vectors-without-repeating-in-r
#'
#' @export
#'
add_unequal_vectors <- function(x, y) {
  l <- max(length(x), length(y))
  length(x) <- l
  length(y) <- l
  x[is.na(x)] <- 0
  y[is.na(y)] <- 0
  x + y
}
