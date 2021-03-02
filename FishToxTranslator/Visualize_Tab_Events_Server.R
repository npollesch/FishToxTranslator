# This script contains observe Events for plotting results.

observeEvent(input$slider_DaySelection,
  {
    dayNumber <- input$slider_DaySelection
    updateSliderInput(session, 
                      inputId = "slider_parameters",
                      value = dayNumber)
  },
  ignoreInit = TRUE
)

observeEvent(input$slider_parameters,
             {
               slider_position <- input$slider_parameters
               updateNumericInput(session, 
                                  inputId = "slider_DaySelection",
                                  value = slider_position)
             },
             ignoreInit = TRUE
)


####################################################################################################
#  Plotting events
####################################################################################################
observeEvent(input$plot_growth,
             {
               if (is.null(input$Check_Scenario_Names))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$Growth_out <- renderPlot(
                   {
                     plot_growth_parameters(input$Check_Scenario_Names, input$slider_parameters)
                   }
                 )
                 shinyjs::show(id = "Growth_out_Main")
               }
             }
)

observeEvent(input$plot_survival,
             {
               if (is.null(input$Check_Scenario_Names))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$Survival_out <- renderPlot(
                   {
                     plot_survival_parameters(input$Check_Scenario_Names, input$slider_parameters)
                   }
                 )
                 shinyjs::show(id = "Survival_out_Main")
               }
             }
)

observeEvent(input$plot_reproduction,
             {
               if (is.null(input$Check_Scenario_Names))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$Reproduction_out <- renderPlot(
                   {
                     plot_reproduction_parameters(input$Check_Scenario_Names, input$slider_parameters)
                   }
                 )
                 shinyjs::show(id = "Reproduction_out_Main")
               }
             }
)


observeEvent(input$plot_spawning_probs,
             {
               if (is.null(input$Check_Scenario_Names))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$SpawningProb_Out <- renderPlot(
                   {
                     plot_scenarios_spawning_probabilities(input$Check_Scenario_Names)
                   }
                 )
                 shinyjs::show(id = "SpawningProb_out_Main")
               }
             }
)

observeEvent(input$plot_survival_decs,
             {
               if (is.null(input$Check_Scenario_Names))
               {
                 shinyjs::info("Please select one or more scenarios.")

               }else
               {
                 output$SurvivalDecrement_out <- renderPlot(
                   {
                     plot_scenarios_survival_decrements(input$Check_Scenario_Names)
                   }
                 )
                 shinyjs::show(id = "SurvivalDecrement_out_Main")
               }
             }
)

observeEvent(input$plot_exposure_concs,
             {
               if (is.null(input$Check_Scenario_Names))
               {
                 shinyjs::info("Please select one or more scenarios.")

               }else
               {
                 output$ExposureConcentration_out <- renderPlot(
                   {
                     plot_scenarios_exposure_concentrations(input$Check_Scenario_Names)
                   }
                 )
                 shinyjs::show(id = "ExposureConcentration_out_Main")
               }
             }
)

observeEvent(input$Check_Scenario_Names,
  {
    inputScenariosToVis <- input$Check_Scenario_Names
    if (is.null(inputScenariosToVis))
    {
      shinyjs::show(id = "Visualization_SPB")
      shinyjs::show(id = "Visualization_SDEC")

    }else
    {
      surv_decr_exists <- FALSE
      for (scenario in 1:length(inputScenariosToVis))
      {
        surv_decr_exists <- exists("survival_decrement", parameters[[inputScenariosToVis[scenario]]])
        if (surv_decr_exists == TRUE)
        {
          shinyjs::show(id = "Visualization_SPB")
          shinyjs::show(id = "Visualization_SDEC")
          break
        }
      }
      if (surv_decr_exists == FALSE)
      {
        shinyjs::hide(id = "Visualization_SDEC")
      }
    }
  },
  ignoreNULL = TRUE
)

#####################################################################################################
# Clear plots events
#####################################################################################################
observeEvent(input$clear_growth,
  {
    shinyjs::hide(id = "Growth_out_Main")
  }
)

observeEvent(input$clear_survival,
             {
               shinyjs::hide(id = "Survival_out_Main")
             }
)

observeEvent(input$clear_reproduction,
             {
               shinyjs::hide(id = "Reproduction_out_Main")
             }
)

observeEvent(input$clear_spawning_probabilities,
             {
               shinyjs::hide(id = "SpawningProb_out_Main")
             }
)

observeEvent(input$clear_survival_decrements,
             {
               shinyjs::hide(id = "SurvivalDecrement_out_Main")
             }
)

observeEvent(input$clear_exposure_concentrations,
             {
               shinyjs::hide(id = "ExposureConcentration_out_Main")
             }
)

output$calendar_format <- renderText(
  {
    cdate <- as.POSIXct("2018-10-31")
    cdate <- update(cdate, year = 2018, yday = input$slider_parameters)
    cmonth <- month.name[month(cdate)]
    cday <- mday(cdate)
    paste("Calendar date is ", cmonth, " ", cday)
  }
)

observe(
  {
    cdate <- as.POSIXct("2018-10-31")
    cdate <- update(cdate, year = 2018, yday = input$slider_parameters)
    cmonth <- month.name[month(cdate)]
    cday <- mday(cdate)
    lbl_str <- paste("Corresponding calendar date is ", cmonth, " ", cday)
    updateSliderInput(session, inputId = "slider_parameters", label = lbl_str)
  }
)

