#' @title Fork length - total length conversions for river herring
#'
#' @description A dataset containing species-specific fork length - total
#' length conversions from ASMFC (2024). The data are regression
#' coefficients and standard errors for each species.
#'
#' @format A data frame with 2 observations of 5 variables:
#' \describe{
#' 
#' \code{species}{ Species of river herring ("ALE" or "BBH")}
#' 
#' \code{alpha}{ Intercept}
#' 
#' \code{alpha.se}{ Standard error of the intercept}
#' 
#' \code{beta}{ Slope}
#' 
#' \code{beta.se}{ Standard error of the slope}
#' 
#' }
#'
#' @references Atlantic States Marine Fisheries Commission. 2024. River herring
#' benchmark stock assessment and peer-review report. ASMFC, Arlington, VA. 
#' URL: https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf
#'
#' @source Atlantic States Marine Fisheries Commission
"fl_tl_conversions"
