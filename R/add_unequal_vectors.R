#' @title Add vectors of unequal length
#'
#' @description Function used to add aligned vectors of unequal length. Used
#' to combine male and female cohorts when max_ages are not equal.
#'
#' @param x First vector
#'
#' @param y Second vector
#' 
#' @return A vector of length one containing pre-spawn survival. 
#'
# #' @example inst/examples/makepop_ex.R
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
