# Download/Export scenario
observeEvent(input$Export_Scenario,
             {
               shinyjs::show(id = "ExportScenarioButton")
               shinyjs::hide(id = "DownloadScenarioButton")
               
               updateSelectInput(session, 
                                 inputId = "downloadScenario",
                                 selected = "None Selected")
               
               output$text_export_scenario <- NULL
               
               shinyjs::enable(id = "downloadScenario")
               shinyjs::enable(id = "Download_Scenario")
             }
             
)

observe(
  {
    if (input$downloadScenario == "None Selected" || input$downloadScenario == "")
    {
      shinyjs::hide(id = "DownloadScenarioButton")
    }else
    {
      shinyjs::show(id = "DownloadScenarioButton")
    }
  }
)

output$Download_Scenario <- downloadHandler(
  filename = function() {
      paste(input$downloadScenario, "_Parameters_", Sys.Date(), ".xlsx", sep = "")
  },
  content = function(file) {
    expObj <- FormatExportScenario(input$downloadScenario)
    write_xlsx(x = expObj, path = file, col_names = TRUE)
    shinyjs::disable(id = "downloadScenario")
    shinyjs::disable(id = "Download_Scenario")
    output$text_export_scenario <- renderText(
      paste("Scenario ", input$downloadScenario, " was successfully downloaded.")
    )
    
  }
)



