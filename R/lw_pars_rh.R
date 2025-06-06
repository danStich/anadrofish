#' @title Length-weight regression coefficients for river herring
#'
#' @description A dataset containing sex-specific regression
#' coefficients of log10length-log10weight relationships
#' for each genetic reporting group of river herring.
#'
#' @format A data frame with 30 observations of 7 variables:
#' \describe{
#'     \item{\code{Species}}{Species of river herring ("ALE" or "BBH")}
#'     \item{\code{Region}}{Genetic reporting group region}
#'     \item{\code{Sex}}{Fish sex: \code{"Female"}, \code{"Male"}, or \code{"Pooled"}}
#'     \item{\code{alpha}}{Intercept}
#'     \item{\code{alpha.se}}{Standard error for the intercept}
#'     \item{\code{beta}}{Slope}
#'     \item{\code{beta.se}}{Standard error for the slope}
#' }
#'
#' @references Atlantic States Marine Fisheries Commission. 2024. River herring
#' benchmark stock assessment and peer-review report. ASMFC, Arlington, VA. 
#' URL: https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf
#'
#' @source Atlantic States Marine Fisheries Commission
"lw_pars_rh"
