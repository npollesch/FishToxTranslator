####################################################################################################
#  Add Stressor Scenario Event
####################################################################################################
observeEvent(input$add_StressorScenario,
             {
               shinyjs::hide(id = "baseline_selection_name")
               shinyjs::show(id = "underlying_scenario")
               updateSelectInput(session, "baselines",
                                 choices = c("None Selected", scenario_names),
                                 selected = "None Selected")
               
               updateTextInput(session, "stressorName", value = "")
               
               updateTextAreaInput(session, inputId = "textStressorDescription", value = "")
               
               updateTextInput(session, inputId = "chemical_id", value = "")
               
               output$text_chemicalID <- NULL
               
               updateSelectInput(session, "stressor_type",
                                 selected = "None Selected")
               
               updateSelectInput(session, "effect_type",
                                 selected = "None Selected")
               
               updateSelectInput(session, "downloadScenario",
                                 choices = c("None Selected", scenario_names),
                                 selected = "None Selected")
               
               updateSelectInput(session, "deleteScenario",
                                 choices = c("None Selected", scenario_names),
                                 selected = "None Selected")
               
               updateSelectInput(session, "initial_distribution",
                                 selected = "None Selected")
               
               updateNumericInput(session, inputId = "start_winter", value = 355)
               updateNumericInput(session, inputId = "end_winter", value = 91)
               
               output$text_stressorName <- NULL
               output$text_runid <- NULL
               
               shinyjs::hide(id = "stressorType")
               shinyjs::hide(id = "exposure_conc")
               shinyjs::hide(id = "chemicalEffectType")
               shinyjs::hide(id = "chemicalID")
               shinyjs::hide(id = "tcem")
               shinyjs::hide(id = "predetermined_effects")
               shinyjs::hide(id = "guts")
               shinyjs::hide(id = "stressor_verification")
               shinyjs::hide(id = "stressor_table_main")
               shinyjs::hide(id = "Exposure_Concentration_Main")
               shinyjs::hide(id = "TCEM_Main")
               shinyjs::hide(id = "Survival_Decrement_Main")
               shinyjs::hide(id = "Growth_Percent_Main")
               shinyjs::hide(id = "Winter_Survival_Main")
               shinyjs::hide(id = "Predetermined_Initial_Distribution_Main")
               shinyjs::hide(id = "Summary_Table_Main")
               shinyjs::hide(id = "run_simulations_section")
               output$Summary_Table_out <- NULL
               
               shinyjs::enable(id = "baselines")
               shinyjs::enable(id = "stressorName")
               shinyjs::enable(id = "submit_stressorName")
               shinyjs::enable(id = "textStressorDescription")
               shinyjs::enable(id = "stressor_type")
               shinyjs::enable(id = "download_exposure_concentration")
               shinyjs::enable(id = "upload_exposure_concentrations")
               shinyjs::enable(id = "effect_type")
               shinyjs::enable(id = "tcem_lc_conc")
               shinyjs::enable(id = "tcem_lc_percent")
               shinyjs::enable(id = "download_predetermined_effects")
               shinyjs::enable(id = "upload_predetermined_effects")
               shinyjs::enable(id = "chemicalID")
               shinyjs::enable(id = "store_chemicalID")
               shinyjs::enable(id = "winter_cutoff")
               shinyjs::enable(id = "start_winter")
               shinyjs::enable(id = "end_winter")
             }
  
)

observeEvent(input$baselines,
  {
    if (input$baselines != "None Selected")
    {
      shinyjs::show(id = "baseline_selection_name")
    }
  }, 
  ignoreInit = TRUE
)


