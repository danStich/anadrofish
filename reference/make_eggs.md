# Simulate number of eggs per fish

Function used to simulate number of eggs produced per female (potential
annual fecundity, PAF), for rivers included in
[`get_rivers`](https://danstich.github.io/anadrofish/reference/get_rivers.md).

## Usage

``` r
make_eggs(river, species = c("AMS", "ALE", "BBH"), custom_habitat = NULL)
```

## Arguments

- river:

  The river for which eggs will be simulated.

- species:

  Species for which population dynamics will be simulated. Choices
  include American shad (`"AMS"`), alewife (`"ALE"`), and blueback
  herring (`"BBH"`).

- custom_habitat:

  A dataframe containing columns corresponding to the those in the
  output from
  [`custom_habitat_template`](https://danstich.github.io/anadrofish/reference/custom_habitat_template.md).
  The default, `NULL` uses the default habitat data set for a given
  combination of `species` and `river`.

## Value

A vector containing age-specific potential annual fecundity with
`length = max_age`.

## Details

The default method for American shad uses predictive equations from
Olney and McBride (2003) to simulate batch fecundity from
weight-fecundity relationships using coefficients in
[`olney_mcbride`](https://danstich.github.io/anadrofish/reference/olney_mcbride.md)
for the life-history region corresponding to the specified river. Number
of batches for this approach is currently drawn from a random normal
distribution with a mean of 6.7 and a standard deviation of 2.1 (McBride
et al. 2016).

The default method for river herring calls
[`make_eggs_rh`](https://danstich.github.io/anadrofish/reference/make_eggs_rh.md)
with simulation methods and references described therein.

## References

Olney, J. E. and R. S. McBride. 2003. Intraspecific variation in batch
fecundity of American shad (Alosa sapidissima): revisiting the paradigm
of reciprocal latitudinal trends in reproductive traits. American
Fisheries Society Symposium 35:185-192.

McBride, R. S., R. Ferreri, E. K. Towle, J. M. Boucher, and G. Basilone,
G. 2016. Yolked oocyte dynamics support agreement between determinate-
and indeterminate-method estimates of annual fecundity for a
northeastern United States population of American shad. PLoS ONE 11(10):
10.1371/journal.pone.0164203

## Examples

``` r
make_eggs(river = "Susquehanna", species = "AMS")
#>  [1]  15099.38  79127.13 169263.47 251924.78 313956.41 355901.33 382686.26
#>  [8] 399244.67 409291.43 415321.23 418917.13 421053.53 422320.01
```
