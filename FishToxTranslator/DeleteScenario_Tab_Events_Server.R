observe(
  {
    if (input$deleteScenario == "None Selected" || input$deleteScenario == "")
    {
      shinyjs::hide(id = "DeleteScenarioButton")
    }else
    {
      shinyjs::show(id = "DeleteScenarioButton")
    }
  }
)

observeEvent(input$Delete_Scenario,
             {
               inputScenarioToBeDeleted <- input$deleteScenario
               if (inputScenarioToBeDeleted  == "None Selected")
               {
                 output$textMessageDeleteScenario <- renderText(
                   {
                     paste("Please select one of the scenarios from the drop-down menu.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "actionDeleteScenario")
               }else
               {
                 output$textMessageDeleteScenario <- renderText(
                   {
                     text1 <- paste("Are you sure you want to delete the ", inputScenarioToBeDeleted, " scenario?")
                     paste(text1,
                           "Click 'Delete and Confirm' to delete the chosen scenario.", 
                           "Click 'Cancel' to exit without deleting anything.", 
                           sep = "\n")
                   }
                 )
                 
                 shinyjs::enable(id = "actionDeleteScenario")
                 
               }
               
             }
)

observeEvent(input$actionDeleteScenario,
             {
               delete_scenario(input$deleteScenario)
               
               updateSelectInput(session, "baselines",
                                 choices = c("None Selected", scenario_names),
                                 selected = input$baselines)
               
               updateSelectInput(session, "downloadScenario",
                                 choices = c("None Selected", scenario_names),
                                 selected = "None Selected")
               
               updateSelectInput(session, "deleteScenario",
                                 choices = c("None Selected", scenario_names),
                                 selected = "None Selected")
               
               updateCheckboxGroupInput(session, "Check_Scenario_Names_Run",
                                        choices = as.list(scenario_names))
                                        
               updateCheckboxGroupInput(session, "Check_Scenario_Names",
                                        choices = as.list(scenario_names))  
               
               shinyjs::disable(id = "actionDeleteScenario")
            
             }
)