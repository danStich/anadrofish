# Rivers included in habitat data by species

Get names of rivers included in package for each species.

## Usage

``` r
get_rivers(species = c("ALE", "AMS", "BBH"))
```

## Arguments

- species:

  Species for which rivers are returned Choices include American shad
  (`"AMS"`), alewife (`"ALE"`), and blueback herring (`"BBH"`).

## Value

A character vector of rivers that are included in built-in habitat
datasets for selected `species`.

## Details

The primary uses of this function are (1) so the user can see rivers
that can be used for simulation, and (2) so the output can be passed to
a random sampler for use in stochastic simulation via parallel
processing.

## Examples

``` r
# Example usage
if (FALSE) { # \dontrun{
  
# Use get_rivers() to return names of rivers included in package
get_rivers(anadrofish::habitat)

# Sample a random river from those available
get_rivers(anadrofish::habitat)[sample(
  length(get_rivers(anadrofish::habitat)), 1)]  
  
} # }
```
