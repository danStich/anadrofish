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
#' \code{species}{ Species of fish}
#' 
#' \code{Region}{ Genetic reporting group and general geographic region}
#' 
#' \code{Sex}{ Fish sex (gender)}
#' 
#' \code{Age}{ Fish age (years)}
#' 
#' \code{pMature}{ Probability of maturation at age}
#' 
#' \code{pMat.se}{ Standard error of estimated pMature from ASMFC (2024)}
#' }
#' 
#' @source Atlantic States Marine Fisheries Commission (2024)
"maki_pars"
