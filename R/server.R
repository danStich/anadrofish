observeEvent(input$run_button, {
  browser()
})

ALL_SPECIES_VECTOR <- c("Alewife" = "ALE", "American Shad" = "AMS", "Blueback Herring" = "BBH")
REQUIRED_HAB_COLS  <- c("river", "region", "govt", "dam_order", "Hab_sqkm")

`%||%` <- function(x, y) if (is.null(x)) y else x

#' Internal application server
#' 
#' @keywords internal
server <- function(input, output, session) {
  
  # ============================================================================
  #  INITIALIZE RIVER SELECT (NO AUTOSELECTION)
  # ============================================================================
  
  observeEvent(TRUE, {
    spc <- isolate(input$species_input %||% ALL_SPECIES_VECTOR[[1]])
    rivers <- anadrofish::get_rivers(spc)
    
    updateSelectizeInput(
      session, "river_input",
      choices  = rivers,
      selected = character(0),
      server   = TRUE
    )
  }, once = TRUE)
  
  observeEvent(input$species_input, {
    req(input$species_input)
    rivers <- anadrofish::get_rivers(input$species_input)
    
    updateSelectizeInput(
      session, "river_input",
      choices  = rivers,
      selected = character(0),
      server   = TRUE
    )
  })
  
  observeEvent(input$habitat_source, {
    if (identical(input$habitat_source, "builtin")) {
      spc <- isolate(input$species_input %||% ALL_SPECIES_VECTOR[[1]])
      rivers <- anadrofish::get_rivers(spc)
      
      updateSelectizeInput(
        session, "river_input",
        choices  = rivers,
        selected = character(0),
        server   = TRUE
      )
    }
  })
  
  
  # ============================================================================
  #  TEMPLATE DOWNLOAD (CUSTOM HABITAT)
  # ============================================================================
  
  output$downloadTemplate <- downloadHandler(
    filename = function() paste0("habitat_template_", input$species_input, ".csv"),
    content = function(file) {
      template_df <- anadrofish::custom_habitat_template(
        species = input$species_input, built_in = FALSE, river = "MyCustomRiver"
      )
      write.csv(template_df, file, row.names = FALSE)
    }
  )
  
  
  # ============================================================================
  #  SIMULATION ENGINE (MULTI-RUN)
  # ============================================================================
  
  sim_results <- eventReactive(input$run_button, {
    req(input$upstream_input, input$downstream_input, input$downstream_j_input)
    
    n_runs <- max(1L, as.integer(input$n_runs_input %||% 1L))
    n_runs <- min(n_runs, 500L)   # UX cap
    
    output_years <- input$output_years_input %||% "all"
    
    # Force age structure when "last"
    age_structured_flag <- identical(output_years, "last")
    
    up_pass  <- input$upstream_input     / 100
    down_pass <- input$downstream_input / 100
    down_j   <- input$downstream_j_input / 100
    
    args_common <- list(
      species      = input$species_input,
      nyears       = input$nyears_input,
      n_init       = input$n_init_input,
      sr           = input$sr_input,
      b            = input$b_input,
      upstream     = up_pass,
      downstream   = down_pass,
      downstream_j = down_j,
      sex_specific = TRUE,
      output_years = output_years,
      age_structured_output = age_structured_flag
    )
    
    results_list <- vector("list", n_runs)
    river_label  <- NULL
    
    withProgress(message = "Running simulation", value = 0, {
      step <- 1 / (n_runs + 2)
      
      # BUILT-IN HABITAT
      if (identical(input$habitat_source, "builtin")) {
        req(input$river_input)
        river_label <- input$river_input
        
        for (i in seq_len(n_runs)) {
          res <- do.call(anadrofish::sim_pop,
                         c(args_common, list(river = input$river_input)))
          res$run <- i
          results_list[[i]] <- res
          incProgress(step)
        }
        
        # CUSTOM HABITAT
      } else {
        req(input$custom_csv)
        ch <- read.csv(input$custom_csv$datapath)
        
        ch <- ch[!is.na(ch$river) & ch$river != "", , drop = FALSE]
        validate(need(nrow(ch) > 0, "Uploaded CSV missing river names."))
        
        missing_cols <- setdiff(REQUIRED_HAB_COLS, names(ch))
        validate(need(length(missing_cols) == 0,
                      paste0("Missing required column(s): ",
                             paste(missing_cols, collapse = ", "))))
        
        river_label <- as.character(ch$river[1])
        
        for (i in seq_len(n_runs)) {
          res <- do.call(anadrofish::sim_pop,
                         c(args_common,
                           list(river = river_label, custom_habitat = ch)))
          res$run <- i
          results_list[[i]] <- res
          incProgress(step)
        }
      }
      
      incProgress(step)  # finishing
    })
    
    combined <- do.call(rbind, results_list)
    
    list(
      combined = combined,
      runs     = results_list,
      meta     = list(
        river_label  = river_label,
        output_years = output_years,
        n_runs       = n_runs
      )
    )
  })
  
  
  # ============================================================================
  #  CSV DOWNLOAD (LEFT PANEL)
  # ============================================================================
  
  output$downloadData <- downloadHandler(
    filename = function() {
      meta <- sim_results()$meta
      rl   <- meta$river_label %||%
        if (identical(input$habitat_source, "builtin"))
          input$river_input else "custom_river"
      paste0("anadrofish_", input$species_input, "_", rl, "_",
             meta$output_years, "_runs", meta$n_runs, "_",
             Sys.Date(), ".csv")
    },
    content = function(file) {
      write.csv(sim_results()$combined, file, row.names = FALSE)
    }
  )
  
  
  # ============================================================================
  #  TITLE ABOVE PLOT
  # ============================================================================
  
  output$plot_title <- renderText({
    res <- sim_results(); req(res)
    species_name <- names(ALL_SPECIES_VECTOR[ALL_SPECIES_VECTOR == input$species_input])
    meta <- res$meta
    rl   <- meta$river_label %||%
      if (identical(input$habitat_source, "builtin"))
        input$river_input else "custom habitat"
    
    paste(
      "Simulation for", species_name, "in",
      rl, " ",
      if (meta$output_years == "all") "All Years" else "Final Year Only",
      sprintf("(runs: %d)", meta$n_runs)
    )
  })
  
  
  # ============================================================================
  #  PLOT OR EMPTY STATE
  # ============================================================================
  
  output$plot_or_empty <- renderUI({
    if (input$run_button == 0) {
      div(class = "empty-state",
          icon("chart-line"),
          p("Configure parameters and click ",
            strong("Run Simulation"), " to view results here.")
      )
    } else {
      withSpinner(plotOutput("results_plot", height = "500px"))
    }
  })
  
  
  # ============================================================================
  #  MAKE_PLOT()  (REUSABLE FOR RENDER + DOWNLOAD)
  # ============================================================================
  
  make_plot <- reactive({
    res <- sim_results(); req(res)
    df   <- res$combined
    mode <- res$meta$output_years
    
    # Quantiles from UI
    if (!is.null(input$q_range) && length(input$q_range) == 2) {
      q_lo <- max(0, min(1, input$q_range[1] / 100))
      q_hi <- max(0, min(1, input$q_range[2] / 100))
    } else {
      q_lo <- 0.10; q_hi <- 0.90
    }
    
    # ---- ALL YEARS ----------------------------------------------------------
    if (identical(mode, "all")) {
      validate(need(all(c("year", "spawners") %in% names(df)),
                    "Missing columns 'year' or 'spawners'."))
      
      mean_df <- aggregate(spawners ~ year, df, mean)
      lo_df   <- aggregate(spawners ~ year, df, function(x) quantile(x, q_lo))
      hi_df   <- aggregate(spawners ~ year, df, function(x) quantile(x, q_hi))
      
      names(lo_df)[2] <- "lo"
      names(hi_df)[2] <- "hi"
      band_df <- merge(lo_df, hi_df, by = "year")
      
      p <- ggplot(mean_df, aes(year, spawners)) +
        geom_ribbon(
          data = band_df,
          inherit.aes = FALSE,
          aes(x = year, ymin = lo, ymax = hi),
          fill = "#003366", alpha = 0.15
        ) +
        geom_line(color = "#003366", linewidth = 1.2) +
        labs(
          subtitle = sprintf("Mean across runs with %.0f-%.0f%% quantile band",
                             q_lo*100, q_hi*100),
          x = "Year", y = "Number of Spawners"
        ) +
        theme_minimal(base_size = 16)
      
      # optional spaghetti overlay
      if (isTRUE(input$show_spaghetti)) {
        n <- input$spaghetti_n %||% 20
        runs <- sort(unique(df$run))
        n <- min(n, length(runs))
        spag <- df[df$run %in% runs[seq_len(n)], ]
        
        p <- p + geom_line(
          data = spag,
          aes(year, spawners, group = run),
          color = "#003366", alpha = 0.25, linewidth = 0.5
        )
      }
      
      return(p)
    }
    
    # ---- FINAL YEAR (AGE STRUCTURED) ----------------------------------------
    # LONG format
    if ("age" %in% names(df)) {
      if ("sex" %in% names(df)) {
        df <- aggregate(spawners ~ run + age, df, sum)
      } else {
        df <- df[, c("run", "age", "spawners")]
      }
      mean_age <- aggregate(spawners ~ age, df, mean)
      lo_age   <- aggregate(spawners ~ age, df, function(x) quantile(x, q_lo))
      hi_age   <- aggregate(spawners ~ age, df, function(x) quantile(x, q_hi))
      
    } else {
      # WIDE format
      sp_cols <- grep("^spawners", names(df), value = TRUE)
      validate(need(length(sp_cols) > 0,
                    "Missing age-structured output for final year."))
      
      ages <- as.integer(sub("^.*?(\\d+)$", "\\1", sp_cols))
      keep <- !is.na(ages)
      sp_cols <- sp_cols[keep]
      ages    <- ages[keep]
      
      long_list <- lapply(seq_along(sp_cols), function(i) {
        data.frame(
          run = df$run,
          age = ages[i],
          spawners = df[[sp_cols[i]]]
        )
      })
      df <- do.call(rbind, long_list)
      
      mean_age <- aggregate(spawners ~ age, df, mean)
      lo_age   <- aggregate(spawners ~ age, df, function(x) quantile(x, q_lo))
      hi_age   <- aggregate(spawners ~ age, df, function(x) quantile(x, q_hi))
    }
    
    names(lo_age)[2] <- "lo"
    names(hi_age)[2] <- "hi"
    
    band_age <- Reduce(function(x, y) merge(x, y, by = "age"),
                       list(mean_age, lo_age, hi_age))
    names(band_age) <- c("age", "mean", "lo", "hi")
    
    ggplot(band_age, aes(factor(age), mean)) +
      geom_col(fill = "#003366", alpha = 0.8) +
      geom_errorbar(aes(ymin = lo, ymax = hi), width = 0.25) +
      labs(
        subtitle = sprintf("Final-year mean with %.0f-%.0f%% quantile bars",
                           q_lo*100, q_hi*100),
        x = "Age Class", y = "Number of Spawners"
      ) +
      theme_minimal(base_size = 16)
  })
  
  
  # ============================================================================
  #  RENDER PLOT
  # ============================================================================
  
  output$results_plot <- renderPlot({
    make_plot()
  })
  
  
  # ============================================================================
  #  DOWNLOAD PLOT
  # ============================================================================
  
  output$downloadPlot <- downloadHandler(
    filename = function() {
      fmt <- input$plot_format %||% "png"
      paste0("anadrofish_plot_", Sys.Date(), ".", fmt)
    },
    content = function(file) {
      p   <- make_plot()
      fmt <- input$plot_format %||% "png"
      w   <- input$plot_width  %||% 7
      h   <- input$plot_height %||% 4
      dpi <- input$plot_dpi    %||% 300
      
      if (fmt == "png") {
        ggsave(file, p, width = w, height = h,
               dpi = dpi, units = "in", device = "png", bg = "white")
      } else {
        ggsave(file, p, width = w, height = h,
               units = "in", device = "pdf")
      }
    }
  )
  
  
  # ============================================================================
  #  PLOT TAB CSV DOWNLOAD (FULL COMBINED RESULTS)
  # ============================================================================
  
  output$downloadData2 <- downloadHandler(
    filename = function() {
      meta <- sim_results()$meta
      rl   <- meta$river_label %||%
        if (identical(input$habitat_source, "builtin"))
          input$river_input else "custom_river"
      paste0("anadrofish_", input$species_input, "_", rl, "_",
             meta$output_years, "_runs", meta$n_runs, "_",
             Sys.Date(), ".csv")
    },
    content = function(file) {
      write.csv(sim_results()$combined, file, row.names = FALSE)
    }
  )
  
  
  # ============================================================================
  #  SUMMARY STATISTICS
  # ============================================================================
  
  output$summary_stats <- renderUI({
    res <- sim_results(); req(res)
    df   <- res$combined
    mode <- res$meta$output_years
    
    # ---------- ALL YEARS ----------
    if (identical(mode, "all")) {
      yearly_mean <- aggregate(spawners ~ year, df, mean)
      init_pop  <- head(yearly_mean$spawners, 1)
      final_pop <- tail(yearly_mean$spawners, 1)
      mean_pop  <- mean(yearly_mean$spawners)
      peak_pop  <- max(yearly_mean$spawners)
      
      trend_up <- final_pop > init_pop
      trend_txt <- if (trend_up) "Increasing" else "Decreasing"
      trend_col <- if (trend_up) "#198754" else "#dc3545"
      trend_icn <- if (trend_up) icon("arrow-trend-up") else icon("arrow-trend-down")
      
      tagList(
        fluidRow(
          column(3, div(class="metric-tile",
                        div(class="metric-label","Initial Population (Mean)"),
                        div(class="metric-value",format(round(init_pop),big.mark=",")))),
          column(3, div(class="metric-tile",
                        div(class="metric-label","Final Population (Mean)"),
                        div(class="metric-value",format(round(final_pop),big.mark=",")))),
          column(3, div(class="metric-tile",
                        div(class="metric-label","Mean (Across Years)"),
                        div(class="metric-value",format(round(mean_pop),big.mark=",")))),
          column(3, div(class="metric-tile",
                        div(class="metric-label","Peak (Across Years)"),
                        div(class="metric-value",format(round(peak_pop),big.mark=","))))
        ),
        div(class="trend-banner",
            trend_icn,
            p(class="trend-label","Population Trend:"),
            p(class="trend-value",style=paste0("color:",trend_col),trend_txt)
        )
      )
      
      # ---------- FINAL YEAR ----------
    } else {
      # long OR wide
      if ("spawners" %in% names(df)) {
        df_sum <- aggregate(spawners ~ run, df, sum)
      } else {
        sp_cols <- grep("^spawners", names(df), value=TRUE)
        validate(need(length(sp_cols)>0,"Missing age-structured columns."))
        df_sum <- data.frame(
          run = df$run,
          spawners = rowSums(df[, sp_cols, drop=FALSE])
        )
      }
      
      mean_total <- mean(df_sum$spawners)
      min_total  <- min(df_sum$spawners)
      max_total  <- max(df_sum$spawners)
      sd_total   <- sd(df_sum$spawners)
      
      tagList(
        fluidRow(
          column(3, div(class="metric-tile",
                        div(class="metric-label","Final Year Mean"),
                        div(class="metric-value",format(round(mean_total),big.mark=",")))),
          column(3, div(class="metric-tile",
                        div(class="metric-label","Final Year Min"),
                        div(class="metric-value",format(round(min_total),big.mark=",")))),
          column(3, div(class="metric-tile",
                        div(class="metric-label","Final Year Max"),
                        div(class="metric-value",format(round(max_total),big.mark=",")))),
          column(3, div(class="metric-tile",
                        div(class="metric-label","Final Year SD"),
                        div(class="metric-value",format(round(sd_total),big.mark=","))))
        )
      )
    }
  })
}
