# anadrofish
R package for modeling anadromous fish population responses to freshwater habitat changes

## Installation
This package can be installed with the [`devtools`](https://www.rstudio.com/products/rpackages/devtools/) package in R using the repository url:

`devtools::install_github("danStich/anadrofish")`

To install `anadrofish`, you will need to have `devtools` installed ahead of time in R, but that requires some special tools. To install on **Windows**, you will need to download and install the appropriate version of [Rtools](https://cran.r-project.org/bin/windows/Rtools/). To install on **Mac**, you will need to have the [XCode command-line tools](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/) installed. And, if running from **Linux**, you will need to install the developer version of R (`r-base-dev`) if you have not already.

</br>

## Use
The purpose of this package is to distribute code and provide a user interface for modeling anadromous fish population responses to dam passage and fisheries in Atlantic coastal rivers of Canada and the United States. The main `sim_pop` function uses various helper functions (see `?anadrofish` in R) that links dam passage to habitat availability and stochastic population models to simulate species-specific responses to dams and fisheries. 

Existing models for each river can be implemented using the `sim_pop` function. New models can theoretically be constructed using the existing functions within `anadrofish` and appropriately structured habitat data.

Currently, these models are available for American shad (*Alosa sapidissima*) in 167 Atlantic Coastal rivers of North America from Florida (St. Johns River) to Quebec (St. Lawrence drainage). The full list of rivers available for assessment can be viewed with `anadrofish::get_rivers(...)` once the package is installed.

</br>

## Warning
Implementation of river herring models has not yet been through peer-review. It is currently undergoing revision in preparation for review and thus may be updated at any time, after which it will be submitted to CRAN with the hope of providing a  stable, backward-compatible version of the software moving forward. Until that time, please consult directly with the package maintainer(s) before use in management or research applications.

</br>

## Directories

`data/` Built-in data sets for the package

`inst/examples/` Examples for those requiring more than a one-liner 

`man/`  Help files and documentation

`R/`    R functions in scripts
