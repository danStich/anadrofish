% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/jessop_1993.R
\docType{data}
\name{jessop_1993}
\alias{jessop_1993}
\title{Fork length-fecundity relationships for alewife}
\format{
A data frame with 4 observations of 6 variables:
\describe{
    \item{\code{reference}}{Reference for study (in case others are added)}
    \item{\code{system}}{Study system}
    \item{\code{alpha}}{Intercept}
    \item{\code{alpha.se}}{Standard error of the intercept}
    \item{\code{beta}}{Slope}
    \item{\code{beta.se}}{Standard error of the slope}
}
}
\usage{
jessop_1993
}
\description{
A dataset containing fork length-fecundity relationships for
blueback herring from several spawning groups in New Brunswick and
Nova Scotia, Canada. Parameters are for equations of the form:

\code{log10(fec / 1000) ~ alpha + beta * log10(fork length)}.
}
\references{
Jessop, B. M. 1993. Fecundity of anadromous alewives and blueback
herring in New Brunswick and Nova Scotia. Transactions of the American
Fisheries Society 122:85-98.
}
\keyword{datasets}
