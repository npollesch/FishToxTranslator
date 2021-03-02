# Observe Events associated with the Results tab
observeEvent(input$summary_results_table,
  {
    
    if (is.null(input$Check_Scenario_Names_Results))
    {
      shinyjs::info("Error: no scenarios were selected. Please select one or more scenarios.")
      return(10)
    }else
    {
      # inputScenarioNamesResults <- input$Check_Scenario_Names_Results
      output$scenario_summary_results_table <- DT::renderDataTable(
        {
          return_summary_results_table(input$Check_Scenario_Names_Results)
        },
        options = list(scrollX = TRUE)
      )
      shinyjs::show(id = "scenario_summary_results_main")
    }
    
  }
)

# This script contains observe Events for plotting results.
observeEvent(input$plot_dailyPopulation,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$dailyPopulation_out <- renderPlot(
                   {
                     plot_Daily_Population(input$Check_Scenario_Names_Results)
                   }
                 )
                 shinyjs::show(id = "dailyPopulation_out_Main")
               }
             }
)

observeEvent(input$plot_populationBiomass,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$populationBiomass_out <- renderPlot(
                   {
                     plot_Population_Biomass(input$Check_Scenario_Names_Results)
                   }
                 )
                 shinyjs::show(id = "populationBiomass_out_Main")
               }
             }
)

observeEvent(input$plot_meanSize,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$meanSize_out <- renderPlot(
                   {
                     plot_Mean_Size(input$Check_Scenario_Names_Results)
                   }
                 )
                 shinyjs::show(id = "meanSize_out_Main")
               }
             }
)

observeEvent(input$plot_growthPotential,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$growthPotential_out <- renderPlot(
                   {
                     plot_Growth_Potential(input$Check_Scenario_Names_Results)
                   }
                 )
                 shinyjs::show(id = "growthPotential_out_Main")
               }
             }
)

observeEvent(input$plot_transitionalKernel,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$transitionalKernel_out <- renderPlot(
                   {
                     plot_Transitional_Kernel(input$Check_Scenario_Names_Results)
                   }
                 )
                 shinyjs::show(id = "transitionalKernel_out_Main")
               }
             }
)

observeEvent(input$plot_summaryMatrix,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 shinyjs::info("Please select one or more scenarios.")
                 
               }else if (length(input$Check_Scenario_Names_Results) < 2)
               {
                 shinyjs::info("You must select at least 2 scenarios. If only one scenario was simulated and as a result only one is active, you won't be able to display a summary matrix.")
               }else
               {
                 output$summaryMatrix_out <- renderPlot(
                   {
                     plot_Summary_Matrix(input$Check_Scenario_Names_Results)
                   }
                 )
                 shinyjs::show(id = "summaryMatrix_out_Main")
               }
             }
)

#####################################################################################################
# Clear plots events
#####################################################################################################
observeEvent(input$clear_scenarios_summary_results,
             {
               shinyjs::hide(id = "scenario_summary_results_main")
             }
)

observeEvent(input$clear_dailyPopulation,
             {
               shinyjs::hide(id = "dailyPopulation_out_Main")
             }
)

observeEvent(input$clear_populationBiomass,
             {
               shinyjs::hide(id = "populationBiomass_out_Main")
             }
)

observeEvent(input$clear_meanSize,
             {
               shinyjs::hide(id = "meanSize_out_Main")
             }
)

observeEvent(input$clear_growthPotential,
             {
               shinyjs::hide(id = "growthPotential_out_Main")
             }
)

observeEvent(input$clear_transitionalKernel,
             {
               shinyjs::hide(id = "transitionalKernel_out_Main")
             }
)

observeEvent(input$clear_matrix,
             {
               shinyjs::hide(id = "summaryMatrix_out_Main")
             }
)

####################################################################################################
# Download Summary Matrix Data and Summary Results as CSV files.
####################################################################################################
# Downloadable csv of selected dataset
output$Summary_Matrix_Data.csv <- downloadHandler(
  filename = function() {
    paste("Summary_Matrix_Data-", Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    # summMats <- as.data.frame(SummaryMatrix(modelOutputs))
    summMats <- SummaryMatrix(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    write.csv(summMats, file, row.names = FALSE)
  }
)

# Downloadable csv of selected dataset
output$Summary_Results_Table.csv <- downloadHandler(
  filename = function() {
    paste("Summary_Results_Table-", Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    summaryTable <- as.data.frame(SummaryTable(modelOutputs))
    write.csv(summaryTable, file, row.names = FALSE)
  }
)

####################################################################################################
# Modal windows
####################################################################################################
# Summary Results Table
observeEvent(input$export_summaryResults_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotSummaryResults <- NULL
                 output$textMessageSummaryResults <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotSummaryResults")
               }else
               {
                 output$textMessageSummaryResults <- NULL
                 shinyjs::enable(id = "downloadPlotSummaryResults")
                 output$plotSummaryResults <- DT::renderDataTable(
                   {
                     return_summary_results_table(input$Check_Scenario_Names_Results)
                   },
                   options = list(scrollX = TRUE)
                 )
               }
             }
)

output$downloadPlotSummaryResults <- downloadHandler(
  filename <- function()
  {
    paste("Summary_Results_Table", "csv", sep = ".")
  },
  content = function(file) 
  {
    summaryTable <- as.data.frame(SummaryTable(modelOutputs))
    write.csv(summaryTable, file, row.names = FALSE)
  }
) 


# Summary Matrix
observeEvent(input$export_summaryMatrix_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotSummaryMatrix <- NULL
                 output$textMessageSummaryMatrix <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotSummaryMatrix")
                 
               }else if (length(input$Check_Scenario_Names_Results) < 2)
               {
                 output$plotSummaryMatrix <- NULL
                 output$textMessageSummaryMatrix <- renderText(
                   {
                     paste("You must select at least 2 scenarios.",
                           "If only one scenario was simulated and as a result only one is active, ",
                           "you won't be able to display a results matrix.")
                   }
                 )
               }else
               {
                 output$textMessageSummaryMatrix <- NULL
                 shinyjs::enable(id = "downloadPlotSummaryMatrix")
                 output$plotSummaryMatrix <- renderPlot(
                   plot_Summary_Matrix(input$Check_Scenario_Names_Results)
                 )
               }
             }
)

