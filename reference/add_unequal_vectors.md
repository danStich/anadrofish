# Add vectors of unequal length

Function used to add aligned vectors of unequal length without recycling
elements of the shorter vector. Used to combine male and female cohorts
when `max_age` is not equal in the
[`max_ages`](https://danstich.github.io/anadrofish/reference/max_ages.md)
dataset.

## Usage

``` r
add_unequal_vectors(x, y)
```

## Arguments

- x, y:

  Paired numeric vectors of same or different length.

## Value

A vector of length one containing pre-spawn survival.

## References

https://stackoverflow.com/questions/2307443/how-to-add-two-vectors-without-repeating-in-r

## Examples

``` r
x <- c(1, 2)
y <- c(1, 2, 3)
add_unequal_vectors(x, y)
#> [1] 2 4 3
```
