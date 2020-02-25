#' @title Juvenile (hatch-to-outmigrant) survival
#'
#' @description Function used to simulate juvenile (hatch-to-outmigrant) 
#' survival from daily rates reported by Crecco et al. (1983) from
#' the Connecticut River, USA during 4 consecutive years.
#'
#' @param crecco_1983 built-in dataset containing daily mortality 
#' rates, daily survival, and cumulative survival during varying
#' post-hatch periods. See \code{\link{crecco_1983}}.
#' 
#' @examples sim_juvenile(anadrofish::crecco_1983)
#'
#' @references Crecco, V., T. Savoy, and L. Gunn. 1983. Daily mortality rates 
#' of larval and juvenile American shad (*Alosa sapidissima*) in the Connecticut 
#' River with changes in year-class strength. Canadian Journal of 
#' Fisheries and Aquatic Sciences 40:1719–1728.
#' 
#' @export
#'
sim_juvenile_s <- function(crecco_1983){
  
  jmean <- log(mean(crecco_1983$Sc[crecco_1983$Age==70]))
  jsd <- sd(crecco_1983$Sc[crecco_1983$Age==70])*10
  
  juvenile_s <- exp(rnorm(1, jmean, jsd))
  return(juvenile_s)
  
}
