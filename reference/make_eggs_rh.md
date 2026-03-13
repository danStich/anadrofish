# Simulate number of eggs per fish for river herring

Function used to simulate number of eggs produced per female (total
fecundity) for river herring in rivers included in
[`get_rivers`](https://danstich.github.io/anadrofish/reference/get_rivers.md).

## Usage

``` r
make_eggs_rh(river, species = c("ALE", "BBH"), custom_habitat = NULL)
```

## Arguments

- river:

  The river for which eggs will be simulated.

- species:

  Species for which population dynamics will be simulated. Choices
  include alewife (`"ALE"`), and blueback herring (`"BBH"`).

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

The default methods of alewife and blueback herring uses a stochastic,
MCMC sampling approach to draw correlated sets of von Bertalanffy growth
parameters from built-in `vbgf_...` datasets, length-weight regression
parameters in `link{lw_pars_rh}`, and length-fecundity relationships
from Sullivan et al. (2019) to simulate the number of eggs per female
within genetic reporting groups (`region`).

## References

Atlantic States Marine Fisheries Commission. 2024. River herring
benchmark stock assessment and peer-review report. ASMFC, Arlington, VA.
URL:
https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf

Sullivan, K.M, M.M. Bailey, and D.L. Berlinksky. 2019. Digital Image
Analysis as a Technique for Alewife Fecundity Estimation in a New
Hampshire River. North American Journal of Fisheries Management
39:353-361.

## Examples

``` r
make_eggs_rh(river = "Susquehanna", species = "BBH")
#>  [1] 109053.6 237696.8 330659.7 385480.0 415070.8 430396.1 438176.3 442087.5
#>  [9] 444044.3 445020.8 445507.7 445750.2
```
