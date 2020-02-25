# Example usage
\dontrun{
  
# Using values from Bailey and Zydlewski (2013)  
  eggs <- c(0, 0, 0, 20654, 34674, 58210, 79433, 88480, 97724)
  sr <- 0.50
  s_hatch = 0.10   

# Calculate expected number of age-0 fish  
  fec <- make_recruits(eggs = eggs, sr = sr, s_hatch = s_hatch)
  
}