output$downloadPlotSummaryMatrix <- downloadHandler(
  filename <- function()
  {
    paste("Summary_Matrix", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 4,
        height = input$shiny_height * 4,
        res = 300)
    plot_Summary_Matrix(input$Check_Scenario_Names_Results)
    dev.off()
  }
) 

observeEvent(input$export_summaryMatrixTable_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotSummaryMatrixTable <- NULL
                 output$textMessageSummaryMatrixTable <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export table.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotSummaryMatrixTable")
               }else if (length(input$Check_Scenario_Names_Results) < 2)
               {
                 output$plotSummaryMatrixTable <- NULL
                 output$textMessageSummaryMatrixTable <- renderText(
                   {
                     paste("You must select at least 2 scenarios.",
                           "If only one scenario was simulated and as a result only one is active, ",
                           "you won't be able to display a results matrix table.")
                   }
                 )
               }else
               {
                 output$textMessageSummaryMatrixTable <- NULL
                 shinyjs::enable(id = "downloadPlotSummaryMatrixTable")
                 output$plotSummaryMatrixTable <- DT::renderDataTable(
                   {
                     as.data.frame(SummaryMatrix(modelOutputs))
                   },
                   options = list(scrollX = TRUE)
                 )
               }
             }
)

output$downloadPlotSummaryMatrixTable <- downloadHandler(
  filename <- function()
  {
    paste("Summary_Matrix_Table", "csv", sep = ".")
  },
  content = function(file) 
  {
    summMats <- as.data.frame(SummaryMatrix(modelOutputs))
    write.csv(summMats, file, row.names = FALSE)
  }
) 

# Daily Population
observeEvent(input$export_dailyPopulation_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotDailyPopulation <- NULL
                 output$textMessageDailyPopulation <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotDailyPopulation")
               }else
               {
                 output$textMessageDailyPopulation <- NULL
                 shinyjs::enable(id = "downloadPlotDailyPopulation")
                 output$plotDailyPopulation <- renderPlot(
                   plot_Daily_Population(input$Check_Scenario_Names_Results)
                 )
               }
             }
)

output$downloadPlotDailyPopulation <- downloadHandler(
  filename <- function()
  {
    paste("Daily_Population", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Daily_Population(input$Check_Scenario_Names_Results)
    dev.off()
  }
) 

# Population Biomass
observeEvent(input$export_populationBiomass_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotPopulationBiomass <- NULL
                 output$textMessagePopulationBiomass <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotPopulationBiomass")
               }else
               {
                 output$textMessagePopulationBiomass <- NULL
                 shinyjs::enable(id = "downloadPlotPopulationBiomass")
                 output$plotPopulationBiomass <- renderPlot(
                   plot_Population_Biomass(input$Check_Scenario_Names_Results)
                 )
               }
             }
)

output$downloadPlotPopulationBiomass <- downloadHandler(
  filename <- function()
  {
    paste("Population_Biomass", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Population_Biomass(input$Check_Scenario_Names_Results)
    dev.off()
  }
) 

# Mean Size
observeEvent(input$export_meanSize_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotMeanSize <- NULL
                 output$textMessageMeanSize <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotMeanSize")
               }else
               {
                 output$textMessageMeanSize <- NULL
                 shinyjs::enable(id = "downloadPlotMeanSize")
                 output$plotMeanSize <- renderPlot(
                   plot_Mean_Size(input$Check_Scenario_Names_Results)
                 )
               }
             }
)

output$downloadPlotMeanSize <- downloadHandler(
  filename <- function()
  {
    paste("Mean_Size", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Mean_Size(input$Check_Scenario_Names_Results)
    dev.off()
  }
) 

# Growth Potential
observeEvent(input$export_growthPotential_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotGrowthPotential <- NULL
                 output$textMessageGrowthPotential <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotGrowthPotential")
               }else
               {
                 output$textMessageGrowthPotential <- NULL
                 shinyjs::enable(id = "downloadPlotGrowthPotential")
                 output$plotGrowthPotential <- renderPlot(
                   plot_Growth_Potential(input$Check_Scenario_Names_Results)
                 )
               }
             }
)

output$downloadPlotGrowthPotential <- downloadHandler(
  filename <- function()
  {
    paste("Growth_Potential", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Growth_Potential(input$Check_Scenario_Names_Results)
    dev.off()
  }
) 

# Growth Potential
observeEvent(input$export_transitionalKernel_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotTransitionalKernel <- NULL
                 output$textMessageTransitionalKernel <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotTransitionalKernel")
               }else
               {
                 output$textMessageTransitionalKernel <- NULL
                 shinyjs::enable(id = "downloadPlotTransitionalKernel")
                 output$plotTransitionalKernel <- renderPlot(
                   plot_Transitional_Kernel(input$Check_Scenario_Names_Results)
                 )
               }
             }
)

output$downloadPlotTransitionalKernel <- downloadHandler(
  filename <- function()
  {
    paste("Transitional_Kernel", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Transitional_Kernel(input$Check_Scenario_Names_Results)
    dev.off()
  }
) 
