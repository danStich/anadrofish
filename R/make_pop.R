#' @title Make population
#'
#' @description Function used to seed initial age-structured
#' population for simulation based on life-history
#' characteristics. Uses an initial population seed, mortality
#' estimates, and maximum age to create a starting population.
#'
#' @param species Species for which population dynamics will be simulated.
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#'
#' @param max_age The maximum age of fish in the population(s). A numeric vector of length 1.
#'
#' @param nM Instantaneous natural mortality rate.
#' A numeric vector of length for (\code{"AMS"} or a vector of
#' length \code{max_age} for \code{"ALE"} and \code{"BBH"}.
#'
#' @param fM Instantaneous fishing mortality rate.
#' A numeric vector of length 1.
#'
#' @param n_init Initial population abundance (includes all age classes).
#'
#' @return A vector containing age-specific abundances
#' with \code{length = max_age}.
#'
#' @example inst/examples/makepop_ex.R
#'
#' @export
#'
make_pop <- function(species, max_age, nM, fM, n_init) {
  # Calculate total mortality
  Z <- nM + fM

  # Survival rate
  # Annual mortality rate (A) = 1-exp(-Z)
  # s = 1 - A
  if (species == "AMS") {
    s <- rep(1 - (1 - exp(-Z)), max_age)
    s[1] <- (1 - (1 - exp(-nM)))^4
  }

  if (species %in% c("ALE", "BBH")) {
    s <- 1 - (1 - exp(-Z))
  }

  # Multiply by an arbitrarily large
  # number to get a population
  pop <- n_init * cumprod(s)

  # Return the result to R
  return(pop)
}
