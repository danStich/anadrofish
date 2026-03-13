# Make maximum age for population using built-in data sets.

The purpose of this function is to query the maximum age in the selected
river from built-in data set containing region-specific
[`max_ages`](https://danstich.github.io/anadrofish/reference/max_ages.md)
and.

## Usage

``` r
make_maxage(
  river,
  sex = c("female", "male"),
  species = c("AMS", "ALE", "BBH"),
  custom_habitat = NULL
)
```

## Source

Atlantic States Marine Fisheries Commission

## Arguments

- river:

  River for which maximum age is needed.

- sex:

  Sex of fish. If not specified, then mean of male and female maximum
  ages is returned for American shad, or pooled sex data used for river
  herring.

- species:

  Species for which population dynamics will be simulated. Choices
  include American shad (`"AMS"`), alewife (`"ALE"`), and blueback
  herring (`"BBH"`).

- custom_habitat:

  A dataframe containing columns corresponding to the those in the
  output from
  [`custom_habitat_template`](https://danstich.github.io/anadrofish/reference/custom_habitat_template.md).
  The default, `NULL` uses the default habitat data set for a given
  combination of `species` and `river`.

## Value

A numeric vector of `length = 1` containing maximum age of fish in
population.

## References

Atlantic States Marine Fisheries Commission (ASMFC). 2020. American shad
benchmark stock assessment and peer-review report. ASMFC, Arlington, VA.

Atlantic States Marine Fisheries Commission. 2024. River herring
benchmark stock assessment and peer-review report. ASMFC, Arlington, VA.
URL:
https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf

## Examples

``` r
make_maxage(river = "Susquehanna", species = "AMS")
#> [1] 13
```
