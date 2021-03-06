#' @title Length-weight regression coefficients for American shad
#'
#' @description A dataset containing sex-specific regression
#' coefficients of log10length-log10weight relationships
#' for each life-history region (NI = Northern iteroparous,
#' SI = Southern iteroparous, SP = Semelparous). Use to predict
#' weight at age from length derived using region-specific
#' vbgf parameters.
#'
#' @format A data frame with 6 observations of 4 variables:
#' \describe{
#' 
#' \code{region}{ Life-history region}
#' 
#' \code{sex}{ Fish sex (gender)}
#' 
#' \code{alpha}{ Intercept}
#' 
#' \code{beta}{ Slope}
#' }
#' 
#' @source Atlantic States Marine Fisheries Commission
"length_weight"
