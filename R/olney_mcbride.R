#' @title Weight-batch fecundity relationships for American Shad
#'
#' @description A dataset containing weight-batch fecundity relationships
#' for St. Johns, York, and Connecticut Rivers from Olney and McBride (2003).
#' Regressions fit log10 batch fecundity as a function of
#' log10 body weight (g).
#'
#' @format A data frame with 3 observations of 4 variables:
#' \describe{
#'     \item{\code{system}}{Study system}
#'     \item{\code{region}}{Life-history region: NI = Northern iteroparous, SI = Southern iteroparous, SP = Semelparous}
#'     \item{\code{alpha}}{Intercept}
#'     \item{\code{beta}}{Slope}
#' }
#'
#' @source Olney, J. E. and R. S. McBride. 2003. Intraspecific
#' variation in batch fecundity of American shad (*Alosa sapidissima*):
#' revisiting the paradigm of reciprocal latitudinal trends
#' in reproductive traits. American Fisheries Society
#' Symposium 35:185-192.
#'
"olney_mcbride"
