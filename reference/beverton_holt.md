# Beverton-Holt stock recruit curve

Beverton and Holt (1957) stock-recruit curve with habitat constraints.
Default parameter values are tuned to predict larval recruitment
assuming a carrying capacity for spawning adults of 100 fish per acre
for American shad or 500 fish per acre for river herring species. See
`details`.

## Usage

``` r
beverton_holt(
  a = 250000,
  S = 100,
  b = 0.21904,
  acres = 1,
  error = c("multiplicative", "additive"),
  age_structured = FALSE
)
```

## Arguments

- a:

  Ratio of recruits per spawner. Density independent parameter
  equivalent to the slope near `S = 0`. By default specified as
  potential annual fecundity.

- S:

  Spawning stock abundance per acre. Numeric vector with one or more
  elements.

- b:

  Density-dependent parameter. By default specified on a per-acre basis
  (will be divided by `acres` in function).

- acres:

  Surface area (in acres) of habitat units.

- error:

  Character string indicating whether to use `'multiplicative'` or
  `'additive'` error structure. Defaults to `error = 'multiplicative'`.

- age_structured:

  Logical indicating whether to return age-structured, density-dependent
  recruitment from the Beverton-Holt curve. If `TRUE` then a vector of
  `length = max age` must be passed to `S`.

## Value

A numeric vector with one or more elements representing number of age-1
recruits (downstream migrants in freshwater).

## Details

The primary use of this function in the `anadrofish` package is to
predict number of larval recruits in a river based on the number of fish
within a functional habitat unit, and the number of surface acres of
habitat in the same unit. However, the number of potential uses is
flexible. Passing a single value to each argument would result in
calculation of a single recruitment value. Alternatively, passing a
vector to one of the default arguments allows the user to explore values
of recruitment over a range of each input.

Under the current implementation, it is recommended that the user pass
multiple values to only a single argument per call. Otherwise, we
recommend conducting more in-depth sensitivity explorations by use of
single values applied under a boot-strapping, or Monte Carlo approach.

## References

Beverton, R. J. H. and S. J. Holt. 1957. On the Dynamics of Exploited
Fish Populations, Fisheries Investigations (Series 2), Volume 19. United
Kingdom Ministry of Agriculture and Fisheries, 533 pp.

## Examples

``` r
# Example usage
if (FALSE) { # \dontrun{
  
# Run Beverton-Holt model to predict number
# of age-0 recruits in freshwater under 
# varying habitat amount with 100 fish and
# default parameter settings.
  
# Start by making a sequence of habitat amounts (acres)
acres <- seq(0, 100, 1)
  
# Run the Beverton-Holt curve for 100 individuals
# in varying habitats with default a and b parameters
recruits <- beverton_holt(S = 100, acres = seq(0, 1000, 10))
  
# Plot the results
plot(x = acres, y = recruits, type='l')
  
} # }
```
