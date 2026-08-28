#' Launch Anadromous Fish Population Simulator
#'
#' Interactive interface for running anadrofish population simulations
#'
#' @return A Shiny application
#'
#' @export

sim_pop_shiny <- function() {
  
  shiny::addResourcePath(
    "www",
    system.file(
      "app/www",
      package = "anadrofish"
    )
  )
  
  shiny::shinyApp(
    ui = ui(),
    server = server
  )
}
