# Example usage
\dontrun{
  
  res <- sim_pop(
    nyears = 50,
    river = 'Penobscot',
    max_age = 9,
    nM = 0.38,
    fM = 0.00,
    n_init = 1e5,
    spawnRecruit = c(0, 0, 0, 0.01, 0.33, 0.84, 0.97, 0.99, 1.00), 
    eggs = c(0, 0, 0, 20654, 34674, 58210, 79433, 88480, 97724),
    sr = 0.50,
    s_prespawn = 0.90,  
    s_hatch = 0.10)
  
  plot(x=res$out_year, y = apply(res[ , c(27:35)], 1, sum) , typ='l')
  
}
