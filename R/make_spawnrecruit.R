#' @title Make age-specific proportion of spawners in population
#'
#' @description The purpose of this function is to make age-specific
#' recruit to spawn probabilities for rivers listed in \code{\link{get_rivers}}
#' using built-in data sets for region-specific \code{\link{max_ages}} and
#' \code{\link{maturity}}.
#'
#' @param river River for which spawn recruit probabilities are requested.
#' 
#' @param sex Sex of fish. If not specified, then mean of
#' male and female spawn recruit probabilities are returned.
#' 
#' @param species Species for which rivers are returned
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}). If species is "ALE" or "BBH" then this 
#' function calls \code{\link{make_spawnrecruit_rh}}.
#'
#' @param custom_habitat A dataframe containing columns corresponding to the
#' those in the output from custom_habitat_template(). NEED TO ADD LINK.
#' 
#' @return A numeric vector of \code{length = length(max_age)} depending
#' on maximum age in the selected river (by life-history region and species).
#'
#' @examples make_spawnrecruit(river = "Upper Hudson", species = "BBH")
#' 
#' @references Atlantic States Marine Fisheries Commission
#' 
#' @export
#'
make_spawnrecruit <- function(river, 
                              sex = c('male', 'female'),
                              species = c("ALE", "AMS", "BBH"),
                              custom_habitat = NULL){
  
  # Error handling
  # Argument matching
  if(!missing(sex)) sex <- match.arg(sex)
  if(!missing(species)) species <- match.arg(species)
  
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
  
  if(species == "AMS"){
    
    # Get region
    region <- get_region(river = river, species = species, 
                         custom_habitat = custom_habitat) 
    
    if(missing(sex)){
      max_age <- make_maxage(river, custom_habitat = custom_habitat)
      probs <- as.numeric(
        colMeans(anadrofish::maturity[
          anadrofish::maturity$region == region, 3:(2+max_age)])
      )
    }
    
    if(!missing(sex)){
    
      max_age <- make_maxage(river = river, sex = sex, species = "AMS", 
                             custom_habitat = custom_habitat)
      
      if(sex == 'female'){
      probs <- as.numeric(
        anadrofish::maturity[
          anadrofish::maturity$region==region & 
            anadrofish::maturity$sex=='F', 3:(2 + max_age)]
        )
      }
      
      if(sex == 'male'){
      probs <- as.numeric(
        anadrofish::maturity[
          anadrofish::maturity$region==region & 
            anadrofish::maturity$sex=='M', 3:(2 + max_age)]
        )
      }
    
    }
  }
  
  if(species %in% c("ALE", "BBH")){
    probs = make_spawnrecruit_rh(river = river, sex = sex, species = species,
                                 custom_habitat = custom_habitat)
  }
  
  return(probs)
}
