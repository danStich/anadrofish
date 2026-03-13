# anadrofish: Anadromous Fish Population Responses to Habitat Changes

The anadrofish package is a collection of tools for running coastwide or
river-specific population models for anadromous fish in response to
habitat change from dams.

## Functions called directly

The following functions can be called directly from anadrofish:

- [`sim_pop`](https://danstich.github.io/anadrofish/reference/sim_pop.md):

  main function used to simulate populations

- [`add_unequal_vectors`](https://danstich.github.io/anadrofish/reference/add_unequal_vectors.md):

  add vectors of unequal length

- [`beverton_holt`](https://danstich.github.io/anadrofish/reference/beverton_holt.md):

  Beverton-Holt recruitment with density dependence

- [`custom_habitat_template`](https://danstich.github.io/anadrofish/reference/custom_habitat_template.md):

  make custom habitat for an existing river or a template for a new
  river of interest

- [`get_dams`](https://danstich.github.io/anadrofish/reference/get_dams.md):

  get dams for specified river from American shad habitat data

- [`get_govt`](https://danstich.github.io/anadrofish/reference/get_govt.md):

  get governmental unit for specified river by species

- [`get_region`](https://danstich.github.io/anadrofish/reference/get_region.md):

  get region for specified river by species

- [`get_rivers`](https://danstich.github.io/anadrofish/reference/get_rivers.md):

  find out which rivers are available

- [`make_downstream`](https://danstich.github.io/anadrofish/reference/make_downstream.md):

  river-specific, catchment-wide downstream survival through dams

- [`make_eggs`](https://danstich.github.io/anadrofish/reference/make_eggs.md):

  simulate eggs per female by species and river

- [`make_habitat`](https://danstich.github.io/anadrofish/reference/make_habitat.md):

  subset of
  [`habitat`](https://danstich.github.io/anadrofish/reference/habitat.md)
  dataset for selected river

- [`make_iteroparity`](https://danstich.github.io/anadrofish/reference/make_iteroparity.md):

  predict iteroparity from latitude based on reported relationships

- [`make_lat`](https://danstich.github.io/anadrofish/reference/make_lat.md):

  get latitude for specified river

- [`make_maxage`](https://danstich.github.io/anadrofish/reference/make_maxage.md):

  get region-specific maximum age for specified population

- [`make_mortality`](https://danstich.github.io/anadrofish/reference/make_mortality.md):

  calculate natural, instantaneous mortality by river

- [`make_pop`](https://danstich.github.io/anadrofish/reference/make_pop.md):

  simulate starting population

- [`make_postspawn`](https://danstich.github.io/anadrofish/reference/make_postspawn.md):

  predict post-spawning survival based on natural mortality and
  iteroparity

- [`make_recruits`](https://danstich.github.io/anadrofish/reference/make_recruits.md):

  predict recruits from number of adults, fecundity, sex ratio, and
  juvenile survival

- [`make_spawners`](https://danstich.github.io/anadrofish/reference/make_spawners.md):

  draw spawners from age-specific spawn recruitment probabilities

- [`make_spawnrecruit`](https://danstich.github.io/anadrofish/reference/make_spawnrecruit.md):

  get region- and age-specific probabilities of recruitment to spawn

- [`project_pop`](https://danstich.github.io/anadrofish/reference/project_pop.md):

  project population to next time step without reproduction

- [`sim_juvenile_s`](https://danstich.github.io/anadrofish/reference/sim_juvenile_s.md):

  simulate juvenile survival based on reported rates

- [`lower95`](https://danstich.github.io/anadrofish/reference/lower95.md):

  convenience function for calculating upper 95% CI

- [`upper95`](https://danstich.github.io/anadrofish/reference/upper95.md):

  convenience function for calculating lower 95% CI

## Data

The following built-in datasets are included:

- [`crecco_1983`](https://danstich.github.io/anadrofish/reference/crecco_1983.md):

  Regression parameters for latitude-iteroparity relationship in
  American shad

- [`fl_tl_conversions`](https://danstich.github.io/anadrofish/reference/fl_tl_conversions.md):

  Fork length - total length conversions for river herring

- [`habitat`](https://danstich.github.io/anadrofish/reference/habitat.md):

  American shad habitat data

- [`habitat_ale`](https://danstich.github.io/anadrofish/reference/habitat_ale.md):

  Alewife habitat data

- [`habitat_bbh`](https://danstich.github.io/anadrofish/reference/habitat_bbh.md):

  Blueback herring habitat data

- [`jessop_1993`](https://danstich.github.io/anadrofish/reference/jessop_1993.md):

  Fork length-fecundity relationships for alewife

- [`length_weight`](https://danstich.github.io/anadrofish/reference/length_weight.md):

  Regional length-weight regression parameters for American shad

- [`lw_pars_rh`](https://danstich.github.io/anadrofish/reference/lw_pars_rh.md):

  Regional length-weight regression parameters for river herring

- [`maki_pars`](https://danstich.github.io/anadrofish/reference/maki_pars.md):

  Regional spawner recruitment parameters for river herring

- [`maturity`](https://danstich.github.io/anadrofish/reference/maturity.md):

  Regional spawner recruitment probabilities for American shad

- [`max_ages`](https://danstich.github.io/anadrofish/reference/max_ages.md):

  Regional maximum ages by sex and species

- [`mortality`](https://danstich.github.io/anadrofish/reference/mortality.md):

  Regional mortality estimates for American shad by sex

- [`mortality_rh`](https://danstich.github.io/anadrofish/reference/mortality_rh.md):

  Regional mortality estimates for river herring by sex

- [`olney_mcbride`](https://danstich.github.io/anadrofish/reference/olney_mcbride.md):

  Regression parameters for weight-batch fecundity relationships

- [`vbgf_ale`](https://danstich.github.io/anadrofish/reference/vbgf_ale.md):

  von Bertalanffy growth parameters for alewife

- [`vbgf_bbh`](https://danstich.github.io/anadrofish/reference/vbgf_bbh.md):

  von Bertalanffy growth parameters for blueback herring

- [`vbgf_NI`](https://danstich.github.io/anadrofish/reference/vbgf_NI.md):

  von Bertalanffy growth parameters for NI American shad

- [`vbgf_SI`](https://danstich.github.io/anadrofish/reference/vbgf_SI.md):

  von Bertalanffy growth parameters for SI American shad

- [`vbgf_SP`](https://danstich.github.io/anadrofish/reference/vbgf_SP.md):

  von Bertalanffy growth parameters for SP American shad

## See also

Useful links:

- <https://danstich.github.io/anadrofish/>

## Author

**Maintainer**: Daniel S. Stich <daniel.stich@oneonta.edu>
([ORCID](https://orcid.org/0000-0002-8946-1115))

Authors:

- J. D. Hardesty ([ORCID](https://orcid.org/0009-0009-0280-1999))

- N. T. Jordan ([ORCID](https://orcid.org/0009-0009-8632-6979))

- S. G. Roy ([ORCID](https://orcid.org/0000-0002-2491-948X))

- T. F. Sheehan ([ORCID](https://orcid.org/0000-0002-9689-1180))

- S. D. Snyder ([ORCID](https://orcid.org/0000-0003-3286-4957))

- J. D. Zydlewski ([ORCID](https://orcid.org/0000-0002-2255-2303))
