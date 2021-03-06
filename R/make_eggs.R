#' @title Simulate number of eggs per fish
#'
#' @description Function used to simulate number of eggs 
#' produced per female (potential annual fecundity, PAF),
#' for rivers included in \code{\link{get_rivers}}.
#'
#' @param river The river for which eggs will be simulated.
#'
#' @section Details:
#' The default uses predictive equations from Olney and McBride (2003) 
#' to simulate batch fecundity from weight-fecundity relationships
#' using coefficients in \code{\link{olney_mcbride}} for the life-history region
#' corresponding to the specified river. Number of batches for this
#' approach is currently drawn from a random normal distribution
#' with a mean of 6.7 and a standard deviation of 2.1 (McBride et al. 2016).
#'
#' @return A vector containing age-specific potential annual 
#' fecundity with \code{length = max_age}. 
#'
#' @examples make_eggs(river="Susquehanna")
#'
#' @references Olney, J. E. and R. S. McBride. 2003. Intraspecific 
#' variation in batch fecundity of American shad (Alosa sapidissima): 
#' revisiting the paradigm of reciprocal latitudinal trends 
#' in reproductive traits. American Fisheries Society 
#' Symposium 35:185-192.
#' 
#' McBride, R. S., R. Ferreri, E. K. Towle, J. M. Boucher, and 
#' G. Basilone, G. 2016. Yolked oocyte dynamics support agreement 
#' between determinate- and indeterminate-method estimates of annual 
#' fecundity for a northeastern United States population of 
#' American shad. PLoS ONE 11(10): 10.1371/journal.pone.0164203
#' 
#' @export
#'
#' @importFrom truncnorm rtruncnorm
#' 
make_eggs <- function(river){
  
  if(missing(river)){
    stop("
    
    Argument 'river' must be specified.
    
    To see a list of available rivers, run get_rivers()")    
  }
  
  if(!river %in% get_rivers()){
    stop("
    
    Argument 'river' must be one of those included in get_rivers().
    
    To see a list of available rivers, run get_rivers()")
  }
  
  # Get region
  region <- unique(anadrofish::habitat$region[
    anadrofish::habitat$system==river])
  
  # Get maximum age 
  max_age <- anadrofish::max_ages$maxage[
    anadrofish::max_ages$region==region & 
    anadrofish::max_ages$sex=='F']
  
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
  alpha <- anadrofish::length_weight$alpha[
    anadrofish::length_weight$region==region &
    anadrofish::length_weight$sex=="F"]
  beta <- anadrofish::length_weight$beta[
    anadrofish::length_weight$region==region & 
    anadrofish::length_weight$sex=="F"]

  # Predict mass (g) from fl (mm)
  mass <- alpha * fl^beta

  # Calculate number of eggs per batch based on Olney & McBride (2003)
  fec_alpha = anadrofish::olney_mcbride$alpha[
    anadrofish::olney_mcbride$region==region]
  fec_beta = anadrofish::olney_mcbride$beta[
    anadrofish::olney_mcbride$region==region]
  batch_size <- 10^(fec_alpha + fec_beta*log10(mass))
    
  # Draw number of batches based on McBride et al. (2016)  
  if(region=='NI'){
    n_batches <- rtruncnorm(1, a=0, b=10, mean=6.1, sd=.5)
  }
  if(region=='SI'){
    n_batches <- rtruncnorm(1, a=0, b=12, mean=6.1, sd=.5)
  }
  if(region=='SP'){
    n_batches <- rtruncnorm(1, a=0, b=Inf, mean=6.1, sd=.5)
  }
    
    eggs <- batch_size * n_batches

    return(eggs)
}