####################################################################################################
# Observe events that will trigger the opening of modal windows for downloading plots
####################################################################################################

# Growth Functions
observeEvent(input$export_growth_modal,
  {
    if (is.null(input$Check_Scenario_Names))
    {
      output$plotGrowth <- NULL
      output$textMessageGrowth <- renderText(
        {
          paste("Please select one or more scenarios before attempting to export a plot.", 
                "To close this window click the 'Close' button below.")
        }
      )
      shinyjs::disable(id = "downloadPlotGrowth")
    }else
    {
      output$textMessageGrowth <- NULL
      shinyjs::enable(id = "downloadPlotGrowth")
      output$plotGrowth <- renderPlot(
        plot_growth_parameters(input$Check_Scenario_Names, input$slider_parameters)
      )
    }
  }
)

output$downloadPlotGrowth <- downloadHandler(
  filename <- function()
  {
    paste("Growth_Functions", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_growth_parameters(input$Check_Scenario_Names, input$slider_parameters)
    dev.off()
  }
) 

# Survival Functions
observeEvent(input$export_survival_modal,
             {
               if (is.null(input$Check_Scenario_Names))
               {
                 output$plotSurvival <- NULL
                 output$textMessageSurvival <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 
                 shinyjs::disable(id = "downloadPlotSurvival")
               }else
               {
                 output$textMessageSurvival <- NULL
                 shinyjs::enable(id = "downloadPlotSurvival")
                 output$plotSurvival <- renderPlot(
                   plot_survival_parameters(input$Check_Scenario_Names, input$slider_parameters)
                 )
               }
             }
)

output$downloadPlotSurvival <- downloadHandler(
  filename <- function()
  {
    paste("Survival_Functions", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_survival_parameters(input$Check_Scenario_Names, input$slider_parameters)
    dev.off()
  }
) 

# Reproduction Functions
observeEvent(input$export_reproduction_modal,
             {
               if (is.null(input$Check_Scenario_Names))
               {
                 output$plotReproduction <- NULL
                 output$textMessageReproduction <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 
                 shinyjs::disable(id = "downloadPlotReproduction")
               }else
               {
                 output$textMessageReproduction <- NULL
                 shinyjs::enable(id = "downloadPlotReproduction")
                 output$plotReproduction <- renderPlot(
                   plot_reproduction_parameters(input$Check_Scenario_Names, input$slider_parameters)
                 )
               }
             }
)

output$downloadPlotReproduction <- downloadHandler(
  filename <- function()
  {
    paste("Reproduction_Functions", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_reproduction_parameters(input$Check_Scenario_Names, input$slider_parameters)
    dev.off()
  }
) 

# Spawning Probabilities
observeEvent(input$export_spawning_modal,
             {
               if (is.null(input$Check_Scenario_Names))
               {
                 output$plotSpawning <- NULL
                 output$textMessageSpawning <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 
                 shinyjs::disable(id = "downloadPlotSpawning")
               }else
               {
                 output$textMessageSpawning <- NULL
                 shinyjs::enable(id = "downloadPlotSpawning")
                 output$plotSpawning <- renderPlot(
                   plot_scenarios_spawning_probabilities(input$Check_Scenario_Names)
                 )
               }
             }
)

output$downloadPlotSpawning <- downloadHandler(
  filename <- function()
  {
    paste("Spawning_Functions", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_scenarios_spawning_probabilities(input$Check_Scenario_Names)
    dev.off()
  }
) 

# Survival Decrements
observeEvent(input$export_survivalDecrement_modal,
             {
               if (is.null(input$Check_Scenario_Names))
               {
                 output$plotSurvivalDecrement <- NULL
                 output$textMessageSurvivalDecrement <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 
                 shinyjs::disable(id = "downloadPlotSurvivalDecrement")
               }else
               {
                 output$textMessageSurvivalDecrement <- NULL
                 shinyjs::enable(id = "downloadPlotSurvivalDecrement")
                 output$plotSurvivalDecrement <- renderPlot(
                   plot_scenarios_survival_decrements(input$Check_Scenario_Names)
                 )
               }
             }
)

output$downloadPlotSurvivalDecrement <- downloadHandler(
  filename <- function()
  {
    paste("Survival_Decrement", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_scenarios_survival_decrements(input$Check_Scenario_Names)
    dev.off()
  }
) 

# Exposure Concentrations
observeEvent(input$export_exposureConcentration_modal,
             {
               if (is.null(input$Check_Scenario_Names))
               {
                 output$plotExposureConcentration <- NULL
                 output$textMessageExposureConcentration <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 
                 shinyjs::disable(id = "downloadPlotExposureConcentration")
               }else
               {
                 output$textMessageExposureConcentration <- NULL
                 shinyjs::enable(id = "downloadPlotExposureConcentration")
                 output$plotExposureConcentration <- renderPlot(
                   plot_scenarios_exposure_concentrations(input$Check_Scenario_Names)
                 )
               }
             }
)

output$downloadPlotExposureConcentration <- downloadHandler(
  filename <- function()
  {
    paste("Exposure_Concentrations", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_scenarios_exposure_concentrations(input$Check_Scenario_Names)
    dev.off()
  }
) 
