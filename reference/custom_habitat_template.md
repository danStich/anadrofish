# Make custom habitat for an existing river or a template for a new river of interest

Function used to make habitat for rivers listed in
[`get_rivers`](https://danstich.github.io/anadrofish/reference/get_rivers.md)
from the built-in datasets.

## Usage

``` r
custom_habitat_template(
  species = c("AMS", "ALE", "BBH"),
  built_in = TRUE,
  river
)
```

## Arguments

- species:

  Species for which population dynamics will be simulated. Choices
  include American shad (`"AMS"`), alewife (`"ALE"`), and blueback
  herring (`"BBH"`).

- built_in:

  A logical indicating whether the custom habitat template is a a subset
  of built-in habitat datasets for the `species` indicated.

- river:

  Character string specifying river name or `NULL` for custom river. If
  making custom habitat from an existing river in
  [`habitat`](https://danstich.github.io/anadrofish/reference/habitat.md)
  (American shad),
  [`habitat_ale`](https://danstich.github.io/anadrofish/reference/habitat_ale.md)
  (Alewife), or
  [`habitat_bbh`](https://danstich.github.io/anadrofish/reference/habitat_bbh.md)
  (Blueback herring), then river must be included in rivers from
  [`get_rivers`](https://danstich.github.io/anadrofish/reference/get_rivers.md)
  for the target species. Otherwise, an arbitrary character string
  identifying river name is acceptable.

## Value

A data.frame with zero or more observations of 8 variables:

- `river` Name of river

- `region` Regional grouping, see
  [`get_region`](https://danstich.github.io/anadrofish/reference/get_region.md)

- `govt` Governmental unit at downstream terminus of habitat unit

- `lat` Latitude at downstream terminus of habitat unit

- `lon` Longitude at downstream terminus of habitat unit

- `dam_name` Name of dam (if available) at downstream terminus of
  habitat unit

- `dam_order` Order of dam at downstream terminus of habitat unit.
  Cumulatively assigned such that all habitat units upstream of a given
  dam all have dam_order \>= 1.

- `Hab_sqkm` Square kilometers of habitat within a habitat unit

## Examples

``` r
# Select a subset of habitat from a single river
custom_habitat_template(species = "AMS", river = "Hudson")
#>    river region govt      lat       lon                      dam_name dam_order
#> 1 Hudson     SI   NJ 40.70670 -74.02608                           n/a         0
#> 2 Hudson     SI   NJ 42.75149 -73.68677             TROY LOCK & DAM 1         1
#> 3 Hudson     SI   NJ 42.82411 -73.66204     LOCK C-1 DAM AT WATERFORD         2
#> 4 Hudson     SI   NJ 42.87933 -73.67688 LOCK C-2 DAM AT MECHANICVILLE         3
#> 5 Hudson     SI   NJ 42.91211 -73.67873 LOCK C-3 DAM AT MECHANICVILLE         4
#> 6 Hudson     SI   NJ 42.93666 -73.65333    LOCK C-4 DAM AT STILLWATER         5
#>    Hab_sqkm
#> 1 65.466721
#> 2  7.044994
#> 3  4.840511
#> 4  3.735181
#> 5  3.122564
#> 6  2.586626

# Create a template heading that can be used to generate new habitat data
custom_habitat_template(
  species = "BBH",
  built_in = FALSE,
  river = "A fake river"
)
#>   river region govt lat lon dam_name dam_order Hab_sqkm
#> 1   NaN    NaN  NaN  NA  NA      NaN        NA       NA
```
