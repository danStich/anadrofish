# anadrofish
R package for modeling anadromous fish population responses to freshwater habitat changes

## Installation
This package can be installed with the [`devtools`](https://www.rstudio.com/products/rpackages/devtools/) package in R using the repository url:

`devtools::install_github("danStich/anadrofish")`

To install `shadia`, you will need to have `devtools` installed ahead of time in R, but that requires some special tools. To install on **Windows**, you will need to download and install the appropriate version of [Rtools](https://cran.r-project.org/bin/windows/Rtools/). To install on **Mac**, you will need to have the [XCode command-line tools](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/) installed. And, if running from **Linux**, you will need to install the developer version of R (`r-base-dev`) if you have not already.

</br>


## Use
The purpose of this package is to distribute code for modeling anadromous fish population responses to dam passage and fisheries. The full list of rivers available for assessment can be viewed with `anadrofish::get_rivers()` once the package is installed.

Existing models for each river can be implemented using the `sim_pop` function, and new models can theoretically be constructed using the existing functions within `anadrofish`.

Currently, these models are available for American shad (*Alosa sapidissima*) in 48 Atlantic Coastal Rivers of the United States from Florida (St. Johns River) to the Canadian border (St. Croix River). 

</br>


## Directories

`data/` Contains built-in data sets for the package

`man/`  help files and documentation

`R/`    R functions in scripts
