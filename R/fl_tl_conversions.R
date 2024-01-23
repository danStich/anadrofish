#' @title Fork length - total length conversions for river herring
#'
#' @description A dataset containing species-specific fork length - total
#' length conversions from ASMFC (2024). The data set are regression
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
#' @source Atlantic States Marine Fisheries Commission
"fl_tl_conversions"
