observeEvent(input$importResults,
             {
               extract_runID_scenarioName(input$importResults$datapath)
               
               output$textImportedResults <- NULL
               
               if (runID_Exists == TRUE && scenarioName_Exists == TRUE)
               {
                 shinyjs::show(id = "Imported_Results_NameRunID")
                 
                 msg <- paste("The run ID ", submittedRunID, " and the scenario name ", submittedResultsName,
                              " are already taken. Please enter a new run ID and scenario name for the imported results.")
                 shinyjs::info(msg)
                 
               }else if (runID_Exists == TRUE)
               {
                 msg <- paste("The run ID ", submittedRunID, 
                              " is already taken. Please enter a new run ID for the imported results.")
                 shinyjs::info(msg)
                 shinyjs::show(id = "Imported_Results_RunID")
                 shinyjs::hide(id = "Imported_Results_ScenarioName")
                 shinyjs::hide(id = "Imported_Results_NameRunID")
                 
               }else if (scenarioName_Exists == TRUE)
               {
                 msg <- paste("The scenario name ", submittedResultsName,
                              " is already taken. Please enter a new scenario name for the imported results.")
                 shinyjs::info(msg)
                 shinyjs::hide(id = "Imported_Results_RunID")
                 shinyjs::show(id = "Imported_Results_ScenarioName")
                 shinyjs::hide(id = "Imported_Results_NameRunID")
               }
               
             }
)

observeEvent(input$submit_ImportedResults_ScenarioName,
             {
               enteredScenarioName <- input$ImportedResults
               if (is.null(enteredScenarioName) || (trimws(enteredScenarioName) == ""))
               {
                 shinyjs::info("Input textbox is empty. Please enter a scenario name.")
                 
               }else if (verifyResultsScenarioName(enteredScenarioName))
               {
                 msg <- paste("The name ",enteredScenarioName,
                              " is already taken. Please enter a different name.")
                 shinyjs::info(msg)
                 
               }else
               {
                 
                 submit_results_name(enteredScenarioName, input$importResults$datapath)
                 
                 output$textImportedResults <- renderText(
                   {
                     paste("The results with run ID ", 
                           submittedRunID, 
                           " and name ", 
                           enteredScenarioName,
                           " have been successfully uploaded to the app.")
                   }
                 )
                 
                
                 updateCheckboxGroupInput(session, "Check_Scenario_Names_Results",
                                          choices = names(unlist(modelRuns, recursive = F)))
                 
                 updateSelectInput(session, "selectRunID",
                                   choices = c("None Selected", as.list(runID)),
                                   selected = "None Selected")
                 
                 updateSelectInput(session,
                                   inputId = "selectAssociatedScenario",
                                   choices = c("None Selected", as.list(names(modelRuns[[submittedRunID]]))),
                                   selected = "None Selected")
                 
                 updateSelectInput(session, "selectResultsRunID",
                                   choices = c("None Selected", as.list(runID)),
                                   selected = "None Selected")
                 
                 updateSelectInput(session,
                                   inputId = "selectResultsName",
                                   choices = c("None Selected", as.list(names(modelRuns[[submittedRunID]]))),
                                   selected = "None Selected")
                 
                 updateSelectInput(session, "deleteResults",
                                   choices = c("None Selected", as.list(names(unlist(modelRuns, recursive = F)))),
                                   selected = "None Selected")
                 
               }
               
             }
             
)

