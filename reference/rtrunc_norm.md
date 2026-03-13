# Simulate random samples from truncated normal distribution

Simulate random draws from a truncated normal distribution based using
inverse cumulative distribution function for normal distribution.

## Usage

``` r
rtrunc_norm(n, a = -Inf, b = Inf, mean, sd)
```

## Arguments

- n:

  Number of random samples

- a:

  Lower bound(s)

- b:

  Upper bound(s)

- mean:

  Mean(s)

- sd:

  Standard deviation(s)

## Details

This approach is an approximation based on the normal distribution for
case application to tested uses in the \`anadrofish\` package. It should
not be considered a generalized solution. This function is used to
replace the `rtruncnorm` function from the `truncnorm` package to
eliminate need for compilation in the `anadrofish` package and eliminate
dependency on `truncnorm` (which requires compilation).

## References

Answers by Glen_b and JohannesNE to this post on Cross Validated:
https://stats.stackexchange.com/questions/56747/simulate-constrained-normal-on-lower-or-upper-bound-in-r
were helpful.

## Examples

``` r
rtrunc_norm(n = 1, a = 0, b = Inf, mean = 6.1, sd = 0.5)
#> [1] 5.671924
```