####################################################################################################
#  Stressor Name
####################################################################################################
observeEvent(
  input$submit_stressorName,
  {
    if (is.null(input$stressorName) || (trimws(input$stressorName) == ""))
    {
      shinyjs::info("Input textbox is empty. Please enter a name.")

    }else if (verifyScenarioName(input$stressorName))
    {
      msg <- paste(input$stressorName,
                   " has been assigned before. Please enter a different name.")
      shinyjs::info(msg)

    }else
    {
      enter_stressor_scenario_name(input$baselines, input$stressorName, input$textStressorDescription)
      stressor_scenario_name <- CurrentStressorScenarioName
      output$text_stressorName <- renderText(
        {
          paste("This scenario has been named ", stressor_scenario_name, ".")
        }
      )
      output$stressor_scenario_complete <- renderText(
        {
          paste("<font color=\"#2e8b57\">","The '", CurrentStressorScenarioName,"' scenario is now complete.","</font>",sep="")
        }
      )
      updateSelectInput(session, "stressor_type",
                        selected = "None Selected")

      updateSelectInput(session, "effect_type",
                        selected = "None Selected")

     # updateSelectInput(session, "baselines",
     #                   choices = c("None Selected", scenario_names),
     #                  selected = input$baselines)
      
      #  updateSelectInput(session, "downloadScenario",
      #                   choices = c("None Selected", scenario_names),
      #                   selected = "None Selected")
      
      # updateSelectInput(session, "deleteScenario",
      #                   choices = c("None Selected", scenario_names),
      #                   selected = "None Selected")

      updateSelectInput(session, "initial_distribution",
                        selected = "None Selected")

      # updateCheckboxGroupInput(session, "Check_Scenario_Names",
      #                          choices = as.list(scenario_names))

      # updateCheckboxGroupInput(session, "Check_Scenario_Names_Run",
      #                          choices = as.list(scenario_names))

      # updateCheckboxGroupInput(session, "Check_Scenario_Names_Results",
      #                          choices = as.list(scenario_names))

      updateNumericInput(session, inputId = "start_winter", value = 355)
      updateNumericInput(session, inputId = "end_winter", value = 91)
      
      output$text_runid <- NULL

      shinyjs::show(id = "stressorType")
      shinyjs::hide(id = "exposure_conc")
      shinyjs::hide(id = "chemicalEffectType")
      shinyjs::hide(id = "chemicalID")
      shinyjs::hide(id = "tcem")
      shinyjs::hide(id = "predetermined_effects")
      shinyjs::hide(id = "guts")
      shinyjs::hide(id = "stressor_verification")
      shinyjs::hide(id = "stressor_table_main")
      shinyjs::hide(id = "Exposure_Concentration_Main")
      shinyjs::hide(id = "TCEM_Main")
      shinyjs::hide(id = "Survival_Decrement_Main")
      shinyjs::hide(id = "Winter_Survival_Main")
      # shinyjs::show(id = "Visualization_SDEC")
      shinyjs::hide(id = "Predetermined_Initial_Distribution_Main")
      shinyjs::hide(id = "Summary_Table_Main")
      shinyjs::hide(id = "run_simulations_section")
      output$Summary_Table_out <- NULL
      
    }
  }
)


####################################################################################################
#  Show/Hide Events
####################################################################################################
observe({
  if (input$stressor_type == "None Selected")
  {
    shinyjs::show(id = "exposure_conc")
    shinyjs::hide(id = "chemicalEffectType")
    shinyjs::hide(id = "chemicalID")
    shinyjs::hide(id = "tcem")
    shinyjs::hide(id = "predetermined_effects")
    shinyjs::hide(id = "guts")
    shinyjs::hide(id = "stressor_verification")
    shinyjs::hide(id = "stressor_table_main")
    shinyjs::hide(id = "Exposure_Concentration_Main")
    shinyjs::hide(id = "TCEM_Main")
    shinyjs::hide(id = "Survival_Decrement_Main")
    shinyjs::hide(id = "Winter_Survival_Main")
  }
})


observe({
  if (input$stressor_type == "Chemical: Survival")
  {
    shinyjs::show(id = "exposure_conc")
    reset("upload_exposure_concentrations")
    shinyjs::hide(id = "chemicalEffectType")
    shinyjs::hide(id = "chemicalID")
    shinyjs::hide(id = "tcem")
    shinyjs::hide(id = "predetermined_effects")
    shinyjs::hide(id = "predetermined_growth_effects")
    shinyjs::hide(id = "guts")
    shinyjs::hide(id = "stressor_verification")
    shinyjs::hide(id = "stressor_table_main")
    shinyjs::hide(id = "Exposure_Concentration_Main")
    shinyjs::hide(id = "TCEM_Main")
    shinyjs::hide(id = "Survival_Decrement_Main")
    shinyjs::hide(id = "Winter_Survival_Main")
  }
})

