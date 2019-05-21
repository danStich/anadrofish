# River system ----
  data(habitat)

# Select a single HUC 10 
### Need to add options for
### + Calculation scenarios
### + Habitat type
### + Sub-basin extent(s)
  river = 'Penobscot'
  acres = make_habitat(habitat_data = habitat,
                       river = 'Penobscot',
                       type = 'functional'
                       )

# Initial population ----
# Population vital rates
  max_age = 9
  nM = 0.38
  fM = 0.00
  n_init = 1e5
  
# Simulate a fish population at stable age distribution
  pop = make_pop(max_age = max_age,
                 nM = nM,
                 fM = fM,
                 n_init = n_init)
  
  
# Spawners ----
# Define probability of recruitment to spawn- probability of
# recruitment to the first spawning event
# by age class (Bailey and Zydlewski 2013)
### This is using probability of first spawn.
### clearly does not work here because it will always
### result in the oldest age classes having the most fish
  spawnRecruit <- c(0, 0, 0, 0.01, .33, .84, .97, .99, 1.00)  

# Get spawner numbers  
  spawners <- make_spawners(pop, probs = spawnRecruit)
  spawners
  
# Subtract the spawners from the ocean population
  pop <- pop - spawners
  
# Multiply by 0.90 following Bailey and Zydlewski (2013) to
# account for pre-spawn mortality and other factors that 
# reduce spawning probability
### Should probably roll this into 'make_spawners' function
### Can be drawn from a distribution either way
  
# Define prespawn survival
  S_prespawn <- 0.90
  
# Apply prespawn survival to spawners  
  spawners <- spawners * S_prespawn
  
  
# Fecundity ----
### Still needs some thought
### Here we use values from Bailey and Zydlewski (2013) for
### all three of the required arguments.
  
### Eggs:  these are based on (somewhat arbitrary) L-F regressions
### Info can be updated to includee von Bert estimates and
### newer fecundity estimates (?). Is there a new regression being
### developed? I am guessing these are underestimated?
  
### sr:  this one should be a random draw from a fairly
### tight distribution centered around 0.50. There
### may be some new data for different rivers, but
### my impression is that we tend to hover around
### 1:1 in most stocks of American shad
  
### s_hatch:  proportion of eggs surviving to hatch.

# Apply the function to the values identified in comments above
  eggs <- c(0, 0, 0, 20654, 34674, 58210, 79433, 88480, 97724)
  sr <- 0.50
  s_hatch = 0.10   
  
  fec <- make_fec(eggs = eggs, sr = sr, s_hatch = s_hatch)

    
# Recruitment ----  
# Run Beverton-Holt model to predict number
# of age-0 recruits in freshwater under 
# varying habitat amounts with 100 fish and
# default parameter settings.
  
### These first two are just sanity checks to
### make sure we are getting good, age-structured
### estimates of fecundity that are proportionally
### bound over a single carrying capacity based on
### total functional habitat.
  
# # Run the Beverton-Holt curve for a 100 acre area
# # assuming no age-structure, and a sex ratio of 1:1.
# ### Note that sex ratio could come in to play above
# ### where we make fecundity (create a new fxn for that).
#   recruits = beverton_holt(S=sum(spawners)*sr,
#                            acres = acres,
#                            age_structured = FALSE
#                            )
#   recruits
#   
# # Run age-structured Beverton-Holt curve  
#   recruits_age = beverton_holt(S=spawners*sr,
#                                acres = acres,
#                                age_structured = TRUE
#                                )
#   recruits_age
#   sum(recruits_age)
  
# Run age-structured Beverton-Holt curve with
# age-specific fecundities. 
### Note that the result is much reduced compared
### to those above because of reduced overall
### fecundity
  recruits_f_age = beverton_holt(a = fec, 
                                 S=spawners,
                                 acres = acres,
                                 age_structured = TRUE
                                 )
  recruits_f_age
  age0 <- sum(recruits_f_age)
  
# Post-spawn dynamics ----
### Everything below this is play code ###  

# Post-spawn survival  
  
### NEED TO ADD:
### - Hatch-to-outmigrant survival
### - Outmigrant survival
###    + Adults (incl. post-spawn survival)
###    + Juveniles
  
  
# Project population ----
### It would be really nice if the rates in this 
### function could be the same as those used in the
### 'make_pop' function, but I guess it doesn't matter
  
# Now, project the population using a leslie matrix
  pop <- project_pop(pop + spawners, age0 = age0, nM = nM, fM = fM)  

# Make a list of objects for export
  out <- list(
    river = river,
    max_age = max_age,
    nM = nM,
    fM = fM,
    n_init = n_init,
    spawnRecruit = spawnRecruit,
    eggs = eggs,
    sr = sr,
    s_hatch = s_hatch,
    S_prespawn = S_prespawn,
    spawners = spawners
  )
  