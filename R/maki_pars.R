#' @title Sex-specific maturity schedules for River Herring
#'
#' @description A dataset containing sex-specific probabilities 
#' of maturation at age for each life-history region 
#' (SAT = Southern Atlantic, MAT = Mid Atlantic, 
#' SNE = Southern New England, MNE = Mid New England,
#' NNE = Northern New England, CAN-NNE = Canada and Northern New England)
#'
#' @format A data frame with 216 observations of 6 variables:
#' \describe{
#' 
#'     \item{\code{species}}{Species of fish}
#'     \item{\code{Region}}{Genetic reporting group and general geographic region}
#'     \item{\code{Sex}}{Fish sex}
#'     \item{\code{Age}}{Fish age (years)}
#'     \item{\code{pMature}}{Probability of maturation at age}
#'     \item{\code{pMat.se}}{Standard error of estimated pMature from ASMFC (2024)}
#' }
#'
#' @references Atlantic States Marine Fisheries Commission. 2024. River herring
#' benchmark stock assessment and peer-review report. ASMFC, Arlington, VA. 
#' URL: https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf
#'
#'@source Atlantic States Marine Fisheries Commission
"maki_pars"
