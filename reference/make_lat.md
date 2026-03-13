# Retrieve latitude for American shad rivers.

Function used to extract river-specific latitude from built-in data sets
for American shad. Not implemented for river herring.

## Usage

``` r
make_lat(river, species = c("AMS", "ALE", "BBH"), custom_habitat = NULL)
```

## Arguments

- river:

  Character string specifying river name. See
  [`get_rivers`](https://danstich.github.io/anadrofish/reference/get_rivers.md).

- species:

  Species for which population dynamics will be simulated. Choices
  include American shad (`"AMS"`), alewife (`"ALE"`), and blueback
  herring (`"BBH"`).

- custom_habitat:

  A dataframe containing columns corresponding to the those in the
  output from custom_habitat_template(). NEED TO ADD LINK.

## Examples

``` r
make_lat(river = "Susquehanna", species = "AMS")
#> [1] 39.03772
```
