# Juvenile (hatch-to-outmigrant) survival

Function used to simulate juvenile (hatch-to-outmigrant) survival from
daily rates.

## Usage

``` r
sim_juvenile_s(species = c("AMS", "ALE", "BBH"))
```

## Arguments

- species:

  Species used for simulation ("AMS", "ALE", or "BBH").

## Value

A numeric vector of length 1.

## References

Crecco, V., T. Savoy, and L. Gunn. 1983. Daily mortality rates of larval
and juvenile American shad (\*Alosa sapidissima\*) in the Connecticut
River with changes in year-class strength. Canadian Journal of Fisheries
and Aquatic Sciences 40:1719-1728.

Overton A. S., N. A. Jones, and R. Rulifson. 2012. Spatial and temporal
variability in instantaneous growth, mortality, and recruitment of
larval river herring in the Tar-Pamlico River, North Carolina. Marine
and Coastal Fisheries: Dynamics, Management, and Ecosystem Science
4:218-227.

Stich, D. S., W. E. Eakin, and G. Kenney. 2024. Population Responses of
Blueback Herring to Dam Passage Standards and Additive Mortality
Sources. Journal of Fish and Wildlife Management 15(1):31-48.

Hook, T. O., E. S. Rutherford, D. M. Mason, and G. S. Carter. 2007.
Hatch Dates, Growth, Survival, and Overwinter Mortality of Age-0
Alewives in Lake Michigan: Implications for Habitat-Specific Recruitment
Success. Transactions of the American Fisheries Society 136:1298-1312.

## Examples

``` r
sim_juvenile_s(species = "ALE")
#> [1] 0.001849695
```
