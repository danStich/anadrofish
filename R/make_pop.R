#' @title make_pop
#'
#' @description Function used to seed initial
#' populations for simulation based on life-history
#' characteristics and stable age distributions
#'
#' @param max_age The maximum age of fish in the population(s). A numeric vector of length 1.
#'
#' @param nM Instantaneous natural mortality rate. A numeric vector of length 1.
#'
#' @param fM Instantaneous fishing mortality rate. A numeric vector of length 1.
#'
#' @param n_init Initial population abundance (includes all age classes)
#'
#' @return A vector containing age-specific abundances. A numeric vector with length = max_age.
#'
#' @references None yet.
#'
#' @export
#'

make_pop <- function(max_age = 11, nM = 0.38, fM = 0.0, n_init=1e5){

  # Calculate total mortality
    Z <- nM + fM

  # Survival rate
    s <- rep((1-exp(-Z)), max_age)

  # Fecundity
  ### Needs some thought
  ### Could initialize here and then have user-defined
  ### values in a later function?

  # Reproductive rate
    f <- c(rep(0, 2), rep(1, max_age-2))

  # Make a Leslie matrix for projection
    les <- leslie.matrix(
      lx=cumprod(s),
      mx=f
      )

  # Calculate asymptotic growth
  # rate and related quantities
    dem <- eigen.analysis(les)

  # Multiply stable age dist
  # by an arbitrarily large
  # number to get a population
    pop <- dem$stable.age * n_init

  # Return the result to R
    return(pop)

}