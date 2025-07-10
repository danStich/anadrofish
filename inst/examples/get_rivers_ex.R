# Example usage
\dontrun{
  
# Use get_rivers() to return names of rivers included in package
get_rivers(anadrofish::habitat)

# Sample a random river from those available
get_rivers(anadrofish::habitat)[sample(
  length(get_rivers(anadrofish::habitat)), 1)]  
  
}
