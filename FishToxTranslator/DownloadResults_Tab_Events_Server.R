observeEvent(input$selectRunID,
             {
               chosenRunID <- input$selectRunID
               updateSelectInput(session,
                                 inputId = "selectAssociatedScenario",
                                 choices = c("None Selected", as.list(names(modelRuns[[chosenRunID]]))),
                                 selected = "None Selected")
               if (chosenRunID == "None Selected")
               {
                 shinyjs::hide(id = "AssociatedScenarioButton")
               }else
               {
                 shinyjs::show(id = "AssociatedScenarioButton")
               }
               
             },
             ignoreNULL = FALSE
)

observeEvent(input$selectAssociatedScenario,
             {
               chosenScenario <- input$selectAssociatedScenario
               if (chosenScenario == "None Selected")
               {
                 shinyjs::hide(id = "DownloadResultsButton")
               }else
               {
                 shinyjs::show(id = "DownloadResultsButton")
               }
             },
             ignoreNULL = FALSE
)

# Download Results
output$Download_Results <- downloadHandler(
  filename = function() {
    paste(input$selectRunID, "_", input$selectAssociatedScenario, "_results", ".xlsx", sep = "")
  },
  content = function(con) {
    expResults <- FormatExportResults(input$selectRunID, input$selectAssociatedScenario)
    write_xlsx(x = expResults, path = con, col_names = TRUE)
  }
)