observeEvent(input$Import_Scenario,
             {
               shinyjs::show(id = "UploadScenarioButton")
               reset(id = "importScenario")
               shinyjs::hide(id = "ImportScenarioButton")
               
               output$textImportedScenario <- NULL
               
               shinyjs::enable(id = "importScenario")
               shinyjs::enable(id = "submit_ImportedScenario_name")
             }
             
)

observeEvent(input$submit_ImportedScenario_name,
             {
               if (is.null(input$ImportedScenario) || (trimws(input$ImportedScenario) == ""))
               {
                 shinyjs::info("Input textbox is empty. Please enter a name.")
                 
               }else if (verifyScenarioName(input$ImportedScenario))
               {
                 msg <- paste("The name ",input$ImportedScenario,
                              " is already taken. Please enter a different name.")
                 shinyjs::info(msg)
                 
               }else
               {
                 
                 submit_imported_scenarioName(input$ImportedScenario, input$importScenario$datapath)
                 
                 output$textImportedScenario <- renderText(
                   {
                     paste("The scenario ", 
                           input$ImportedScenario, 
                           " has been successfully imported.",
                           sep="")
                   }
                 )
                 
                 updateSelectInput(session, "baselines",
                                   choices = c("None Selected", scenario_names),
                                   selected = input$baselines)
                 
                 updateSelectInput(session, "downloadScenario",
                                   choices = c("None Selected", scenario_names),
                                   selected = "None Selected")
                 
                 updateSelectInput(session, "deleteScenario",
                                   choices = c("None Selected", scenario_names),
                                   selected = "None Selected")
                 
                 updateCheckboxGroupInput(session, "Check_Scenario_Names",
                                          choices = as.list(scenario_names))
                 
                 updateCheckboxGroupInput(session, "Check_Scenario_Names_Run",
                                          choices = as.list(scenario_names))
                 
                 shinyjs::show(id = "Visualization_GRS")
                 
                 shinyjs::show(id = "Visualization_SPB")
                 
               }
               
             }
             
)

observeEvent(input$importScenario,
             {
               ImportedScenarioName <- extract_name_imported_scenario(input$importScenario$datapath)
               
               result <- tolower(ImportedScenarioName) %in% tolower(scenario_names)
               
               if (result == TRUE)
               {
                 shinyjs::show(id = "ImportScenarioButton")
                 
                 msg <- paste("The name ", ImportedScenarioName,
                              " is already taken. Please enter a new name for the imported scenario.")
                 shinyjs::info(msg)
                 
               }else
               {
                 submit_imported_scenarioName(ImportedScenarioName, input$importScenario$datapath)
                 
                 output$textImportedScenario <- renderText(
                   {
                     paste("The scenario ", 
                           ImportedScenarioName, 
                           " has been successfully imported.",
                           sep = "")
                   }
                 )
                 
                 updateSelectInput(session, "baselines",
                                   choices = c("None Selected", scenario_names),
                                   selected = input$baselines)
                 
                 updateSelectInput(session, "downloadScenario",
                                   choices = c("None Selected", scenario_names),
                                   selected = "None Selected")
                 
                 updateSelectInput(session, "deleteScenario",
                                   choices = c("None Selected", scenario_names),
                                   selected = "None Selected")
                 
                 updateCheckboxGroupInput(session, "Check_Scenario_Names",
                                          choices = as.list(scenario_names))
                 
                 updateCheckboxGroupInput(session, "Check_Scenario_Names_Run",
                                          choices = as.list(scenario_names))
                 
                 shinyjs::show(id = "Visualization_GRS")
                 
                 shinyjs::show(id = "Visualization_SPB")
               }
               
             }
)