observeEvent(input$submit_ImportedResults_runID,
             {
               enteredRunID <- input$submit_ImportedResults_runID
               
               if (is.null(enteredRunID) || (trimws(enteredRunID) == ""))
               {
                 shinyjs::info("Input textbox is empty. Please enter a run ID.")
                 
               }else if (verifyResultsRunID(enteredRunID))
               {
                 msg <- paste("The run ID ",enteredRunID,
                              " is already taken. Please enter a different run ID.")
                 shinyjs::info(msg)
                 
               }else
               {
                 submit_results_runID(enteredRunID, input$importResults$datapath)
                 
                 output$textImportedResults <- renderText(
                   {
                     paste("The results with run ID ", 
                           enteredRunID, 
                           " and name ", 
                           submittedResultsName,
                           " have been successfully uploaded to the app.")
                   }
                 )
                 
                 updateCheckboxGroupInput(session, "Check_Scenario_Names_Results",
                                          choices = names(unlist(modelRuns, recursive = F)))
                 
                 updateSelectInput(session, "selectRunID",
                                   choices = c("None Selected", as.list(runID)),
                                   selected = "None Selected")
                 
                 updateSelectInput(session,
                                   inputId = "selectAssociatedScenario",
                                   choices = c("None Selected", as.list(names(modelRuns[[enteredRunID]]))),
                                   selected = "None Selected")
                 
                 updateSelectInput(session, "selectResultsRunID",
                                   choices = c("None Selected", as.list(runID)),
                                   selected = "None Selected")
                 
                 updateSelectInput(session,
                                   inputId = "selectResultsName",
                                   choices = c("None Selected", as.list(names(modelRuns[[enteredRunID]]))),
                                   selected = "None Selected")
                 
                 updateSelectInput(session, "deleteResults",
                                   choices = c("None Selected", as.list(names(unlist(modelRuns, recursive = F)))),
                                   selected = "None Selected")
                 
                 
               }
               
             }
             
)

observeEvent(input$submit_ImportedResults_NameRunID,
             {
               enteredRunID <- input$ResultsRunId
               enteredResultsName <- input$ResultsName
               
               if (is.null(enteredRunID) || (trimws(enteredRunID) == "") ||
                   is.null(enteredResultsName) || (trimws(enteredResultsName) == ""))
               {
                 shinyjs::info("One or two of the input textboxes is(are) empty. Please enter the requested information.")
                 
               }else if (verifyResultsRunID(enteredRunID) && verifyResultsScenarioName(enteredResultsName))
               {
                 msg <- paste("The run ID ",enteredRunID, " and the name ", enteredResultsName,
                              " are already taken. Please enter a different run ID and name.")
                 shinyjs::info(msg)
                 
               }else if (verifyResultsRunID(enteredRunID))
               {
                 msg <- paste("The run ID ",enteredRunID,
                              " is already taken. Please enter a different run ID.")
                 shinyjs::info(msg)
                 
               }else if (verifyResultsScenarioName(enteredResultsName))
               {
                 msg <- paste("The name ",enteredScenarioName,
                              " is already taken. Please enter a different name.")
                 shinyjs::info(msg)
               }else
               {
                 
                 submit_imported_NameRunID(enteredRunID, enteredResultsName, input$importResults$datapath)
                 
                 output$textImportedResults <- renderText(
                   {
                     paste("The results with run ID ", 
                           enteredRunID, 
                           " and name ", 
                           enteredResultsName,
                           " have been successfully uploaded to the app.")
                   }
                 )
                 
                 updateCheckboxGroupInput(session, "Check_Scenario_Names_Results",
                                          choices = names(unlist(modelRuns, recursive = F)))
                 
                 updateSelectInput(session, "selectRunID",
                                   choices = c("None Selected", as.list(runID)),
                                   selected = "None Selected")
                 
                 updateSelectInput(session,
                                   inputId = "selectAssociatedScenario",
                                   choices = c("None Selected", as.list(names(modelRuns[[enteredRunID]]))),
                                   selected = "None Selected")
                 
                 updateSelectInput(session, "selectResultsRunID",
                                   choices = c("None Selected", as.list(runID)),
                                   selected = "None Selected")
                 
                 updateSelectInput(session,
                                   inputId = "selectResultsName",
                                   choices = c("None Selected", as.list(names(modelRuns[[enteredRunID]]))),
                                   selected = "None Selected")
                 
                 updateSelectInput(session, "deleteResults",
                                   choices = c("None Selected", as.list(names(unlist(modelRuns, recursive = F)))),
                                   selected = "None Selected")
                 
                 
               }
               
             }
             
)