#' @title Beverton and Holt (1957) stock-recruit curve 
#' with habitat constraints
#'
#' @description Beverton-Holt stock recruitment model. Default parameter
#' values are tuned to predict age-0 recruitment assuming a carrying 
#' capacity for spawning adults of 100 fish per acre. See "\bold{Uses}" below.
#'
#' @param a Ratio of recruits per spawner. Density independent parameter
#'  equivelant to the slope near \code{S = 0}. By default specified as
#'  realized annual fecundity.
#'
#' @param S Spawning stock abundance per acre.
#' Numeric vector with single or multiple elements.
#'
#' @param b Density-dependent parameter. By default specified on a per-acre
#' basis (will be divided by \code{acres} in function)
#'
#' @param error Character string indicating whether to use
#'  \code{'additive'} or \code{'multiplicative'} error structure.
#'
#' @return A numeric vector with one or more elements representing
#'  age-0 recruits (downstream migrants in freshwater) per unit of 
#'  habitat
#'
#' @section Uses:
#' The primary use of this function in the \code{anadrofish} package
#' is to predict number of age-0 recruits in a river based on the number of
#' fish within a functional habitat unit, and the number of surface acres 
#' of habitat in the same unit.However, the number of potential uses is
#' flexible. For example, passing a single value to each argument would 
#' result calculation of a single recruitment value. But, passing a vector
#' to one of the four default arguments allows the user to explore values
#' of recruitment over a range of each input. Under the current
#' implementation, only a single argument may accept more than one value
#' at a time. Otherwise, we recommend conducting more in-depth sensitivity
#' explorations by use of single values applied under a boot-strapping, or
#' Monte Carlo approach with the function.
#'
#' @example inst/examples/bevholt_ex.R
#'
#' @references Beverton, R. J. H. and S. J. Holt. 1957. On the Dynamics
#'  of Exploited Fish Populations, Fisheries Investigations (Series 2), 
#'  Volume 19. United Kingdom Ministry of Agriculture and Fisheries, 533 pp.
#'
#' @export
#'
beverton_holt <- function(a = 2.5e5,
                          S = 1,
                          b = 0.340297,
                          acres = 1,
                          error='multiplicative'
                          )
  {
  
    b = b/acres
  
    if(error=='additive'){
    
      r <- a * S/(1 + b * S)
      
      return(r)
      
      } else {
        
        if(error=='multiplicative'){
          
          log_r <- log(a * S/(1 + b * S))
          return(exp(log_r))         
          
        } else {
          
          stop('Invalid error specification. 
               Must be character string indicating \"additive\" or 
               \"multiplicative" error structure.
               ')
          
        }
       
      }
  
  }

