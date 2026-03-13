# Get dams for specified river from American shad habitat data

Function used to get dams for rivers listed in
[`get_rivers`](https://danstich.github.io/anadrofish/reference/get_rivers.md)
from the built-in
[`habitat`](https://danstich.github.io/anadrofish/reference/habitat.md)
dataset for American shad. Not implemented for river herring.

## Usage

``` r
get_dams(river)
```

## Arguments

- river:

  Character string specifying river name. Must match one from
  `get_rivers(species = 'AMS')`.

## Value

A data.frame with 4 variables containing dam name, latitude and
longitude, and dam order in the watershed.

## Examples

``` r
get_dams("Penobscot")
#>                    dam_name latitude longitude dam_order
#> 502                     n/a 44.58850 -68.81944         0
#> 503         Marsh River Dam 44.60895 -68.87315         1
#> 504               Orono Dam 44.88320 -68.66449         1
#> 505          Stillwater Dam 44.91253 -68.68297         2
#> 506  Great Works Stream Dam 44.91343 -68.59780         1
#> 507             Milford Dam 44.94132 -68.64630         1
#> 508              Gilman Dam 44.95155 -68.69498         3
#> 509         Pushaw Lake Dam 44.96980 -68.81445         4
#> 510              Olamon Dam 45.12655 -68.60744         2
#> 511 Guilford Industries Dam 45.16848 -69.38501         5
#> 512               Lower Dam 45.18360 -69.21872         3
#> 513               Upper Dam 45.18362 -69.22915         4
#> 514      Lowell Tannery Dam 45.18703 -68.46465         2
#> 515             Howland Dam 45.23935 -68.65640         2
#> 516            Stanford Dam 45.25037 -68.64854         2
#> 517          Mattaseunk Dam 45.57032 -68.40848         3
#> 518              Medway Dam 45.60727 -68.54547         4
#> 519    East Millinocket Dam 45.62082 -68.57553         5
#> 520               Dolby Dam 45.63252 -68.60647         6
```
