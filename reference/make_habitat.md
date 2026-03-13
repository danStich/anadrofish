# Make cumulative habitat for river

Function used to make habitat for rivers listed in
[`get_rivers`](https://danstich.github.io/anadrofish/reference/get_rivers.md)
from the built-in dataset(s)

## Usage

``` r
make_habitat(
  river,
  species = c("AMS", "ALE", "BBH"),
  upstream,
  custom_habitat = NULL
)
```

## Arguments

- river:

  Character string specifying river name

- species:

  Species for which population dynamics will be simulated. Choices
  include American shad (`"AMS"`), alewife (`"ALE"`), and blueback
  herring (`"BBH"`).

- upstream:

  Proportional upstream passage through dams. A numeric vector of length
  1 or length matching the number of rows in habitat data for selected
  `river` and `species`.

- custom_habitat:

  A dataframe containing columns corresponding to the those in the
  output from
  [`custom_habitat_template`](https://danstich.github.io/anadrofish/reference/custom_habitat_template.md).
  The default, `NULL` uses the default habitat data set for a given
  combination of `species` and `river`.

## Value

A numeric vector containing amount of accessible habitat in acres.

## Examples

``` r
make_habitat(river = "Penobscot", species = "AMS", upstream = 0.9)
#> [1] 10964.79
```