observe({
  if (input$stressor_type == "Chemical: Growth")
  {
    shinyjs::show(id = "exposure_conc")
    reset("upload_exposure_concentrations")
    reset("upload_predetermined_growth_effects")
    shinyjs::hide(id = "chemicalID")
    shinyjs::hide(id = "predetermined_growth_effects")
    shinyjs::hide(id = "chemicalEffectType")
    shinyjs::hide(id = "tcem")
    shinyjs::hide(id = "predetermined_effects")
    shinyjs::hide(id = "guts")
    shinyjs::hide(id = "stressor_verification")
    shinyjs::hide(id = "stressor_table_main")
    shinyjs::hide(id = "Exposure_Concentration_Main")
    shinyjs::hide(id = "TCEM_Main")
    shinyjs::hide(id = "Survival_Decrement_Main")
    shinyjs::hide(id = "Winter_Survival_Main")
  }
})

observe({
  if (input$stressor_type == "Winter")
  {
    shinyjs::show(id = "Winter_Options")
    shinyjs::hide(id = "chemicalEffectType")
    shinyjs::hide(id = "chemicalID")
    shinyjs::hide(id = "tcem")
    shinyjs::hide(id = "predetermined_effects")
    shinyjs::hide(id = "predetermined_growth_effects")
    shinyjs::hide(id = "guts")
    shinyjs::hide(id = "stressor_verification")
    shinyjs::hide(id = "stressor_table_main")
    shinyjs::hide(id = "Exposure_Concentration_Main")
    shinyjs::hide(id = "TCEM_Main")
    shinyjs::hide(id = "Survival_Decrement_Main")
    shinyjs::hide(id = "Winter_Survival_Main")
  }
})

observe({
  if (input$effect_type == "GUTS")
  {
    shinyjs::show((id = "guts"))
    output$text_guts <- renderText(
      {
        paste("This effect is currently under development.")
      }
    )
    shinyjs::hide(id = "chemicalID")
    shinyjs::hide(id = "tcem")
    shinyjs::hide(id = "predetermined_effects")
    shinyjs::hide(id = "predetermined_growth_effects")
    shinyjs::hide(id = "stressor_verification")
    shinyjs::hide(id = "stressor_table_main")
    shinyjs::show(id = "Exposure_Concentration_Main")
    shinyjs::hide(id = "TCEM_Main")
    shinyjs::hide(id = "Survival_Decrement_Main")
    shinyjs::hide(id = "Winter_Survival_Main")
  }else if (input$effect_type == "Threshold Effects Model: TCEM")
  {
    shinyjs::show(id = "chemicalID")
    shinyjs::show(id ="tcem")
    text_label <- paste(as.character(parameters_master$name[26]), ": ",
                        " (LC ", input$tcem_lc_percent * 100,")")
    updateNumericInput(session, inputId = "tcem_lc_conc", label = text_label)
    output$text_tcem <- NULL
    shinyjs::hide(id = "predetermined_effects")
    shinyjs::hide(id = "predetermined_growth_effects")
    shinyjs::hide(id = "guts")
    shinyjs::hide(id = "stressor_verification")
    shinyjs::hide(id = "stressor_table_main")
    shinyjs::show(id = "Exposure_Concentration_Main")
    shinyjs::hide(id = "TCEM_Main")
    shinyjs::hide(id = "Survival_Decrement_Main")
    shinyjs::hide(id = "Winter_Survival_Main")
  }else if (input$effect_type == "Pre-determined effects")
  {
    shinyjs::show(id = "chemicalID")
    shinyjs::show(id ="predetermined_effects")
    reset("upload_predetermined_effects")
    shinyjs::hide(id = "predetermined_growth_effects")
    shinyjs::hide(id = "tcem")
    shinyjs::hide(id = "guts")
    shinyjs::hide(id = "stressor_verification")
    shinyjs::hide(id = "stressor_table_main")
    shinyjs::show(id = "Exposure_Concentration_Main")
    shinyjs::hide(id = "TCEM_Main")
    shinyjs::hide(id = "Survival_Decrement_Main")
    shinyjs::hide(id = "Winter_Survival_Main")
  }else if (input$effect_type == "None Selected")
  {
    shinyjs::hide(id = "chemicalID")
    shinyjs::hide(id = "tcem")
    shinyjs::hide(id = "predetermined_effects")
    shinyjs::hide(id = "predetermined_growth_effects")
    shinyjs::hide(id = "guts")
    shinyjs::hide(id = "stressor_verification")
    shinyjs::hide(id = "stressor_table_main")
    shinyjs::hide(id = "Exposure_Concentration_Main")
    shinyjs::hide(id = "TCEM_Main")
    shinyjs::hide(id = "Survival_Decrement_Main")
    shinyjs::hide(id = "Winter_Survival_Main")
  }
})


