#' @title Simulate number of eggs per fish
#'
#' @description Function used to simulate number of eggs 
#' produced per female (potential annual fecundity, PAF).
#'
#' @param region The life-history region for the population.
#'
#' @param max_age The maximum age of fish in the population(s). A numeric vector of length 1.
#'
#' @return A vector containing age-specific potential annual 
#' fecundity with \code{length = max_age}. 
#'
# #' @example make_eggs(region, max_age)
#'
#' @references Lehman, B. A. 1953. Fecundity of Hudson River shad. 
#' US Fish and Wildlife Service, Research Reports 33:1–8.
#' 
#' @export
#'
make_eggs <- function(region, max_age){
  
  # Get growth params for region from built-in data
  growth_parms <- get(paste0('vbgf_', region))
  
  # Take one sample from posterior
  growth_parms <- growth_parms[sample(1:nrow(growth_parms), 1), ]
  Linf <- growth_parms[,1]
  K <- growth_parms[,2]
  t0 <- growth_parms[,3]
  
  # Get sequence of ages
  ages <- seq(1, max_age, 1)
  
  # Calculate fork length at age
  fl <- Linf * (1 - exp( -K*(ages-t0)))
  
  # Calculate number of eggs
  # Based on Hudson River data (Lehman 1953)
  eggs <- exp(-4.8641 + 2.8189*log(fl)) 

}

