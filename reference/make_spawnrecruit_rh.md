# Make spawnrecruit vectors for river herring

Simulate proportion of population that is mature spawners from
sex-specific maturity schedules for river herring in
[`maki_pars`](https://danstich.github.io/anadrofish/reference/maki_pars.md).

## Usage

``` r
make_spawnrecruit_rh(
  river,
  sex = c("male", "female"),
  species = c("ALE", "BBH"),
  custom_habitat = NULL
)
```

## Arguments

- river:

  River for which maximum age is needed.

- sex:

  A character indicating `"male"`, `"female"`, or `"Pooled"` sex for
  fish.

- species:

  A character indicating species of river herring, either `"ALE"` for
  alewife or `"BBH"` for blueback herring.

- custom_habitat:

  A dataframe containing columns corresponding to the those in the
  output from
  [`custom_habitat_template`](https://danstich.github.io/anadrofish/reference/custom_habitat_template.md).
  The default, `NULL` uses the default habitat data set for a given
  combination of `species` and `river`.

## Value

A numeric vector containing a single realization for proportion of
mature fish at each age, from age 1 to maximum age.

## Details

The primary use of this function is to simulate proportion of mature
spawners at each age in a population of river-herring based on
region-specific probabilities of maturation at each age estimated from
the Maki (YEAR) method in ASMFC (2024).

## References

Atlantic States Marine Fisheries Commission. 2024. River herring
benchmark stock assessment and peer-review report. ASMFC, Arlington, VA.
URL:
https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf

## Examples

``` r
make_spawnrecruit_rh(river = "Hudson", species = "BBH", sex = "female")
#>  [1] 0.00000000 0.00000000 0.00000000 0.02666047 0.35639463 0.72504549
#>  [7] 1.00000000 1.00000000 1.00000000 1.00000000 1.00000000 1.00000000
```