####################################################################################################
#  Download Events
####################################################################################################
# Downloadable csv of selected dataset
output$downloadStressorParams <- downloadHandler(
  filename = function() {
    paste("stressor_scenario_parameters-", Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    df_params <- parameters[[CurrentStressorScenarioName]]
    write.csv(df_params, file, row.names = FALSE)
  }
)

####################################################################################################
#  Winter Events
####################################################################################################
output$firstDay_winter <- renderText(
  {
    wdate <- as.POSIXct("2018-10-31")
    wdate1 <- update(wdate, year = 2018, yday = input$start_winter)
    wmonth1 <- month.name[month(wdate1)]
    wday1 <- mday(wdate1)
    paste("Calendar date is ", wmonth1, " ", wday1)
  }
)

output$lastDay_winter <- renderText(
  {
    wdate <- as.POSIXct("2018-10-31")
    wdate2 <- update(wdate, year = 2018, yday = input$end_winter)
    wmonth2 <- month.name[month(wdate2)]
    wday2 <- mday(wdate2)
    paste("Calendar date is ", wmonth2, " ", wday2)
  }
)

observeEvent(input$store_winter_params,
             {
               store_winter_parameters(CurrentStressorScenarioName, input$start_winter, input$end_winter,
                                       input$winter_cutoff)
               
               output$Winter_Survival_out <- renderPlot(
                 {
                   plot_winter_decreasing_survival(CurrentStressorScenarioName, input$start_winter, input$end_winter,
                                                   input$winter_cutoff)
                 }
               )
               
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
               
               updateCheckboxGroupInput(session, "Check_Scenario_Names_Results",
                                        choices = as.list(scenario_names))
               
               shinyjs::show(id = "Winter_Survival_Main")
               shinyjs::show(id  = "stressor_verification")
               shinyjs::show(id = "Visualization_SPB")
               shinyjs::show(id = "Visualization_SDEC")
               
               shinyjs::disable(id = "stressorName")
               shinyjs::disable(id = "baselines")
               shinyjs::disable(id = "submit_stressorName")
               shinyjs::disable(id = "textStressorDescription")
               shinyjs::disable(id = "stressor_type")
               shinyjs::disable(id = "winter_cutoff")
               shinyjs::disable(id = "start_winter")
               shinyjs::disable(id = "end_winter")
             }
)

observe(
  {
    if (input$stressor_type == 'Winter')
    {
      shinyjs::hide(id = "stressor_verification")
      shinyjs::hide(id = "stressor_table_main")
      shinyjs::hide(id = "Exposure_Concentration_Main")
      shinyjs::hide(id = "TCEM_Main")
      shinyjs::hide(id = "Survival_Decrement_Main")
      shinyjs::hide(id = "Winter_Survival_Main")
    }
  }

)

####################################################################################################
#  TCEM events
####################################################################################################
observeEvent(input$run_tcem,
             {
               output$TCEM_out <- renderPlot(
                 {
                   run_tcem(CurrentStressorScenarioName, input$tcem_lc_conc, input$tcem_lc_percent)
                   
                 }
               )
               
               output$text_tcem <- renderText(
                 {
                   paste("The TCEM algorithm is finished.")
                 }
               )
               result1 <- tolower(CurrentStressorScenarioName) %in% tolower(scenario_names)
               if (result1 == FALSE)
               {
                 scenario_names <<- c(scenario_names, CurrentStressorScenarioName)
               }
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
               
               updateCheckboxGroupInput(session, "Check_Scenario_Names_Results",
                                        choices = as.list(scenario_names))
               
               shinyjs::show(id ="TCEM_Main")
               shinyjs::show(id  = "stressor_verification")
               shinyjs::show(id = "Visualization_SPB")
               shinyjs::show(id = "Visualization_SDEC")
               
                shinyjs::disable(id = "stressorName")
                shinyjs::disable(id = "baselines")
                shinyjs::disable(id = "submit_stressorName")
                shinyjs::disable(id = "textStressorDescription")
                shinyjs::disable(id = "stressor_type")
                shinyjs::disable(id = "effect_type")
                shinyjs::disable(id = "tcem_lc_percent")
                shinyjs::disable(id = "tcem_lc_conc")
                shinyjs::disable(id = "download_exposure_concentration")
                shinyjs::disable(id = "upload_exposure_concentrations")
                shinyjs::disable(id = "download_predetermined_effects")
                shinyjs::disable(id = "upload_predetermined_effects")
                shinyjs::disable(id = "chemical_id")
                shinyjs::disable(id = "store_chemicalID")
             }
)

####################################################################################################
#  Exposure Concentrations
####################################################################################################
observeEvent(input$download_exposure_concentration,
             {
               template_file <- generate_ExposureConcentration_Template()
               shell.exec(template_file)
             }
)

observeEvent(input$upload_exposure_concentrations,
             {
               assign_exposure_concentrations(CurrentStressorScenarioName, input$upload_exposure_concentrations$datapath)
               output$Exposure_Concentration_out <- renderPlot(
                 {
                   plot_exposure_concentrations(CurrentStressorScenarioName)
                 }
               )
               shinyjs::show(id = "Exposure_Concentration_Main")
               if (input$stressor_type == "Chemical: Survival")
               {
                 shinyjs::show(id = "chemicalEffectType")
               }
               if (input$stressor_type == "Chemical: Growth")
               {
                 shinyjs::show(id = "chemicalID")
                 shinyjs::enable(id = "predetermined_growth_effects")
                 shinyjs::show(id = "predetermined_growth_effects")
               }
               
             }
)

####################################################################################################
#  Pre-determined Effects
####################################################################################################
observeEvent(input$download_predetermined_effects,
             {
               template_file <- generate_Predetermined_Effects_Template()
               shell.exec(template_file)
             }
)

observeEvent(input$upload_predetermined_effects,
             {
               assign_predetermined_effects(CurrentStressorScenarioName, input$upload_predetermined_effects$datapath)
               output$Survival_Decrement_out <- renderPlot(
                 {
                   plot_survival_decrement(CurrentStressorScenarioName)
                 }
               )
               shinyjs::show(id  = "Survival_Decrement_Main")
               shinyjs::show(id  = "stressor_verification")
               
               result <- tolower(CurrentStressorScenarioName) %in% tolower(scenario_names)
               if (result == FALSE)
               {
                 scenario_names <<- c(scenario_names, CurrentStressorScenarioName)
               }
               
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
               
               updateCheckboxGroupInput(session, "Check_Scenario_Names_Results",
                                        choices = as.list(scenario_names))
               
               shinyjs::disable(id = "baselines")
               shinyjs::disable(id = "stressorName")
               shinyjs::disable(id = "submit_stressorName")
               shinyjs::disable(id = "stressor_type")
               shinyjs::disable(id = "effect_type")
               shinyjs::disable(id = "tcem_lc_percent")
               shinyjs::disable(id = "tcem_lc_conc")
               shinyjs::disable(id = "download_exposure_concentration")
               shinyjs::disable(id = "upload_exposure_concentrations")
               shinyjs::disable(id = "download_predetermined_effects")
               shinyjs::disable(id = "upload_predetermined_effects")
               shinyjs::disable(id = "chemical_id")
               shinyjs::disable(id = "store_chemicalID")
             }
)

observeEvent(
  input$store_chemicalID,
  {
    inputChemicalID <- input$chemical_id
    if (is.null(inputChemicalID) || (trimws(inputChemicalID) == ""))
    {
      shinyjs::info("Input textbox is empty. Please enter a chemical name.")
    }else
    {
      store_chemicalID(CurrentStressorScenarioName, inputChemicalID)
      stressor_chemicalID <- inputChemicalID
      output$text_chemicalID <- renderText(
        {
          paste(stressor_chemicalID, " was stored in the code.")
        }
      )
      # updateTextInput(session, inputId = "chemical_id", value = "")
    }
  }
)

observeEvent(input$download_predetermined_growth_effects,
             {
               template_file <- generate_Predetermined_Growth_Effects_Template()
               shell.exec(template_file)
             }
)

observeEvent(input$upload_predetermined_growth_effects,
             {
               assign_predetermined_growth_effects(CurrentStressorScenarioName, input$upload_predetermined_growth_effects$datapath)
               output$Growth_Percent_out <- renderPlot(
                 {
                   plot_growth_percent(CurrentStressorScenarioName)
                 }
               )
               shinyjs::show(id  = "Growth_Percent_Main")
               shinyjs::show(id  = "stressor_verification")
               
               result <- tolower(CurrentStressorScenarioName) %in% tolower(scenario_names)
               if (result == FALSE)
               {
                 scenario_names <<- c(scenario_names, CurrentStressorScenarioName)
               }
               
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
               
               updateCheckboxGroupInput(session, "Check_Scenario_Names_Results",
                                        choices = as.list(scenario_names))
               
               shinyjs::disable(id = "baselines")
               shinyjs::disable(id = "stressorName")
               shinyjs::disable(id = "submit_stressorName")
               shinyjs::disable(id = "stressor_type")
               shinyjs::disable(id = "effect_type")
               shinyjs::disable(id = "tcem_lc_percent")
               shinyjs::disable(id = "tcem_lc_conc")
               shinyjs::disable(id = "download_exposure_concentration")
               shinyjs::disable(id = "upload_exposure_concentrations")
               shinyjs::disable(id = "download_predetermined_effects")
               shinyjs::disable(id = "upload_predetermined_effects")
               shinyjs::disable(id = "download_predetermined_growth_effects")
               shinyjs::disable(id = "upload_predetermined_growth_effects")
               shinyjs::disable(id = "chemical_id")
               shinyjs::disable(id = "store_chemicalID")
             }
)

####################################################################################################
#  Display Table(s)
####################################################################################################
observeEvent(input$display_stressor_table,
             {
               inputStressorType <- input$stressor_type
               inputEffectType <- input$effect_type
               output$stressor_table <- DT::renderDataTable(
                 {
                   if (inputStressorType == 'Chemical: Survival')
                   {
                     file_stressor <- input$upload_exposure_concentrations$name
                     if (is.null(file_stressor)){
                       return()
                     }
                     if (inputEffectType == 'GUTS' || inputEffectType == 'None Selected')
                     {
                       return()
                     }
                   }else if (inputStressorType == 'None Selected')
                   {
                     return()
                   }
                   if (inputStressorType == 'Chemical: Growth')
                   {
                     file_stressor <- input$upload_exposure_concentrations$name
                     if (is.null(file_stressor)){
                       return()
                     }
                   }
                   return_stressor_parameters(CurrentStressorScenarioName)
                 },
                 options = list(scrollX = TRUE)
               )
               shinyjs::show(id = "stressor_table_main")
             }
)



output$text_visualize_stressor <- renderText(
  {
    paste("Visualize the ", CurrentStressorScenarioName, " scenario.")
  }
)

output$text_run_stressor <- renderText(
  {
    paste("Run the ", CurrentStressorScenarioName, " simulation.")
  }
)

####################################################################################################
#  Hyperlink to a new tab
####################################################################################################
observeEvent(input$hyperlink_stressor_newtab,
             {
               newtab <- "Visualize Built Scenario(s)"
               updateNavbarPage(session, "fish_toxicity_app", newtab)
             }
)

observeEvent(input$hyperlink_run_stressor,
             {
               newtab <- "Run Scenarios"
               updateNavbarPage(session, "fish_toxicity_app", newtab)
             }
)
