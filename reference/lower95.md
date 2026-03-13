# Calculate lower 95 % confidence limit

Function with a short name to calculate 2.5th percentile of a
distribution. Calls `stats::quantile(x)`, but is shorter and is easier
to use in calls to `apply` family of functions.

## Usage

``` r
lower95(x)
```

## Arguments

- x:

  A numeric vector or matrix.

## Value

Numeric vector of length 1 containing the 2.5th percentile of the
sampling distribution for `x`.

## Examples

``` r
# Example usage
if (FALSE) { # \dontrun{
  
x <- rnorm(1e4, 0, 1)

lower95(x)
  
} # }
```
