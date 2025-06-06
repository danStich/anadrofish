#' @title Simulate random samples from truncated normal distribution
#'
#' @description Simulate random draws from a truncated normal distribution based
#' using inverse cumulative distribution function for normal distribution.
#'
#' @param n Number of random samples
#' 
#' @param a Lower bound(s)
#' 
#' @param b Upper bound(s)
#' 
#' @param mean Mean(s)
#' 
#' @param sd Standard deviation(s)
#' 
#' @details This approach is an approximation based on the normal distribution 
#' for case application to tested uses in the `anadrofish` package. It should
#' not be considered a generalized solution. This function is used to replace
#' the \code{rtruncnorm} function from the \code{truncnorm} package to eliminate
#' need for compilation in the \code{anadrofish} package and eliminate
#' dependency on \code{truncnorm} (which requires compilation).
#' 
#' @examples rtrunc_norm(n = 1, a = 0, b = Inf, mean = 6.1, sd = 0.5)
#' 
#' @references Answers by Glen_b and JohannesNE to this post on Cross Validated:
#' https://stats.stackexchange.com/questions/56747/simulate-constrained-normal-on-lower-or-upper-bound-in-r
#' were helpful.
#' 
#' @export
#' 
rtrunc_norm <- function(n, a = -Inf, b = Inf, mean, sd) {
  
  # Get quantiles corresponding to lower and upper bounds
  p_low <- stats::pnorm(a, mean, sd)
  p_high <- stats::pnorm(b, mean, sd)
  
  # Draw quantiles uniformly between bounds and pass to qnorm().
  stats::qnorm(stats::runif(n, p_low, p_high), mean, sd)
  
}
