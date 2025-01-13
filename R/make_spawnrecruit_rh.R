#' @title Make spawnrecruit vectors for river herring
#'
#' @description Simulate proportion of population that is mature
#' spawners from sex-specific maturity schedules for river herring
#' in \code{\link{maki_pars}}.
#'
#' @details The primary use of this function is to simulate proportion of
#' mature spawners at each age in a population of river-herring based on 
#' region-specific probabilities of maturation at each age estimated
#' from the Maki (YEAR) method in ASMFC (2024).
#' 
#' @param species A character indicating species of river herring, either
#' \code{"ALE"} for alewife or \code{"BBH"} for blueback herring.
#'
#' @param river River for which maximum age is needed.
#' 
#' @param sex A character indicating \code{"male"}, \code{"female"},
#' or \code{"Pooled"} sex for fish.
#' 
#' @param custom_habitat A dataframe containing columns corresponding to the
#' those in the output from \code{\link{custom_habitat_template}}. The default,
#' \code{NULL} uses the default habitat data set for a given combination of
#' \code{species} and \code{river}.
#' 
#' @return A numeric vector containing a single realization for proportion
#' of mature fish at each age, from age 1 to maximum age.
#'
#' @references Atlantic States Marine Fisheries Commission. 2024. River herring
#' benchmark stock assessment and peer-review report. ASMFC, Arlington, VA. 
#' URL: https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf
#'
#' @examples make_spawnrecruit_rh(river = "Upper Hudson", species = "BBH", sex = "female")
#'
#' @export
#'
make_spawnrecruit_rh <- function(river,
                                 sex = c('male', 'female'),
                                 species = c('ALE', 'BBH'),
                                 custom_habitat = NULL){
  
  # Error handling ----
  # Require sex to be specified from vector of choices
  if(!missing(sex)) sex <- match.arg(sex, c('male', 'female'))
 
  # Require species to be specified from vector of choices
  if(!missing(species)) species <- match.arg(species, c('ALE', 'BBH'))
  
  # River error handling
  if(missing(river)){
    stop("
    
    Argument 'river' must be specified.
    
    To see a list of available rivers, run get_rivers() or specify river name
    in custom_habitat if used.")    
  }
  
  if(!river %in% get_rivers(species) & is.null(custom_habitat)){
    stop("
    
    Argument 'river' must be one of those included in get_rivers() or in
    custom_habitat if used.
    
    To see a list of available rivers, run get_rivers()")
  } 
  
  # Get region
  region <- get_region(river = river, species = species, 
                       custom_habitat = custom_habitat) 
  
  # Get max age for river and species
  max_age <- make_maxage(river = river, sex = sex, species = species,
                         custom_habitat = custom_habitat)
  
  # Probability of virgin recruitment to spawn ----
  # Subset the parameter table to include only species, region,
  # sex of interest
  if(missing(sex)){
    input <- 
      anadrofish::maki_pars[ 
      anadrofish::maki_pars$Species == species & 
        anadrofish::maki_pars$Region == region & 
        anadrofish::maki_pars$Sex == "Pooled", ]
  }
  
  if(!missing(sex)){
    if(sex == "female"){
      input <- 
        anadrofish::maki_pars[ 
          anadrofish::maki_pars$Species == species & 
            anadrofish::maki_pars$Region == region & 
            anadrofish::maki_pars$Sex == "Female", ]
    }
    if(sex == "male"){
      input <- 
        anadrofish::maki_pars[ 
          anadrofish::maki_pars$Species == species & 
            anadrofish::maki_pars$Region == region & 
            anadrofish::maki_pars$Sex == "Male", ]
    }    
    
  }  
  
  # . Exception handling for region by species ----
  if(nrow(input) == 0){
    stop(paste("
         
      'region' must be one of",
         
      paste(sort(unique(anadrofish::maki_pars$Region[
        anadrofish::maki_pars$Species == species])), collapse = ", "),
      
      "for species", species))
  }
  
  amax <- nrow(input)
  
  # Sample estimated Maki paramters (ages 3,4,5) ----
  pFit <- input[!is.na(input$pMature), ]
  pMat <- matrix(nrow = amax, ncol = 1)  
  pMat[1, ] <- 0
  
  for(a in 2:amax){
    if(a %in% pFit$Age){
      mu <- pFit$pMature[pFit$Age == a]
      sd <- pFit$pMat.se[pFit$Age == a]
      n1 <- (((1 - mu) / sd) - (1 / mu)) * (mu ^ 2)
      n2 <- n1 * ((1 / mu) - 1)
      pMat[a, ] <- stats::rbeta(1, n1, n2)
    }
    else{
      pMat[a, ] <- 0
    }
  }
  
  propMature <- apply(pMat, 2, cumsum)
  
  # If propMature[age 5] < 1, set propMature[age 6+] equal to 1
  a.tmp <- max(pFit$Age) + 1
  for(a in a.tmp:amax){
    propMature[a, ][which(propMature[5, ] < 1)] <- 1
  }  

  # Proportion mature (add zero for age 1)
  prop <- c(0, apply(propMature, 2, function(x) x / max(x)))
  
  # Add 1 for any age after 10 if needed
  if( length(prop) < max_age ){
    prop <- c(prop, rep(1, max_age-length(prop)))
  }
  
  # Return ages 1 through max age (some are less than the 10 years in maki_pars)
  return(prop[1:max_age])
  
}
