# anadrofish

R package for modeling anadromous fish population responses to habitat changes

[![DOI](https://zenodo.org/badge/186272264.svg)](https://doi.org/10.5281/zenodo.14285894)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![R-CMD-check](https://github.com/danStich/anadrofish/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/danStich/anadrofish/actions/workflows/R-CMD-check.yaml)
[![test-coverage.yaml](https://github.com/danStich/anadrofish/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/danStich/anadrofish/actions/workflows/test-coverage.yaml)

## Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Directories](#directories)
- [Examples](#examples)
- [References](#references)

## Overview
### Purpose
The purpose of this package is to distribute code and provide a user interface for modeling anadromous fish population responses to dam passage, fisheries, or restoration activities in Atlantic coastal rivers of Canada and the United States. The main `sim_pop()` function uses various helper functions (see `?anadrofish` in R) that link dam passage to habitat availability and stochastic population models to simulate species-specific responses to dams and fisheries across marine and freshwater habitats (Figure 1 below). Built-in habitat datasets are currently derived separately for each species based on best available knowledge and expert opinion from state and federal fishery biologists, managers, and scientists. Likewise, all species-specific life-history parameters (size at age, age at maturity, natural mortality) are derived directly from interstate stock assessments or informed by empirical estimates from the fisheries literature. The application of these models is described in [ASMFC (2020)](https://asmfc.org/uploads/file/63d8437dAmShadBenchmarkStockAssessment_PeerReviewReport_2020_web.pdf), [Zydlewski et al. (2021)](https://www.frontiersin.org/journals/marine-science/articles/10.3389/fmars.2021.734213/full), and [ASMFC (2024)](https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf).

![**Figure 1**: Graphical overview of the `anadrofish` workflow (right) compared to conceptual life-history model for anadromous fishes (left). Helper functions are used within the `sim_pop()` function along with built-in data sets to simulate anadromous fish populations.](man/figures/conceptual-model.jpg?raw=true)

</br>

Existing (built-in) population models for each species can be implemented using the `sim_pop()` function. New models can be constructed using the existing helper functions within `anadrofish` and appropriately structured habitat data. **As of version 2.1.0** (2024-11-26), we implemented the `custom_habitat_template()` function. This allows use of default habitat data sets, modifying habitat data based on built-in datasets, querying custom habitat datasets ranging from the single stream segment to regional stock scales for each species, or constructing completely custom habitat configurations including fabricated (i.e., theoretical) habitat configurations for optimization studies. 


### Species
These models are available for 167 American shad (*Alosa sapidissima*)  populations, 222 alewife (*Alosa pseudoharengus*) populations, and 238 blueback herring (*Alosa aestivalis*) populations in Atlantic Coastal rivers of North America from Florida, USA (St. Johns River) to Quebec, Canada (St. Lawrence drainage). American shad models and data were peer-reviewed during the [2020 Atlantic States Marine Fisheries Commission (ASMFC) American Shad Benchmark Stock Assessment](https://asmfc.org/wp-content/uploads/2025/01/AmShadBenchmarkStockAssessment_PeerReviewReport_2020_web.pdf). River herring models and underlying data were peer-reviewed during development and application to the [2024 ASMFC River Herring Benchmark Stock Assessment](https://asmfc.org/uploads/file/66f59e40RiverHerringAssessment_PeerReviewReport_2024.pdf). 

The full list of rivers available for each species can be viewed with `get_rivers()` once the package is installed.

We are currently working with collaborators to extend to multiple additional species. Please feel free to contact us with requests, post an issue, or see [Contributing.md](https://github.com/danStich/anadrofish/blob/master/Contributing.md) for details about other ways to contribute!

</br>

## Installation
### Versions 2.3.0 and later
As of version 2.3.0 the `anadrofish` package no longer requires compilation and can therefore be installed using the `remotes` package (Csardi et al. 2021) in R. Once you have installed the `remotes` package, `anadrofish` can be installed like this: 

`remotes::install_github("danStich/anadrofish")`

Specific releases can be installed by referencing the release tag, like this:

`remotes::install_github("danStich/anadrofish@v2.3.0")`

The `remotes` package can be installed directly from CRAN or from GitHub following instructions in the repository [https://github.com/r-lib/remotes#readme](https://github.com/r-lib/remotes#readme).

### Versions 2.20 and earlier
Earlier versions of this package can be installed with the [`devtools`](https://www.rstudio.com/products/rpackages/devtools/) package (Wickam et al. 2022) in R using the repository url:

`devtools::install_github("danStich/anadrofish")`

Specific releases can be installed by referencing the release tag, like this:

`devtools::install_github("danStich/anadrofish@v2.1.0")`

To install `anadrofish`, you will need to have `devtools` installed ahead of time in R, but that requires some special tools. To install on **Windows**, you will need to download and install the appropriate version of [Rtools](https://cran.r-project.org/bin/windows/Rtools/). To install on **Mac**, you will need to have the [XCode command-line tools](http://osxdaily.com/2014/02/12/install-command-line-tools-mac-os-x/) installed. And, if running from **Linux**, you will need to install the developer version of R (`r-base-dev`) if you have not already. You may need to work with your IT specialists or someone with administrative privileges if you do not have them to install these utilities.

</br>

## Examples
### Running one scenario for one river many times in parallel
This example uses alewife in the Sebasticook River, ME, USA [Wipplehauser 2021](https://onlinelibrary.wiley.com/doi/full/10.1002/tafs.10292) to understand baseline population predictions following the removal of Edwards Dam in 1999, removal of Fort Halifax Dam in 2008, and installation of a fish lift at the next dam in the Sebasticook River. Approximately 1-6 million spawning alewife have passed upstream of Benton Falls (5.3 miles from mouth of Sebasticook River, and 17 miles from Edwards Dam) annually since then.

In this example, we return output from `sim_pop()` using `years = "all"` to also demonstrate the number of years needed for a stable population estimate under this scenario. If we wanted to model changes over time, we would run different scenarios for each year and return only the final year of simulations using `years = "last"`. In theory, this approach could also be used to identify stable population sizes for seeding the initial population in temporal studies, but this has not been validated.

The data set is in the `inst/data` folder on the GitHub repo but is ignored during R package install.

```r
# Package load ----
library(snowfall)
library(anadrofish)
library(tidyverse)
library(data.table)
library(parallel)

# Set a seed for random number generators for reproducibility ----
set.seed(12345)

# Parallel settings ----
# Get number of cores for simulation using parallel package
ncpus <- detectCores() - 1

# Initialize snowfall socket cluster
sfInit(parallel = TRUE, cpus = ncpus, type = "SOCK")

# Read in the Sebasticook River data ----
# This data set is in the inst/data folder on the GitHub repo
sebasticook_habitat_data <- read_csv("https://raw.githubusercontent.com/danStich/anadrofish/refs/heads/master/inst/data/sebasticook_habitat.csv")

sebasticook_habitat_data <-
  data.frame(
    Latitude = sebasticook_habitat_data$Latitude,
    DamOrder = sebasticook_habitat_data$DamOrder,
    Hab_sqkm = sebasticook_habitat_data$Hab_sqkm
  )

# Make a custom habitat data set for the Sebasticook River, ME
# since it is only included as part of the larger Kennebec River
# watershed for river herring
sebasticook_habitat <- data.frame(
  river = "Sebasticook",
  region = "NNE",
  govt = "ME",
  lat = sebasticook_habitat_data$Latitude,
  lon = -69.4139,
  dam_name = NA,
  dam_order = sebasticook_habitat_data$DamOrder,
  Hab_sqkm = sebasticook_habitat_data$Hab_sqkm
)

# Wrapper function ----
sim <- function(x) {
  # . Call simulation ----
  res <- sim_pop(
    species = "ALE",
    river = "Sebasticook",
    nyears = 50,
    n_init = round(runif(1, 1e6, 22e7)),
    sr = 0.5,
    b = 0.05,
    upstream = 1, # runif(1, 0.95, 1.00), # Could draw from a uniform instead
    downstream = 1, # runif(1, 0.95, 1.00),
    downstream_j = 1, # runif(1, 0.95, 1.00),
    output_years = "all",
    age_structured_output = FALSE,
    sex_specific = TRUE,
    custom_habitat = sebasticook_habitat
  )

  # . Define the output lists ----
  retlist <- list(
    res = res
  )

  return(retlist)
}


# Parallel execution ----
# . Load libraries on workers -----
sfLibrary(anadrofish)
sfLibrary(tidyverse)
sfExport("sebasticook_habitat")

# . Distribute to workers -----
# Number of simulations to run
niterations <- 1e2

# Run the simulation ----
# Assign starting time
start <- Sys.time()

# Run the sim
result <- sfLapply(1:niterations, sim)

# Calculate and print run time
total_time <- Sys.time() - start
total_time

# . Stop snowfall ----
sfStop()

# Results ----
# 'result' is a list of lists.

# Extract results dataframes by string and rbind them
res <- lapply(result, function(x) x[[c("res")]])
resdf <- data.frame(rbindlist(res))

# . Summary statistics by passage scenario -----
# Summary results by year to investigate number of years
# needed for simulated population to stabilize given user inputs
plotter <- resdf %>%
  group_by(year) %>%
  summarize(
    pop = mean(spawners),
    lci = quantile(spawners, 0.025),
    uci = quantile(spawners, 0.975),
    samp = length(spawners)
  )

# . Plot the result ----
# It looks like we need to run this model for at least 25 years or so
# to get stable results for a given scenario
seb_plot <- ggplot(plotter, aes(x = year, y = pop)) +
  geom_line(linewidth = 1) +
  geom_ribbon(aes(xmax = year, ymin = lci, ymax = uci, color = NULL), 
  alpha = 0.25)

seb_plot
```

![**Figure 2**: Example result from Sebasticook River simulation.](man/figures/seb_ale.jpg?raw=true)

</br>
</br>


### Running multiple scenarios for one river many times in parallel
This example uses American shad in the Connecticut River, CT, USA. Here, we benchmark model predictions against population estimates from the river prior to implementation of fish passage at Holyoke Dam, the most downstream dam in this river. Spawner abundance estimates for the population were on the order of about 400,000 to > 1 million American shad prior to initial improvement of upstream passage at Holyoke Dam in 1974 and later, further improvements. Because we don't "know" what downstream survival rates were through Holyoke Dam prior to 1974, we can consider multiple scenarios for adult and juvenile downstream survival through dams to gauge a range of potential conditions.

```r
# Package load ----
library(snowfall)
library(anadrofish)
library(tidyverse)
library(data.table)
library(parallel)

# Set a seed for random number generators for reproducibility ----
set.seed(12345)

# Parallel settings ----
# Get number of cores for simulation using parallel package
ncpus <- detectCores() - 1

# Initialize snowfall socket cluster
sfInit(parallel = TRUE, cpus = ncpus, type = "SOCK")

# Wrapper function ----
sim <- function(x) {
  # Define habitat
  # Extract the built-in habitat data for American shad in the Connecticut
  # River so we can use it to specify dam-specific passage rates
  ct_habitat <- custom_habitat_template(species = "AMS", 
                                        built_in = TRUE, 
                                        river = "Connecticut"
                                        )

  # Make upstream passage at all dams zero, then add low passage rates
  # at Holyoke dam prior to fish passage improvements after 1974
  # (Table 2 in https://www.nrc.gov/docs/ML0701/ML070190410.pdf). This should
  # give us a nice check for whether simulated abundances are reasonable
  ct_passage <- rep(0, nrow(ct_habitat))
  holyoke_historical <- mean(c(3.0, 2.6, 2.7, 3.8, 5.2, 4.5, 5.5, 5.9, 5.8))
  ct_passage[9] <- holyoke_historical

  # We don't actually "know" what downstream survival rates were at Holyoke
  # at that time...unless we can dig up a study on it
  downstream <- sample(seq(0, 1, .1), 1, replace = TRUE)
  downstream_j <- sample(seq(0, 1, .1), 1, replace = TRUE)

  # Include estimates of commercial and sport fishery exploitation rates
  # from same document (Table 1 in https://www.nrc.gov/docs/ML0701/ML070190410.pdf)
  ct_exploitation <- mean(
    c(28.7, 19.8, 13.0, 9.4, 10.0, 10.4, 19.3, 25.2)) / 100
    
  # Need to convert this to an instantaneous rate for the model
  ct_f <- -log(1 - ct_exploitation)

  # Choose a species
  species <- "AMS"

  # . Call simulation ----
  res <- sim_pop(
    species = species,
    river = "Connecticut",
    nyears = 50,
    n_init = MASS::rnegbin(1, 1e6, 1),
    sr = rbeta(1, 100, 100),
    b = 0.21904,
    fM = ct_f,
    upstream = ct_passage,
    downstream = downstream,
    downstream_j = downstream_j,
    output_years = "last",
    age_structured_output = FALSE,
    sex_specific = TRUE
  )

  # . Define the output lists ----
  retlist <- list(
    res = res
  )

  return(retlist)
}


# Parallel execution ----
# . Load libraries on workers -----
sfLibrary(anadrofish)
sfLibrary(tidyverse)

# . Distribute to workers -----
# Number of simulations to run
niterations <- 1e4

# Run the simulation ----
# Assign starting time
start <- Sys.time()

# Run the sim
result <- sfLapply(1:niterations, sim)

# Calculate and print run time
total_time <- Sys.time() - start
total_time

# . Stop snowfall ----
sfStop()

# Results ----
# 'result' is a list of lists.

# Extract results dataframes by string and rbind them
res <- lapply(result, function(x) x[[c("res")]])

resdf <- data.frame(rbindlist(res))


# . Summary statistics by passage scenario -----
# Summary data for plotting results by genetic reporting group region
plotter <- resdf %>%
  group_by(fM, downstream, downstream_j) %>%
  summarize(
    fit = mean(spawners),
    lwr = quantile(spawners, 0.025),
    upr = quantile(spawners, 0.975),
    iterations = n()
  ) %>%
  mutate(downstream = as.character(downstream))

plotter

# Plot of results
ct_plot <- ggplot(plotter, 
                  aes(x = downstream_j,
                      y = fit,
                      color = downstream,
                      fill = downstream
                      )) +
  geom_line() +
  geom_ribbon(aes(
    xmax = downstream_j, ymin = lwr, ymax = upr,
    color = NULL
  ), alpha = 0.05) +
  guides(fill = guide_legend(nrow = 1, byrow = TRUE)) +
  geom_hline(yintercept = 1.3e6, linetype = 2) +
  scale_y_continuous(breaks = seq(0, 1e7, .5e6), labels = seq(0, 10, .5)) +
  xlab("Downstream juvenile survival") +
  ylab("Number of Spawners (millions of fish)") +
  theme_bw() +
  theme(
    panel.spacing.x = unit(.01, units = "npc"),
    panel.grid = element_blank(),
    legend.position = "top",
    legend.box = "horizontal",
    legend.margin = margin(unit(.5, units = "npc")),
    axis.text = element_text(color = "black", size = 8),
    axis.title.x = element_text(vjust = -1),
    axis.title.y = element_text(vjust = 3),
    strip.background = element_blank(),
    strip.text.x = element_blank()
  )

ct_plot
```

![**Figure 3**: Example simulation for historical fish passage scenarios in the Connecticut River. The horizontal dashed line indicates the maximum estimated abundance in the river prior to 1974.](man/figures/ct_shad.jpg?raw=true)

</br>
</br>

### Running multiple scenarios for many rivers many times in parallel
This example uses the randomized sampling scenarios used in ASMFC (2024) for range-wide blueback herring population assessment. It randomly samples rivers from all available populations, and selects a management scenario ("no dams", "no passage", "current") randomly for broad-scale simulation. Note that this scenario would need to be run > 1 million times to produce stabilized results for all populations included.

```r
# Package load ----
library(snowfall)
library(anadrofish)
library(tidyverse)
library(data.table)
library(parallel)

# Set a seed for random number generators for reproducibility ----
set.seed(12345)

# Parallel settings ----
# Get number of cores for simulation using parallel package
ncpus <- detectCores() - 1

# Initialize snowfall socket cluster
sfInit(parallel = TRUE, cpus = ncpus, type = "SOCK")

# Wrapper function ----
sim <- function(x) {
  # Define passage scenarios used for ASFMC (2024)
  passages <- list(
    c(0, 1, 1), # No passage
    c(1, 1, 1), # No dams
    c(0.31, 0.8, 0.90)
  ) # Current

  scenarios <- c("No passage", "No dams", "Current")

  # Randomly sample the scenario for each iteration
  scenario_num <- sample(1:3, 1, replace = TRUE)
  scenario <- scenarios[scenario_num]
  passage <- passages[[scenario_num]]

  # Choose a species
  species <- "BBH"

  # . Call simulation ----
  res <- sim_pop(
    species = species,
    river = as.character(
      get_rivers(species)[sample(1:length(get_rivers(species)), 1)]
    ),
    nyears = 50,
    n_init = MASS::rnegbin(1, 1e6, 1),
    sr = rbeta(1, 100, 100),
    b = 0.05,
    upstream = passage[1],
    downstream = passage[2],
    downstream_j = passage[3],
    output_years = "last",
    age_structured_output = FALSE,
    sex_specific = TRUE
  )

  # . Define the output lists ----
  res$scenario <- scenario

  retlist <- list(
    res = res
  )

  return(retlist)
}


# Parallel execution ----
# . Load libraries on workers -----
sfLibrary(anadrofish)
sfLibrary(tidyverse)

# . Distribute to workers -----
# Number of simulations to run
# You will need to run this MANY more times (1 million+) to stabilize results
niterations <- 1e2

# Run the simulation ----
# Assign starting time
start <- Sys.time()

# Run the sim
result <- sfLapply(1:niterations, sim)

# Calculate and print run time
total_time <- Sys.time() - start
total_time

# . Stop snowfall ----
sfStop()

# Results ----
# 'result' is a list of lists.

# Extract results dataframes by string and rbind them
res <- lapply(result, function(x) x[[c("res")]])
resdf <- data.frame(rbindlist(res))

# . Summary statistics by passage scenario -----
# Summary data for plotting results by genetic reporting group region
plotter <- resdf %>%
  group_by(region, river, scenario) %>%
  summarize(
    pop = mean(spawners),
    lci = quantile(spawners, 0.025),
    uci = quantile(spawners, 0.975),
    samp = length(spawners)
  )

plotter <- plotter %>%
  group_by(scenario) %>%
  summarize(
    pop = sum(pop),
    lwr = sum(lci),
    upr = sum(uci)
  )

# Names for fish passage scenarios
n_pass <- mean(plotter$pop[plotter$scenario == "No passage"])
plotter$scenario <- factor(plotter$scenario,
  levels = c("No passage", "Current", "No dams"),
  labels = c("No passage", "Current", "No dams")
)

# Plot of results
ggplot(plotter, aes(x = scenario, y = pop)) +
  geom_point() +
  geom_linerange(aes(xmax = scenario, ymin = lwr, ymax = upr)) +
  geom_hline(yintercept = n_pass, linetype = 2) +
  guides(fill = guide_legend(nrow = 1, byrow = TRUE)) +
  scale_y_continuous(breaks = seq(0, 1e9, 1e7), labels = seq(0, 1000, 10)) +
  xlab("Scenario") +
  ylab("Coastwide blueback herring abundance (millions of fish)") +
  theme_bw() +
  theme(
    legend.position = "top",
    legend.box = "horizontal",
    legend.margin = margin(unit(.5, units = "npc"))
  )
```

![**Figure 4**: Figure from example coast-wide blueback herring simulation.](man/figures/coastal_bbh.jpg?raw=true)


</br>
</br>


### Creating a custom population
In this example, we create a custom population for alewife using the names from the `custom_habitat_template()` to build a dataframe with a novel habitat configuration. This simple example also demonstrates use of dam-specific upstream passage efficiencies. It is important to note that in more complex systems (e.g., with multiple upstream migration paths), dam-specific passage rates are not currently supported. For example, if we had a fourth dam with `dam_order` of `2` in our example below, it would not be explicitly upstream of either of the two dams with `dam_order` of `1`. We are currently working to implement matrix-based operations for custom habitat datasets that will allow for dam-specific fish passage rates in more complex systems. Until then, catchment-wide passage efficiencies can be applied in those complex systems, or the systems can be simplified using `custom_habitat_template()` to address dam-specific questions.

```r
# Package load ----
library(snowfall)
library(anadrofish)
library(tidyverse)
library(data.table)
library(parallel)

# Set a seed for random number generators for reproducibility ----
set.seed(12345)

# Parallel settings ----
# Get number of cores for simulation using parallel package
ncpus <- detectCores() - 1

# Initialize snowfall socket cluster
sfInit(parallel = TRUE, cpus = ncpus, type = "SOCK")

# Wrapper function ----
sim <- function(x) {
  # Define a novel hydrosystem in the mid-Atlantic region
  # using `custom_habitat_template()` or by creating a template
  # using the same columns. You could export this in a .csv
  # for manual entry, use an external dataset with matching
  # variables (columns) as the template, or just use the names
  # of the columns to make your own dataframe in R
  novel_config <- custom_habitat_template(
    species = "ALE",
    built_in = FALSE,
    river = "new_config"
  )

  # Check out the names so we can build a simple,
  # in-line example for demonstration
  names(novel_config)

  # Heavily commented novel habitat definition
  novel_config <- data.frame(
    # Can be anything
    river = "new_config",
    # Must be from pre-defined within species (biological basis for this)
    region = "MAT",
    # Can be anything, not actually used in biological models
    govt = "NY",
    # Used for latitudinal trends in life-history traits for American shad only
    lat = NA,
    # Not actually used in the models, but could be useful for data querying
    # in the future
    lon = NA,
    # Number of dams from each element back to first. This example has two
    # dams that are each the first dam within their "migration route". That
    # means at least one of the dams is on a tributary in this configuration.
    dam_order = c(0, 1, 1),
    # Amount of habitat (surface area in square km)
    Hab_sqkm <- c(0, 1, 1)
  )

  # Choose a species
  species <- "ALE"

  # . Call simulation ----
  res <- sim_pop(
    species = species,
    river = "new_config",
    nyears = 50,
    n_init = runif(1, 1e4, 2e6),
    sr = rbeta(1, 100, 100),
    b = 0.05,
    upstream = c(1, 0.5, 1),
    downstream = 1,
    downstream_j = 1,
    custom_habitat = novel_config,
    output_years = "last"
  )

  # . Define the output lists ----

  retlist <- list(
    res = res
  )

  return(retlist)
}


# Parallel execution ----
# . Load libraries on workers -----
sfLibrary(anadrofish)
sfLibrary(tidyverse)


# . Distribute to workers -----
# Number of simulations to run
# You will need to run this MANY more times (1 million+) to stabilize results
niterations <- 1e2

# Run the simulation ----
# Assign starting time
start <- Sys.time()

# Run the sim
result <- sfLapply(1:niterations, sim)

# Calculate and print run time
total_time <- Sys.time() - start
total_time

# . Stop snowfall ----
sfStop()

# Results ----
# 'result' is a list of lists.

# Extract results dataframes by string and rbind them
res <- lapply(result, function(x) x[[c("res")]])
resdf <- data.frame(rbindlist(res))

# . Quick summary statistics ----
mean(resdf$spawners)

# . Plot ----
custom_plot <- ggplot(resdf, aes(spawners)) +
  geom_histogram() +
  xlab("Spawning adults") +
  ylab("Count")

custom_plot
```

![**Figure 5**: Simulation result for custom alewife river (novel system).](man/figures/custom_ale.jpg?raw=true)

</br>
</br>


### Benchmarking against related R package
This example provides a brief benchmarking demonstration against a similar,
more complex (individual-based) shad and river herring models from the 
[`shadia`](https://github.com/danStich/shadia) R package.

```r
# Libraries ----
library(tidyverse)
library(shadia)
library(anadrofish)
library(microbenchmark)


# Set seed for rng ----
set.seed(12345)


# Benchmarking ----
# Notes:
# Uses default settings for upstream passage and downstream survival
# rates of `1` at all dams, otherwise used same settings across modeling
# frameworks to standardize as much as possible.

# The warnings() output is coming from the C++ function that moves individual
# fish upstream through rivers in shadia::penobscotRiverModel(). This does not
# appear to be influencing accuracy of estimates compared to published research,
# but may result in deserialization of nodes in parallel processing, so we use
# a serial approach to benchmarking below. We have not suppressed those warnings 
# here for the sake of transparency (`shadia` models were even slower before 
# any updates that could have caused this warning).

# We use `microbenchmark::microbenchmark()` because run time for 1 iteration
# of `anadrofish` package models is << 1 second compared to ~ 30 second for
# `shadia` package models.

# The total number of `times` in in `microbenchmark()` would normally be higher,
# but the individual-based models in `shadia` take a long time to run in serial
# and the difference in run times is several orders of magnitude here.
mb_test <- microbenchmark(
  "shadia_check" = {
    test <- penobscotRiverModel(
      nRuns = 1,
      species = "shad",
      nYears = 30,
      n_adults = 10000,
      watershed = TRUE,
      output_years = "last"
    )
  },
  "anadrofish_test" = {
    test <- sim_pop(
      species = "AMS",
      nyears = 30,
      n_init = 10000,
      river = "Penobscot",
      output_years = "last"
    )
  },
  times = 10
)

```

Our results (`mb_test`) should look something like this:

|           expr |       min |         lq |       mean |     median |         uq |        max | neval |    cld|
|           :------- |      ---: |       ---: |       ---: |       ---: |       ---: |       ---: |  ---: |  ---: |
|   shadia_check (ms)| 32428.537 | 34306.0663 | 38115.6585 | 37837.9312 | 42599.1752 | 45740.3324 |    10 | a |
|anadrofish_test (ms)|    55.809 |   111.2171 |   116.7442 |   118.4982 |   133.6141 |   143.2512 |    10 |  b|


## Directories

`data/` Built-in data sets for the package

`inst/examples/` Examples for those requiring more than a one-liner

`inst/data/` Example dataset for `README.md`. Included in `.Rbuildignore`.

`man/` Help files and documentation, example figures for readme

`R/` R functions in scripts

`tests/` Function tests and checks using the `testhat` package

</br>

## References

ASMFC (Atlantic States Marine Fisheries Commission). 2020. American Shad Benchmark Stock Assessment and Peer-Review Report. Atlantic States Marine Fisheries Commission. [https://asmfc.org/wp-content/uploads/2025/01/AmShadBenchmarkStockAssessment_PeerReviewReport_2020_web.pdf](https://asmfc.org/wp-content/uploads/2025/01/AmShadBenchmarkStockAssessment_PeerReviewReport_2020_web.pdf).

ASMFC (Atlantic States Marine Fisheries Commission). 2024. River Herring Benchmark Stock Assessment and Peer-Review Report. Atlantic States Marine Fisheries Commission. [https://asmfc.org/wp-content/uploads/2025/01/RiverHerringAssessment_PeerReviewReport_2024.pdf](https://asmfc.org/wp-content/uploads/2025/01/RiverHerringAssessment_PeerReviewReport_2024.pdf).

Bell, C. E., and B. Kynard. 1985. Mortality of Adult American Shad Passing Through a 17-Megawatt Kaplan Turbine at a Low-Head Hydroelectric Dam. North American Journal of Fisheries Management 5:33-38.[ 10.1577/1548-8659(1985)5<33:MOAASP>2.0.CO;2](https://doi.org/10.1577/1548-8659(1985)5<33:MOAASP>2.0.CO;2)

Csardi G., J. Hester J, H. Wickham, W. Chang, M. Morgan, and D. Tenenbaum. 2024. remotes: R Package Installation from Remote Repositories, Including 'GitHub'. R package version 2.5.0,
[https://CRAN.R-project.org/package=remotes](https://CRAN.R-project.org/package=remotes).

Wickham H., J. Hester, W. Chang, and J. Bryan. 2022. devtools: Tools to Make Developing R Packages Easier.R package version 2.4.5. [https://CRAN.R-project.org/package=devtools](https://CRAN.R-project.org/package=devtools).

Wipplehauser, G. 2021. Recovery of Diadromous Fishes: A Kennebec River Case Study. Transactions of the American Fisheries Society 150:277-290. [https://onlinelibrary.wiley.com/doi/full/10.1002/tafs.10292](https://onlinelibrary.wiley.com/doi/full/10.1002/tafs.10292)

Zydlewski, J., D. S. Stich, S. Roy, M. Bailey, T. Sheehan, and K. Sprankle. 2021. What Have We Lost? Modeling Dam Impacts on American Shad Populations Through Their Native Range. Frontiers in Marine Science 8. [https://doi.org/10.3389/fmars.2021.734213](https://doi.org/10.3389/fmars.2021.734213).
