ALL_SPECIES_VECTOR <- c("Alewife" = "ALE", "American Shad" = "AMS", "Blueback Herring" = "BBH")

#' Internal application UI
#' 
#' @keywords internal
ui <- function(){ 
  fluidPage(
    title = "Anadromous Fish Population Simulator",
    
    theme = bs_theme(
      version = 5,
      base_font = font_google("Inter"),
      primary = "#003366"
  ),
  
  # --- Plot Options & Download modal ---
  tags$div(
    id = "plotOptionsModal",
    class = "modal fade",
    tabindex = "-1",
    tags$div(
      class = "modal-dialog modal-lg modal-dialog-centered",
      tags$div(
        class = "modal-content",
        tags$div(
          class = "modal-header py-2",
          style = "background-color: #003366; color: white;",
          tags$h6(class = "modal-title mb-0", icon("sliders"), " Plot Options & Download"),
          tags$button(type = "button", class = "btn-close btn-close-white", `data-bs-dismiss` = "modal")
        ),
        tags$div(
          class = "modal-body py-2",
          tags$p(tags$strong("Display Options"), class = "mb-1"),
          fluidRow(
            column(5,
                   sliderInput("q_range", "Quantile band",
                               min = 0, max = 100, value = c(5, 95), step = 1)
            ),
            column(3,
                   br(),
                   checkboxInput("show_spaghetti", "Spaghetti", value = TRUE)
            ),
            column(4,
                   conditionalPanel(
                     condition = "input.show_spaghetti",
                     numericInput("spaghetti_n", "Runs to overlay", value = 10, min = 1, step = 1)
                   )
            )
          ),
          tags$hr(class = "my-2"),
          tags$p(tags$strong("Download"), class = "mb-1"),
          fluidRow(
            column(4,
                   selectInput("plot_format", "Plot format",
                               choices = c("PNG (.png)" = "png", "PDF (.pdf)" = "pdf"),
                               selected = "png")
            ),
            column(3,
                   numericInput("plot_width", "Width (in)", value = 7, min = 3, step = 0.5)
            ),
            column(3,
                   numericInput("plot_height", "Height (in)", value = 4, min = 2, step = 0.5)
            ),
            column(2,
                   # DPI applies to PNG; ignored for PDF
                   numericInput("plot_dpi", "DPI", value = 300, min = 72, step = 50)
            )
          ),
          fluidRow(
            column(12,
                   div(style = "display: flex; gap: 8px;",
                       downloadButton("downloadPlot", "Download Plot"),
                       downloadButton("downloadData", "Download Results CSV")
                   )
            )
          )
        ),
        tags$div(
          class = "modal-footer py-2",
          tags$button(type = "button", class = "btn btn-primary btn-sm",
                      `data-bs-dismiss` = "modal", "Close")
        )
      )
    )
  ),
  
  # --- Help & About modal ---
  # NOTE: Ensure the Help modal markup exists in your app so the button below works:
  # tags$div(id = "helpModal", class = "modal fade", ...)
  
  # Help & About Modal definition
  tags$div(
    id = "helpModal",
    class = "modal fade",
    tabindex = "-1",
    tags$div(
      class = "modal-dialog modal-lg modal-dialog-scrollable",
      tags$div(
        class = "modal-content",
        tags$div(
          class = "modal-header",
          style = "background-color: #003366; color: white;",
          tags$h5(class = "modal-title", icon("circle-info"), " About the Anadromous Fish Population Simulator"),
          tags$button(type = "button", class = "btn-close btn-close-white", `data-bs-dismiss` = "modal")
        ),
        tags$div(
          class = "modal-body",
          
          # Overview
          tags$h5(icon("fish"), " What is this app?"),
          tags$p("This simulator provides an interactive interface to the ",
                 tags$a("anadrofish", href = "https://github.com/danStich/anadrofish", target = "_blank"),
                 " R package, which models anadromous fish population responses to dams, fisheries, and
                 restoration activities in Atlantic coastal rivers of Canada and the United States."),
          tags$p("The core ", tags$code("sim_pop()"), " function links dam passage rates to habitat availability
                 and stochastic population models to simulate species-specific responses across marine and
                 freshwater habitats."),
          
          tags$hr(),
          
          # Species
          tags$h5(icon("water"), " Supported Species"),
          tags$ul(
            tags$li(tags$strong("Alewife"), tags$em(" (Alosa pseudoharengus)"),
                    " - 222 populations in Atlantic Coastal rivers; peer-reviewed in the 2024 ASMFC River Herring Benchmark Stock Assessment"),
            tags$li(tags$strong("American Shad"), tags$em(" (Alosa sapidissima)"),
                    " - 167 populations; peer-reviewed in the 2020 ASMFC Benchmark Stock Assessment"),
            tags$li(tags$strong("Blueback Herring"), tags$em(" (Alosa aestivalis)"),
                    " - 238 populations; peer-reviewed in the 2024 ASMFC River Herring Benchmark Stock Assessment")
          ),
          tags$p("Rivers range from Florida, USA (St. Johns River) to Quebec, Canada (St. Lawrence drainage).
                 Use ", tags$code("get_rivers()"), " in R to see the full list per species."),
          
          tags$hr(),
          
          # Parameters guide
          tags$h5(icon("sliders"), " Parameter Guide"),
          tags$table(
            class = "table table-sm table-bordered",
            tags$thead(tags$tr(tags$th("Parameter"), tags$th("Description"))),
            tags$tbody(
              tags$tr(tags$td(tags$strong("Number of Years")),
                      tags$td("How many years the simulation runs. More years allow the population to stabilize. Recommended: 50+ years.")),
              tags$tr(tags$td(tags$strong("Initial Population Size")),
                      tags$td("Starting number of spawning adults (n_init). Typically 10,000-1,000,000 depending on the river.")),
              tags$tr(tags$td(tags$strong("Sex Ratio (sr)")),
                      tags$td("Proportion of females in the population. 0.5 means an equal 50/50 male-to-female split.")),
              tags$tr(tags$td(tags$strong("SR Parameter (b)")),
                      tags$td("Beverton-Holt stock-recruitment parameter controlling density dependence. Lower values = stronger density dependence.")),
              tags$tr(tags$td(tags$strong("Number of model runs")),
                      tags$td("Number of model runs. Minimum of 10 simulations, up to 500. Note that alewife take longest, and >100 runs can take a little while.")),              
              tags$tr(tags$td(tags$strong("Upstream Passage (Adults)")),
                      tags$td("Percentage of adult fish that successfully pass upstream through dams (0-100%). 100% = no dams.")),
              tags$tr(tags$td(tags$strong("Downstream Passage (Adults)")),
                      tags$td("Percentage of adult fish surviving downstream passage through dams after spawning.")),
              tags$tr(tags$td(tags$strong("Downstream Passage (Juveniles)")),
                      tags$td("Percentage of juvenile fish surviving their downstream migration through dams to the ocean.")),
              tags$tr(tags$td(tags$strong("Output Years")),
                      tags$td(tags$strong("All Years:"), " returns spawner count for each year (good for trend analysis). ",
                              tags$strong("Final Year Only:"), " returns age-structured output for the last simulated year.")),
            )
          ),
          
          tags$hr(),
          
          # Custom habitat
          tags$h5(icon("file-csv"), " Using a Custom Habitat CSV"),
          tags$p("You can supply your own river habitat data instead of using built-in rivers.
                 Click ", tags$strong("Download Template"), " in the Habitat tab to get a properly
                 formatted CSV for your selected species. Fill in the habitat area (", tags$code("Hab_sqkm"),
                 ") and dam ordering (", tags$code("dam_order"), ") for each segment, then upload it."),
          tags$p(tags$strong("Key columns:"), " ", tags$code("river"), ", ", tags$code("region"), ", ",
                 tags$code("govt"), ", ", tags$code("dam_order"), " (number of dams from each segment to the first), ",
                 "and ", tags$code("Hab_sqkm"), " (habitat surface area in square kilometers)."),
          
          
        ),
        tags$div(
          class = "modal-footer",
          tags$a("View on GitHub", href = "https://github.com/danStich/anadrofish",
                 target = "_blank", class = "btn btn-outline-secondary btn-sm"),
          tags$button(type = "button", class = "btn btn-primary btn-sm",
                      `data-bs-dismiss` = "modal", "Close")
        )
      )
    )
  ),
  
  # Main Title row with Help button
  div(
    class = "app-header",
    h2(icon("fish"), "Anadromous Fish Population Simulator"),
    tags$button(
      type = "button",
      class = "btn btn-outline-primary btn-sm",
      `data-bs-toggle` = "modal",
      `data-bs-target` = "#helpModal",
      icon("circle-info"), " Help & About"
    )
  ),
  
  fluidRow(
    # --- LEFT: Inputs ---
    column(
      width = 4,
      navset_card_underline(
        id = "input_tabs",
        
        # TAB: Habitat
        nav_panel(
          "Habitat", icon = icon("map-location-dot"),
          
          # Species with "Type to search..." placeholder
          selectizeInput(
            "species_input", "Select Species:",
            choices = ALL_SPECIES_VECTOR,
            selected = ALL_SPECIES_VECTOR[[1]],
            options = list(placeholder = "Type to search species")
          ),
          
          radioButtons(
            "habitat_source", "Habitat Source:",
            choices = c("Built-in River" = "builtin", "Custom (Upload CSV)" = "custom")
          ),
          
          # River with "Type to search..." placeholder (choices loaded from server)
          conditionalPanel(
            condition = "input.habitat_source == 'builtin'",
            selectizeInput(
              "river_input", "Select River:",
              choices = NULL,
              options = list(placeholder = "Type to search rivers")
            )
          ), 
          br(),
          
          conditionalPanel(
            condition = "input.habitat_source == 'custom'",
            fileInput("custom_csv", "Upload Habitat CSV", accept = ".csv"),
            downloadButton("downloadTemplate", "Download Template", class = "btn-secondary btn-sm w-100")
          ),
          numericInput("n_runs_input", "Number of model runs:", value = 10, min = 10, max = 500, step = 1)
        ),
        
        # TAB: Parameters
        nav_panel(
          "Parameters", icon = icon("sliders"),
          numericInput("nyears_input", "Number of Years:", value = 50, min = 10, max = 500),
          numericInput("n_init_input", "Initial Population Size:", value = 10000, min = 100),
          sliderInput("sr_input", "Sex ratio:", value = 0.50, min = 0, max = 1, step = 0.01),
          numericInput("b_input", "SR Parameter (b):", value = 0.05, min = 0.00001, max = 0.50),
          radioButtons(
            "output_years_input", "Output Years:",
            choices = c("All Years" = "all", "Final Year Only" = "last"),
            inline = TRUE, selected = "all"
          )),
        
        # TAB: Passage
        nav_panel(
          "Passage", icon = icon("water"),
          sliderInput("upstream_input", "Upstream (Adults)", min = 0, max = 100, value = 90),
          sliderInput("downstream_input", "Downstream (Adults)", min = 0, max = 100, value = 90),
          sliderInput("downstream_j_input", "Downstream (Juv.)", min = 0, max = 100, value = 90)
        )
      ),
      
      # Actions
      card(
        card_body(
          actionButton("run_button", "Run Simulation", icon = icon("play"),
                       class = "btn-primary w-100 mb-2", style = "font-size: 16px; font-weight: bold;"),
          # downloadButton("downloadData", "Download Results CSV", class = "w-100")
        )
      )
    ),
    
    # --- RIGHT: Outputs ---
    column(
      width = 8,
      navset_card_underline(
        
        nav_panel(
          "Plot Output", icon = icon("chart-line"),
          fluidRow(
            column(width = 12,
                   tags$button(
                     type = "button",
                     class = "btn btn-outline-secondary btn-sm mb-2",
                     `data-bs-toggle` = "modal",
                     `data-bs-target` = "#plotOptionsModal",
                     icon("sliders"), " Plot Options & Download"
                   )
            )
          ),
          h4(textOutput("plot_title"), align = "center"),
          uiOutput("plot_or_empty")
        ),
        
        nav_panel(
          "Summary Statistics", icon = icon("list"),
          br(),
          h3("Simulation Results Summary"),
          hr(),
          withSpinner(uiOutput("summary_stats"))
        )
      )
    )
  )
)
}
