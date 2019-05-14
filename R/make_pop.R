#' @title make_pop
#'
#' @description Function used to seed initial age-structured
#' population for simulation based on life-history
#' characteristics. Uses an initial population seed, mortality
#' estimates, and reproductive rate to populate a leslie 
#' matrix and extract stable age distribution through
#' eigen analysis with functions imported from the \code{demogR} package 
#' (Holland Jones 2007).
#'
#' @param max_age The maximum age of fish in the population(s). A numeric vector of length 1.
#'
#' @param nM Instantaneous natural mortality rate. 
#' A numeric vector of length 1.
#'
#' @param fM Instantaneous fishing mortality rate. 
#' A numeric vector of length 1.
#'
#' @param n_init Initial population abundance (includes all age classes)
#' 
#' @param f Reproductive rate (rate of replacement).
#'
#' @return A vector containing age-specific abundances 
#' with \code{length = max_age}. 
#'
#' @example inst/examples/makepop_ex.R
#'
#' @references J. Holland Jones. 2007. demogR: A package for the construction
#' and analysis of age-structured demographic models. Journal of Statistical
#' Sofware 22(10):1-28. URL: http://dx.doi.org/10.18637/jss.v022.i10.
#'
#' @export
#'

make_pop <- function(max_age, nM, fM, n_init,
                     f = c(rep(0, 2), rep(1, max_age-2))){

  # Calculate total mortality
    Z <- nM + fM

  # Survival rate
  # Annual mortality rate (A) = 1-exp(-Z)
  # lx (s) = 1 - A
    s <- rep(1-(1-exp(-Z)), max_age)

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
    pop <- c(n_init, dem$stable.age * n_init)

  # Return the result to R
    return(pop)

}
