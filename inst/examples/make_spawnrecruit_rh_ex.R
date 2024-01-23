# Example usage
\dontrun{
  
  # Use make_spawnrecruit_rh() to simulate proportion of mature
  # fish at each age
  spawn_recruit_vector <- make_spawnrecruit_rh(
    species = "ALE", region = "NNE", sex = "Male")
  
  plot(spawn_recruit_vector, type = "l")
  
}
