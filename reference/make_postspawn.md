# Post-spawning survival

Function used to estimate post-spawn survival from proportion of repeat
spawners by latitude (Leggett and Cascardden 1978, Bailey and Zydlewski
2013) and natural mortality by life-history region ("AMS") or by
iteroparity and natural mortality ("ALE" and "BBH").

## Usage

``` r
make_postspawn(
  river = river,
  species = c("AMS", "ALE", "BBH"),
  iteroparity = NULL,
  nM = NULL,
  custom_habitat = NULL
)
```

## Arguments

- river:

  River for which post-spawn survival rate should be returned. Required
  argument with no default value. Available rivers can be seen using
  [`get_rivers`](https://danstich.github.io/anadrofish/reference/get_rivers.md).

- species:

  Species for which population dynamics will be simulated. Choices
  include American shad (`"AMS"`), alewife (`"ALE"`), and blueback
  herring (`"BBH"`).

- iteroparity:

  Optional argument for rate of iteroparity. Values from
  [`make_iteroparity`](https://danstich.github.io/anadrofish/reference/make_iteroparity.md)
  can be passed directly to this function, or a numeric vector of
  `length = 1`.

- nM:

  Instantaneous annual mortality. Values for natural mortality for
  life-history regions can be from
  [`mortality`](https://danstich.github.io/anadrofish/reference/mortality.md)
  for `"AMS"`,
  [`mortality_rh`](https://danstich.github.io/anadrofish/reference/mortality_rh.md)
  for `"ALE"` and `"BBH"`, or a numeric vector of `length = 1`.

- custom_habitat:

  A dataframe containing columns corresponding to the those in the
  output from
  [`custom_habitat_template`](https://danstich.github.io/anadrofish/reference/custom_habitat_template.md).
  The default, `NULL` uses the default habitat data set for a given
  combination of `species` and `river`.

## References

Bailey, M.M., and J. D. Zydlewski. 2013. To stock or not to stock?
Assessing the restoration potential of a remnant American shad spawning
run with hatchery supplementation. North American Journal of Fisheries
Management 33:459–467.

Leggett, W., and J. E. Cascardden. 1978. Latitudinal Variation in
Reproductive Characteristics of American Shad (Alosa sapidissima):
Evidence for Population Specific Life History Strategies in Fish.
Journal of the Fisheries Research Board of Canada 35:1469-1478.

Atlantic States Marine Fisheries Commission. 2024. River herring
benchmark stock assessment and peer-review report. ASMFC, Arlington, VA.
URL:
https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf

## Examples

``` r
make_postspawn(river = "Susquehanna", species = "AMS")
#> [1] 0.5519683
```
