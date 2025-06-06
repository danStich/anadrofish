#' @title Sex-specific von Bertalanffy growth parameters for alewife
#' 
#' @description A dataset containing sex-specific estimates of von Bertalanffy
#' growth parameters for alewife from the 2024 ASMFC river herring benchmark
#' stock assessment (ASMFC 2024).
#'
#' @format A data frame with 1,116,000 observations of 5 variables:
#' \describe{
#'     \item{\code{Region}}{Genetic reporting group}
#'     \item{\code{Sex}}{Sex of fish}
#'     \item{\code{Linf}}{Asymptotic length of fish}
#'     \item{\code{K}}{Brody growth coefficient}
#'     \item{\code{t0}}{Size at age zero}
#' }
#'
#' @references Atlantic States Marine Fisheries Commission. 2024. River herring
#' benchmark stock assessment and peer-review report. ASMFC, Arlington, VA. 
#' URL: https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf
#'
#' @source Atlantic States Marine Fisheries Commission
"vbgf_ale"
