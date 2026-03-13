# Alewife habitat

A dataset containing the surface area of Alewife habitat and features
for individual flow line segments or waterbodies (lakes) comprising
habitat units in Atlantic coast drainages.

## Usage

``` r
habitat_ale
```

## Format

A data frame with 255,133 observations of 7 variables:

- `REACHCODE`:

  Code used to identify individual habitat units

- `Hab_sqkm`:

  Surface area of habitat in square kilometers

- `Latitude`:

  Latitude at downstream terminus of habitat unit

- `State`:

  Governmental unit at downstream terminus of habitat unit

- `River_huc`:

  Name of river to which habitat unit belongs, derived from hydrologic
  unit codes

- `POP`:

  Genetic reporting group geographic region within which habitat unit
  falls

- `DamOrder`:

  Order of dam at downstream terminus of habitat unit. Cumulatively
  assigned such that all habitat units upstream of a given dam all have
  dam_order \>= 1

## Source

Shawn Snyder

## Examples

``` r
head(habitat_ale)
#>   REACHCODE    Hab_sqkm Latitude State         River_huc POP DamOrder
#> 1     USA-1 0.122412805 44.06767    ME Abagadasset River NNE        0
#> 2     USA-2 0.018098687 44.01012    ME Abagadasset River NNE        0
#> 3     USA-3 0.003016216 44.10005    ME Abagadasset River NNE        0
#> 4     USA-4 0.146205559 44.15900    ME Abagadasset River NNE        0
#> 5     USA-5 0.001310855 44.09282    ME Abagadasset River NNE        0
#> 6     USA-6 0.016050529 44.09014    ME Abagadasset River NNE        0
```
