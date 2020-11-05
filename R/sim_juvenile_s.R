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
#' @examples sim_juvenile_s(anadrofish::crecco_1983)
#'
#' @references Crecco, V., T. Savoy, and L. Gunn. 1983. Daily mortality rates 
#' of larval and juvenile American shad (*Alosa sapidissima*) in the Connecticut 
#' River with changes in year-class strength. Canadian Journal of 
#' Fisheries and Aquatic Sciences 40:1719–1728.
#' 
#' @export
#' 
sim_juvenile_s <- function(crecco_1983){
  
  subs <- crecco_1983[crecco_1983$Age == 70 & crecco_1983$Year != 1980, ]
  
  theta <-c(mean(subs$Sc), sd(subs$Sc))

  juvenile_s <- rtruncnorm(n = 1,
                           a = 0,
                           b = 0.014,
                           mean = theta[1],
                           sd = theta[1]*0.2)
  return(juvenile_s)
  
}
