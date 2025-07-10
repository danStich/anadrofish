# Example usage
\dontrun{
  
# Run Beverton-Holt model to predict number
# of age-0 recruits in freshwater under 
# varying habitat amount with 100 fish and
# default parameter settings.
  
# Start by making a sequence of habitat amounts (acres)
acres <- seq(0, 100, 1)
  
# Run the Beverton-Holt curve for 100 individuals
# in varying habitats with default a and b parameters
recruits <- beverton_holt(S = 100, acres = seq(0, 1000, 10))
  
# Plot the results
plot(x = acres, y = recruits, type='l')
  
}
