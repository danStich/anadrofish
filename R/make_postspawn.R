#' @title Post-spawning survival
#'
#' @description Function used to estimate post-spawn survival
#' from proportion of repeat spawners by latitude (Leggett and
#' Cascardden 1978, Bailey and Zydlewski 2013) and natural mortality
#' by life-history region ("AMS") or by iteroparity and natural mortality
#' ("ALE" and "BBH").
#'
#' @param river River for which post-spawn survival rate should be
#' returned. Required argument with no default value. Available rivers
#' can be seen using \code{\link{get_rivers}}.
#'
#' @param species Species for which population dynamics will be simulated.
#' Choices include American shad (\code{"AMS"}), alewife (\code{"ALE"}), and
#' blueback herring (\code{"BBH"}).
#'
#' @param iteroparity Optional argument for rate of iteroparity. Values from
#' \code{\link{make_iteroparity}} can be passed directly to this function, or
#' a numeric vector of \code{length = 1}.
#'
#' @param nM Instantaneous annual mortality. Values for
#' natural mortality for life-history regions can be
#' from \code{\link{mortality}} for \code{"AMS"}, \code{\link{mortality_rh}} for
#' \code{"ALE"} and \code{"BBH"}, or a numeric vector of \code{length = 1}.
#'
#' @param custom_habitat A dataframe containing columns corresponding to the
#' those in the output from \code{\link{custom_habitat_template}}. The default,
#' \code{NULL} uses the default habitat data set for a given combination of
#' \code{species} and \code{river}.
#'
#' @examples make_postspawn(river = "Susquehanna", species = "AMS")
#'
#' @references Bailey, M.M., and J. D. Zydlewski. 2013. To stock or not
#' to stock? Assessing the restoration potential of a remnant
#' American shad spawning run with hatchery supplementation. North
#' American Journal of Fisheries Management 33:459–467.
#'
#' Leggett, W., and J. E. Cascardden. 1978. Latitudinal Variation in
#' Reproductive Characteristics of American Shad (Alosa sapidissima):
#' Evidence for Population Specific Life History Strategies in Fish.
#' Journal of the Fisheries Research Board of Canada 35:1469-1478.
#'
#' Atlantic States Marine Fisheries Commission. 2024. River herring
#' benchmark stock assessment and peer-review report. ASMFC, Arlington, VA.
#' URL: https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf
#'
#' @export
#'
make_postspawn <- function(river = river,
                           species = c("AMS", "ALE", "BBH"),
                           iteroparity = NULL,
                           nM = NULL,
                           custom_habitat = NULL) {
  # Error handling
  # Species error handling
  if (missing(species)) {
    stop("

    Argument 'species' must be one of 'ALE', 'AMS', or 'BBH'.")
  }

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

  if (species == "AMS") {
    if (is.null(iteroparity)) {
      iteroparity <- make_iteroparity(
        make_lat(river, species = "AMS", custom_habitat = custom_habitat)
      )
    }
  }

  if (is.null(nM)) {
    nM <- make_mortality(
      river = river, species = species,
      custom_habitat = custom_habitat
    )
  }

  A <- 1 - exp(-nM)
  S <- 1 - A

  post_spawn_s <- iteroparity / S

  post_spawn_s[post_spawn_s < 0] <- 0
  post_spawn_s[post_spawn_s > 1] <- 1

  return(post_spawn_s)
}
