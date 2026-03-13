# Calculate upper 95 % confidence limit

Function with a short name to calculate 97.5th percentile of a
distribution. Calls
[`stats::quantile`](https://rdrr.io/r/stats/quantile.html), but is
shorter and is easier to use in calls to `apply` family of functions.

## Usage

``` r
upper95(x)
```

## Arguments

- x:

  A numeric vector or matrix.

## Value

Numeric vector of length 1 containing 97.5th percentile for sampling
distribution of `x`.

## Examples

``` r
# Example usage
if (FALSE) { # \dontrun{
  
x <- rnorm(1e4, 0, 1)
 
upper95(x)
  
} # }
```
