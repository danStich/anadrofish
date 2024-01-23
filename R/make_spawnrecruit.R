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
#' @return A numeric vector of \code{length = length(max_age)} depending
#' on maximum age in the selected river (by life-history region and species).
#'
#' @examples make_spawnrecruit(river = "Hudson", species = "BBH")
#' 
#' @references Atlantic States Marine Fisheries Commission
#' 
#' @export
#'
make_spawnrecruit <- function(river, 
                              sex = c('male', 'female'),
                              species = c("ALE", "AMS", "BBH")){
  
  # Error handling
  # Argument matching
  if(!missing(sex)) sex <- match.arg(sex)
  if(!missing(species)) species <- match.arg(species)
  
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
  
  if(species == "AMS"){
    region <- unique(anadrofish::habitat$region[
      anadrofish::habitat$system==river])
    
    if(missing(sex)){
      max_age <- make_maxage(river)
      probs <- as.numeric(
        colMeans(anadrofish::maturity[
          anadrofish::maturity$region == region, 3:(2+max_age)])
      )
    }
    
    if(!missing(sex)){
    
      max_age <- make_maxage(river = river, sex = sex, species = "AMS")
      
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
    probs = make_spawnrecruit_rh(river = river, sex = sex, species = species)
  }
  
  return(probs)
}
