#' @title Make maximum age for population using built-in data sets.
#'
#' @description The purpose of this function is to query the maximum age
#' in the selected river from built-in data set containing
#' region-specific \code{\link{max_ages}} and.
#'
#' @param river River for which maximum age is needed.
#'
#' @param sex Sex of fish. If not specified, then mean of
#' male and female maximum ages is returned for American shad,
#' or pooled sex data used for river herring.
#'
#' @param species Species for which population dynamics will be simulated.
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#'
#' @param custom_habitat A dataframe containing columns corresponding to the
#' those in the output from \code{\link{custom_habitat_template}}. The default,
#' \code{NULL} uses the default habitat data set for a given combination of
#' \code{species} and \code{river}.
#'
#' @return A numeric vector of \code{length = 1} containing
#' maximum age of fish in population.
#'
#' @examples make_maxage(river = "Susquehanna", species = "AMS")
#'
#' @references Atlantic States Marine Fisheries Commission (ASMFC). 2020.
#' American shad benchmark stock assessment and peer-review report. ASMFC,
#' Arlington, VA.
#'
#' Atlantic States Marine Fisheries Commission. 2024. River herring
#' benchmark stock assessment and peer-review report. ASMFC, Arlington, VA.
#' URL: https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf
#'
#' @source Atlantic States Marine Fisheries Commission
#'
#' @export
#'
make_maxage <- function(river,
                        sex = c("female", "male"),
                        species = c("AMS", "ALE", "BBH"),
                        custom_habitat = NULL) {
  # Required argument matching
  if (!missing(sex)) sex <- match.arg(sex)
  if (!missing(species)) species <- match.arg(species)

  # Species error handling
  # Make sure species is one of those implemented in package
  if (!species %in% c("ALE", "AMS", "BBH")) {
    stop("

    Argument 'species' must be one of 'ALE', 'AMS', or 'BBH'.")
  }

  # River error handling
  if (missing(river)) {
    stop("

    Argument 'river' must be specified.

    To see a list of available rivers, run get_rivers() or specify river name
    in custom_habitat if used.")
  }

  if (!river %in% get_rivers(species) & is.null(custom_habitat)) {
    stop("

    Argument 'river' must be one of those included in get_rivers() or in
    custom_habitat if used.

    To see a list of available rivers, run get_rivers()")
  }

  # Get region
  region <- get_region(
    river = river, species = species,
    custom_habitat = custom_habitat
  )

  # Get maximum age
  if (species == "AMS") {
    if (missing(sex)) {
      max_age <- max(anadrofish::max_ages$maxage[
        anadrofish::max_ages$region == region
      ])
    }

    if (!missing(sex)) {
      if (sex == "female") {
        max_age <- anadrofish::max_ages$maxage[
          anadrofish::max_ages$region == region &
            anadrofish::max_ages$sex == "F"
        ]
      }

      if (sex == "male") {
        max_age <- anadrofish::max_ages$maxage[
          anadrofish::max_ages$region == region &
            anadrofish::max_ages$sex == "M"
        ]
      }
    }
  }

  # Max age for all sexes and stocks of river herring was 10 years (ASMFC 2024)
  if (species %in% c("ALE", "BBH")) {
    if (missing(sex)) {
      max_age <- max(anadrofish::mortality_rh$age[
        anadrofish::mortality_rh$region == region &
          anadrofish::mortality_rh$species == species
      ])
    }

    if (sex == "female") {
      max_age <- max(anadrofish::mortality_rh$age[
        anadrofish::mortality_rh$region == region &
          anadrofish::mortality_rh$species == species &
          anadrofish::mortality_rh$sex == "Female"
      ])
    }

    if (sex == "male") {
      max_age <- max(anadrofish::mortality_rh$age[
        anadrofish::mortality_rh$region == region &
          anadrofish::mortality_rh$species == species &
          anadrofish::mortality_rh$sex == "Male"
      ])
    }
  }

  return(max_age)
}
