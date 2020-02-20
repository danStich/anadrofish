#' @title Simulate number of eggs per fish
#'
#' @description Function used to simulate number of eggs 
#' produced per female (potential annual fecundity, PAF).
#'
#' @param region The life-history region for the population.
#'
#' @param max_age The maximum age of fish in the population(s).
#' A numeric vector of length 1. See \code{\link{sim_pop}} in 
#' the event that the function is called internally from \code{sim_pop}
#' 
#' @section Details:
#' The default uses predictive equations from Olney and McBride (2003) 
#' to estimate batch fecundity from weight-fecundity relationships
#' using coefficients in \code{\link{olney_mcbride}} for the life-history region
#' corresponding to the specified river. Number of batches for this
#' approach is currently drawn from a random normal distribution
#' with a mean of 6.7 and a standard deviation of 2.1 (McBride et al. 2016).
#'
#' @return A vector containing age-specific potential annual 
#' fecundity with \code{length = max_age}. 
#'
# #' @example make_eggs(region, max_age)
#'
#' @references Olney, J. E. and R. S. McBride. 2003. Intraspecific 
#' variation in batch fecundity of American shad (Alosa sapidissima): 
#' revisiting the paradigm of reciprocal latitudinal trends 
#' in reproductive traits. American Fisheries Society 
#' Symposium 35:185-192.
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
  
  # Predict fork length at age
  fl <- Linf * (1 - exp( -K*(ages-t0)))
  
  # Get length-weight regression parameters
  alpha <- length_weight$alpha[length_weight$region==region & length_weight$sex=="F"]
  beta <- length_weight$beta[length_weight$region==region & length_weight$sex=="F"]

  # Predict mass (g) from fl (mm)
  mass <- alpha * fl^beta
  
  # Calculate number of eggs
  # Based on Hudson River data (Lehman 1953)
  # if(egg_est == 'Lehman'){
  # eggs <- exp(-4.8641 + 2.8189*log(fl))
  # }
    
  # Calculate number of eggs per batch based on Olney & McBride (2003)
  # if(egg_est == 'Olney_McBride'){
    fec_alpha = olney_mcbride$alpha[olney_mcbride$region==region]
    fec_beta = olney_mcbride$beta[olney_mcbride$region==region]
    batch_size <- 10^(fec_alpha + fec_beta*log10(mass))
    
  # Draw number of batches based on McBride et al. (2016)  
    if(region=='NI'){
      n_batches <- rnorm(1, 6.7, 1)
    }
    if(region=='SI'){
      n_batches <- rnorm(1, 6.7, 1)
    }
    if(region=='SP'){
      n_batches <- rnorm(1, 6.7, 1)
    }
    
    eggs <- batch_size * n_batches
  # }
    
    return(eggs)
}

