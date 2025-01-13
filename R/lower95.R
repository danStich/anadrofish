#' @title Calculate lower 95 \% confidence limit
#'
#' @description Function with a short name to calculate 2.5th percentile
#' of a distribution. Calls \code{stats::quantile(x)}, 
#' but is shorter and is easier to use in calls to \code{apply} family
#' of functions.
#' 
#' @param x A numeric vector or matrix.
#'
#' @return Numeric vector of length 1 containing the 2.5th percentile of the sampling distribution for \code{x}.
#' 
#' @example inst/examples/lower95_ex.R
#' 
#' @export
#'
lower95 <- function(x){

  as.vector(quantile(x, probs = c(0.025)))

}
