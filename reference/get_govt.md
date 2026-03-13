# Get governmental unit for specified river by species

Function used to get governmental unit for rivers listed in output of
[`get_rivers`](https://danstich.github.io/anadrofish/reference/get_rivers.md)
from the built-in habitat data sets.

## Usage

``` r
get_govt(river, species = c("ALE", "AMS", "BBH"), custom_habitat = NULL)
```

## Arguments

- river:

  Character string specifying river name.

- species:

  Character string specifying species. Choices include American shad
  (`"AMS"`), alewife (`"ALE"`), and blueback herring (`"BBH"`).

- custom_habitat:

  A dataframe containing columns corresponding to the those in the
  output from
  [`custom_habitat_template`](https://danstich.github.io/anadrofish/reference/custom_habitat_template.md).
  The default, `NULL` uses the default habitat data set for a given
  combination of `species` and `river`.

## Value

A character string indicating governmental district corresponding to
selected river.

## Examples

``` r
get_govt(river = "Hudson", species = "AMS")
#> [1] "NJ"
```
