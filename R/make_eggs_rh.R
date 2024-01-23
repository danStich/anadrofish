#' @title Simulate number of eggs per fish for river herring
#'
#' @description Function used to simulate number of eggs 
#' produced per female (total fecundity) for river herring in
#' rivers included in \code{\link{get_rivers}}.
#'
#' @param river The river for which eggs will be simulated.
#' 
#' @param species Species for which population dynamics will be simulated.
#' Choices include alewife (\code{"ALE"}), and blueback herring (\code{"BBH"}).
#'
#' @section Details: NEED TO ADD DETAILS.
#'
#' @return A vector containing age-specific potential annual 
#' fecundity with \code{length = max_age}. 
#'
#' @examples make_eggs_rh(river = "Susquehanna", species = "BBH")
#'
#' @references Sullivan et al. (2019), Jessop (1993)
#' 
#' @export
#' 
make_eggs_rh <- function(river, species = c("ALE", "BBH")){
 
  # Species error handling
  if(missing(species)){
    stop("
    
    Argument 'species' must be one of 'ALE' or 'BBH'.")   
  }
  
  if(!species %in% c('ALE', 'BBH')){
    stop("
         
    Argument 'species' must be one of 'ALE' or 'BBH'.") 
  }
  
  # River error handling
  if(missing(river)){
    stop("
    
    Argument 'river' must be specified.
    
    To see a list of available rivers, run get_rivers()")    
  }
  
  if(!river %in% get_rivers(species)){
    stop("
    
    Argument 'river' must be one of those included in get_rivers().
    
    To see a list of available rivers, run get_rivers()")
  }
  
  # Get region
  region <- get_region(river = river, species = species)  
  
  # Get maximum age 
  max_age <- make_maxage(river = river, sex = "female", species = species)
  
  if(species == "ALE"){

    # Get growth params for region from built-in data
    growth_parms <- anadrofish::vbgf_ale[anadrofish::vbgf_ale$Sex == "Female", ]
    
    # Take one sample from posterior
    growth_parms <- growth_parms[sample(1:nrow(growth_parms), 1), ]
    Linf <- as.vector(growth_parms[, "linf"])
    K <- as.vector(growth_parms[, "k"])
    t0 <- as.vector(growth_parms[, "t0"])
    
    # Get sequence of ages
    ages <- seq(1, max_age, 1)
    
    # Predict total length at age
    tl <- Linf * (1 - exp( -K * (ages - t0)))
    
    # Get length-weight regression parameters
    alpha <- unlist(anadrofish::lw_pars_rh[
      anadrofish::lw_pars_rh$Region == region &
      anadrofish::lw_pars_rh$Sex == "Female" &
      anadrofish::lw_pars_rh$Species == "ALE",
      c("alpha", "alpha.se")])
      
    beta <- unlist(anadrofish::lw_pars_rh[
      anadrofish::lw_pars_rh$Region == region &
      anadrofish::lw_pars_rh$Sex == "Female" &
      anadrofish::lw_pars_rh$Species == "ALE",
      c("beta", "beta.se")])
    
    alpha <- rnorm(1, alpha[1], alpha[2])
    beta <- rnorm(1, beta[1], beta[2])
  
    # Predict mass (g) from fl (mm)
    mass <- alpha * tl ^ beta
  
    # Predict eggs per batch from length
    # Sullivan et al. 2019 (https://afspubs.onlinelibrary.wiley.com/doi/full/10.1002/nafm.10273)
    eggs <- 10^(2.994*log10(tl) - 2.045)
  }
  
  if(species == "BBH"){
    # Get growth params for region from built-in data
    growth_parms <- anadrofish::vbgf_bbh[anadrofish::vbgf_bbh$Sex == "Female", ]
    
    # Take one sample from posterior
    growth_parms <- growth_parms[sample(1:nrow(growth_parms), 1), ]
    Linf <- as.vector(growth_parms[, "linf"])
    K <- as.vector(growth_parms[, "k"])
    t0 <- as.vector(growth_parms[, "t0"])
    
    # Get sequence of ages
    ages <- seq(1, max_age, 1)
    
    # Predict total length at age
    tl <- Linf * (1 - exp( -K * (ages - t0)))
    
    # Convert total length to fork length for Jessop(1993) equations
    fl_tl <- anadrofish::fl_tl_conversions[anadrofish::fl_tl_conversions$species == "BBH", ]
    alpha_fl_samp <- rnorm(1, fl_tl[, "alpha"], fl_tl[, "alpha.se"])
    beta_fl_samp <- rnorm(1, fl_tl[, "beta"], fl_tl[, "beta.se"])
    fl <- (tl - alpha_fl_samp)/beta_fl_samp
    
    # Sample parameters from jessop_1993 and use to calculate fecundity at age
    alpha_fec <- anadrofish::jessop_1993[, "alpha"]
    beta_fec <- anadrofish::jessop_1993[, "beta"]

    # Predict eggs per batch from length
    eggs <- vector(mode = "list", length = length(alpha_fec))
    for(i in 1:length(alpha_fec)){
      eggs[[i]] <- (10 ^ (alpha_fec[i] + beta_fec[i]*log10(fl)))*1000
    }
    
    eggs <- apply(do.call(rbind, eggs), 2, mean)
      
  }  
  
  return(eggs)
  
}
