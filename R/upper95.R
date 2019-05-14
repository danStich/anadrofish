#' @title Calculate upper 95 \% confidence limit
#'
#' @description Function with a short name to calculate 97.5th percentile
#' of a distribution. Calls \code{stats::quantile}, 
#' but is shorter and is easier to use in calls to \code{apply} family
#' of functions.
#' 
#' @param x A numeric vector or matrix.
#'
#' @return Numeric vector of length 1 containing 95% UCL for \code{x}.
#' 
#' @example inst/examples/upper95_ex.R
#' 
#' @export
#'
upper95 <- function(x){

    as.vector(quantile(x, probs = c(0.975)))

}
