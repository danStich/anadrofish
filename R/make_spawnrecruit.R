#' @title Make age-structured probability of recruit to first spawn. 
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
#' @return A numeric vector of \code{length = length(max_age)} depending
#' on maximum age in the selected river (by life-history region).
#'
#' @examples make_spawnrecruit(river = "Susquehanna")
#' 
#' @references Atlantic States Marine Fisheries Commission
#' 
#' @export
#'
make_spawnrecruit <- function(river, sex=c('male', 'female')){
  
  if(!missing(sex)) sex <- match.arg(sex)
  
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
  
  region <- anadrofish::shad_rivers$region[
    anadrofish::shad_rivers$system==river]
  
  if(missing(sex)){
    max_age <- make_maxage(river)
    probs <- as.numeric(
      colMeans(anadrofish::maturity[
        anadrofish::maturity$region==region, 3:(2+max_age)])
    )
  }
  
  if(!missing(sex)){
  
    max_age <- make_maxage(river, sex = sex)
    
    if(sex == 'female'){
    probs <- as.numeric(
      anadrofish::maturity[
        anadrofish::maturity$region==region & 
          anadrofish::maturity$sex=='F', 3:(2+max_age)]
      )
    }
    
    if(sex == 'male'){
    probs <- as.numeric(
      anadrofish::maturity[
        anadrofish::maturity$region==region & 
          anadrofish::maturity$sex=='M', 3:(2+max_age)]
      )
    }
  
  }
  
  return(probs)
}
