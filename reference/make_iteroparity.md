# Estimate rate of iteroparity for American shad from latitude based on Leggett and Cascardden (1978) and Bailey and Zydlewski (2013).

Function used to extract river-specific latitude from built-in data
sets.

## Usage

``` r
make_iteroparity(latitude)
```

## Arguments

- latitude:

  Latitude, in decimal degrees. Can be queried for each river using
  [`make_lat`](https://danstich.github.io/anadrofish/reference/make_lat.md).

## Value

Probability of repeat spawning. A numeric vector of `length = 1`.

## References

Bailey, M.M., and J. D. Zydlewski. 2013. To stock or not to stock?
Assessing therestoration potential of a remnant American shad spawning
run with hatchery supplementation. North American Journal of Fisheries
Management 33:459-467.

Leggett, W., and J. E. Cascardden. 1978. Latitudinal Variation in
Reproductive Characteristics of American Shad (Alosa sapidissima):
Evidence for Population Specific Life History Strategies in Fish.
Journal of the Fisheries Research Board of Canada 35:1469-1478.

## Examples

``` r
make_iteroparity(make_lat(river = "Susquehanna", species = "AMS"))
#> [1] 0.333116
```
