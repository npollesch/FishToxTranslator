observeEvent(input$Delete_Results,
             {
               if (input$selectResultsName  == "None Selected")
               {
                 output$textMessageDeleteResults <- renderText(
                   {
                     paste("Please select one of the Results from the drop-down menu.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                  shinyjs::disable(id = "actionDeleteResults")
               }else
               {
                 output$textMessageDeleteResults <- renderText(
                   {
                     str1 <- paste("Do you really want to delete the results with run ID ", 
                                   input$selectResultsRunID, " and name ", 
                                   input$selectResultsName,"?", sep = "")
                     paste(str1,
                           "If the answer is yes, click the 'Confirm and Delete' button below.", 
                           "Click the 'Cancel' button to exit without deleting anything.",
                           "To close this window click the 'Close' button below.", 
                           sep = "\n")
                   }
                 )
                 
                 shinyjs::enable(id = "actionDeleteResults")
                 
               }
               
             }
)

observeEvent(input$selectResultsRunID,
             {
               chosenRunID <- input$selectResultsRunID
               updateSelectInput(session,
                                 inputId = "selectResultsName",
                                 choices = c("None Selected", as.list(names(modelRuns[[chosenRunID]]))),
                                 selected = "None Selected")
               if (chosenRunID == "None Selected")
               {
                 shinyjs::hide(id = "ResultsNameButton")
               }else
               {
                 shinyjs::show(id = "ResultsNameButton")
               }
               
             },
             ignoreNULL = FALSE
)

observeEvent(input$selectResultsName,
             {
               chosenScenario <- input$selectResultsName
               if (chosenScenario == "None Selected")
               {
                 shinyjs::hide(id = "DeleteResultsButton")
               }else
               {
                 shinyjs::show(id = "DeleteResultsButton")
               }
             },
             ignoreNULL = FALSE
)


observeEvent(input$actionDeleteResults,
             {
               delete_Results(input$selectResultsRunID, input$selectResultsName)
               
               updateCheckboxGroupInput(session, "Check_Scenario_Names_Results",
                                        choices = as.list(names(unlist(modelRuns, recursive = F))))
               
               updateSelectInput(session, "downloadResults",
                                 choices = c("None Selected", as.list(names(unlist(modelRuns, recursive = F)))),
                                 selected = "None Selected")
               
               updateSelectInput(session, "selectResultsName",
                                 choices = c("None Selected", as.list(names(unlist(modelRuns, recursive = F)))),
                                 selected = "None Selected")
               
               updateSelectInput(session, "selectResultsRunID",
                                 choices = c("None Selected", as.list(runID)),
                                 selected = "None Selected")
               
               updateSelectInput(session, "selectRunID",
                                 choices = c("None Selected", as.list(runID)),
                                 selected = "None Selected")
               
               updateSelectInput(session, "selectAssociatedScenario",
                                 choices = c("None Selected", as.list(names(unlist(modelRuns, recursive = F)))),
                                 selected = "None Selected")
               
               shinyjs::disable(id = "actionDeleteResults")
             }
)