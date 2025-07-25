% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make_spawnrecruit.R
\name{make_spawnrecruit}
\alias{make_spawnrecruit}
\title{Make age-specific proportion of spawners in population}
\usage{
make_spawnrecruit(
  river,
  sex = c("male", "female"),
  species = c("ALE", "AMS", "BBH"),
  custom_habitat = NULL
)
}
\arguments{
\item{river}{River for which spawn recruit probabilities are requested.}

\item{sex}{Sex of fish. If not specified, then mean of
male and female spawn recruit probabilities are returned.}

\item{species}{Species for which rivers are returned
Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
blueback herring (\code{"BBH"}). If species is "ALE" or "BBH" then this
function calls \code{\link{make_spawnrecruit_rh}}.}

\item{custom_habitat}{A dataframe containing columns corresponding to the
those in the output from \code{\link{custom_habitat_template}}. The default,
\code{NULL} uses the default habitat data set for a given combination of
\code{species} and \code{river}.}
}
\value{
A numeric vector of \code{length = length(max_age)} depending
on maximum age in the selected river by region and species.
}
\description{
The purpose of this function is to make age-specific
recruit to spawn probabilities for rivers listed in \code{\link{get_rivers}}
using built-in data sets for region-specific \code{\link{max_ages}} and
\code{\link{maturity}}.
}
\examples{
make_spawnrecruit(river = "Hudson", species = "BBH")

}
\references{
Atlantic States Marine Fisheries Commission
}
