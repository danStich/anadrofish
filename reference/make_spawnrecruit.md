# Make age-specific proportion of spawners in population

The purpose of this function is to make age-specific recruit to spawn
probabilities for rivers listed in
[`get_rivers`](https://danstich.github.io/anadrofish/reference/get_rivers.md)
using built-in data sets for region-specific
[`max_ages`](https://danstich.github.io/anadrofish/reference/max_ages.md)
and
[`maturity`](https://danstich.github.io/anadrofish/reference/maturity.md).

## Usage

``` r
make_spawnrecruit(
  river,
  sex = c("male", "female"),
  species = c("ALE", "AMS", "BBH"),
  custom_habitat = NULL
)
```

## Arguments

- river:

  River for which spawn recruit probabilities are requested.

- sex:

  Sex of fish. If not specified, then mean of male and female spawn
  recruit probabilities are returned.

- species:

  Species for which rivers are returned Choices include American shad
  (`"AMS"`), alewife (`"ALE"`), and blueback herring (`"BBH"`). If
  species is "ALE" or "BBH" then this function calls
  [`make_spawnrecruit_rh`](https://danstich.github.io/anadrofish/reference/make_spawnrecruit_rh.md).

- custom_habitat:

  A dataframe containing columns corresponding to the those in the
  output from
  [`custom_habitat_template`](https://danstich.github.io/anadrofish/reference/custom_habitat_template.md).
  The default, `NULL` uses the default habitat data set for a given
  combination of `species` and `river`.

## Value

A numeric vector of `length = length(max_age)` depending on maximum age
in the selected river by region and species.

## References

Atlantic States Marine Fisheries Commission

## Examples

``` r
make_spawnrecruit(river = "Hudson", species = "BBH")
#>  [1] 0.00000000 0.00000000 0.00000000 0.06323636 0.68455549 0.89252531
#>  [7] 1.00000000 1.00000000 1.00000000 1.00000000 1.00000000 1.00000000
```
