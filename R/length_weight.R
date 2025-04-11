#' @title Length-weight regression coefficients for American shad
#'
#' @description A dataset containing sex-specific regression
#' coefficients of log10length-log10weight relationships
#' for each life-history region (NI = Northern iteroparous,
#' SI = Southern iteroparous, SP = Semelparous). Use to predict
#' weight at age from length derived using region-specific
#' von Bertalanffy growth parameters in built-in datasets.
#'
#' @format A data frame with 6 observations of 4 variables:
#' \describe{
#' 
#' \code{region} Life-history region
#' 
#' \code{sex} Fish sex \code{F} is female and \code{M} is male
#' 
#' \code{alpha} Intercept
#' 
#' \code{beta} Slope
#' }
#' 
#' @references Atlantic States Marine Fisheries Commission (ASMFC). 2020. 
#' American shad benchmark stock assessment and peer-review report. ASMFC, 
#' Arlington, VA.
#' 
#' @source Atlantic States Marine Fisheries Commission
"length_weight"
