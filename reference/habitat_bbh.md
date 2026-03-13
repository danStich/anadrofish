# Blueback herring habitat

A dataset containing the surface area of blueback herring habitat and
features for individual flow line segments comprising habitat units in
Atlantic coast drainages.

## Usage

``` r
habitat_bbh
```

## Format

A data frame with 282,809 observations of 7 variables:

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
