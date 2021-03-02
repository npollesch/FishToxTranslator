##################################################################################################
# Baseline buttons/widgets
##################################################################################################
baseline_scenario_name <- textInput(inputId = "currentScenarioName",
                                    label = "Name scenario",
                                    value = "Baseline")

bs_baseline_scenario_name <- bsTooltip("currentScenarioName",
                                       "Enter a name for the Baseline scenario you are creating",
                                       "right", options = list(container = "body"))

submit_baselinename_button <- actionButton(inputId = "submit_name",
                                           label = "Submit \"Baseline\" scenario information", width = '275px',
                                           style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

baseline_name_out_text <- textOutput("text_basename")

baseline_description_textArea <- textAreaInput(inputId = "textBaselineDescription",
                                               label = "Enter description of scenario",
                                               value = "",
                                               height = '50px')

choose_species_DropDownMenu <- selectInput(inputId = "species",
                                           label = "Choose Species",
                                           choices = c("None Selected", as.character(species_library$common_name), "New"))

bs_choose_species_dropdownmenu <- bsTooltip("species",
                                            "Choose a fish species with a parameterized life history or create a new life history for the scenario.",
                                            "right", options = list(container = "body"))

load_fhm_parameters_button <- actionButton(inputId = "load_fhm_parameters",
                                           label = "Load Fathead Minnow Parameters",
                                           width = '250px',
                                           style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

bs_load_fhm_parameters_button <- bsTooltip("load_fhm_parameters",
                                           "Load Fathead Minnow parameters into memory.",
                                           "right", options = list(container = "body"))

load_fhm_parameters_out_text <- textOutput("text_load_fhm")

download_history_button <- actionButton(inputId = "download_history_parameters",
                                        label = "Download life history template",
                                        width = '250px',
                                        style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

bs_download_history_button <- bsTooltip("download_history_parameters",
                                        "Open template file for entering new species parameters.",
                                        "right", options = list(container = "body"))

upload_history_button <- fileInput(inputId = "upload_history_pars", label = NULL,
                                   accept = c("text/csv","text/comma-separated-values,text/plain",".csv"),
                                   width = '400px', buttonLabel = "Upload life history Data",
                                   placeholder = "No file selected")

bs_upload_history_button <- bsTooltip("upload_history_pars",
                                      "Select file with new species parameters from disk and upload it into memory.",
                                      "right", options = list(container = "body"))

spawning_alg_button <- actionButton(inputId = "spawn_algorithm",
                                    label = "Run Spawning Algorithm",
                                    width = '250px',
                                    style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

bs_spawning_alg_button <- bsTooltip("spawn_algorithm",
                                    "A spawning algorithm generates daily spawning probabilities based on the iteroparous or semelparous life history parameters supplied",
                                      "right", options = list(container = "body"))

spawning_alg_out_text <- textOutput("text_spawning_alg")

baseline_scenario_complete_text_out <- htmlOutput("baseline_scenario_complete")

hyperlink_newtab_button <- actionLink(inputId = "hyperlink_newtab",
                                      label = "Move to creating a stressor scenario",
                                      width = '300px',
                                      style="#002966; background-color: #f2f2f2; border-color: #2e6da4")

hyperlink_visualization_button <- actionLink(inputId = "hyperlink_visualization_newtab",
                                             label = "Move to visualizing a baseline scenario",
                                             width = '300px',
                                             style="#002966; background-color: #f2f2f2; border-color: #2e6da4")

hyperlink_run_button <- actionLink(inputId = "hyperlink_run_newtab",
                                   label = "Move to running a baseline scenario",
                                   width = '300px',
                                   style="#002966; background-color: #f2f2f2; border-color: #2e6da4")


visualize_text_out <- textOutput("text_visualize")

run_baseline_text_out <- textOutput("text_run_baseline")

display_life_history_table_button <- actionButton(inputId = "display_LifeHistory",
                                                  label = "Display Life-History Parameters Table",
                                                  width = '250px',
                                                  style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

bs_display_life_history_table_button <- bsTooltip("display_LifeHistory",
                                    "Content of the life history parameters table can be filtered to specific parameters using the View/Hide columns function below",
                                    "right", options = list(container = "body"))

btn_radio_LifeHistory <- radioButtons(inputId = "rad_headers_daily",
                                      label = "View/Hide Columns",
                                      choices = c("View columns", "Hide columns"),
                                      selected = "Hide columns",
                                      inline = TRUE)

bs_radio_LifeHistory <- bsTooltip("rad_headers_daily",
                                  "Content of the life history parameters table can be filtered to specific parameters using the 'View/Hide' columns function below",
                                   "right", options = list(container = "body"))

list1 <- list("ordinal_date", "z_hatch", "z_inf", "k_g", "var_k_g",
              "var_e_g", "dd_g", "b_inf", "allo_slope", "allo_intercept",
              "s_min", "s_max", "s_a", "s_b", "post_spawning_mortality",
              "z_repro", "sex_ratio", "hatch_per_spawn",
              "spawn_int", "spawns_max_season", "repro_start", "repro_end",
              "p_spawn")

check_boxes_LifeHistory <- checkboxGroupInput("headers_daily", "Select headers:",
                                              width = '400px',
                                              selected = list1,
                                              choiceNames = list1,
                                              choiceValues = list1,
                                              inline= FALSE)


btn_set_pars <- actionButton(inputId = "set_parameters",
                             label = "Set All Parameters",
                             width = '250px',
                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

set_parameters_out_text <- textOutput("text_set_parameters")

##################################################################################################
# Stressor buttons/widgets
##################################################################################################
add_stressor_scenario_button <- actionButton(inputId = "add_StressorScenario",
                                             label = "Add Stressor Scenario",
                                             width = '250px',
                                             style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

export_scenario_button <- actionButton(inputId = "Export_Scenario",
                                       label = "Export Scenario",
                                       width = '250px',
                                       style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

export_scenario_out_text <- textOutput("text_export_scenario")

import_scenario_button <- actionButton(inputId = "Import_Scenario",
                                       label = "Import Scenario",
                                       width = '250px',
                                       style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

submit_stressorName_button <- actionButton(inputId = "submit_stressorName",
                                           label = "Submit stressor information",
                                           width = '250px',
                                           style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

underlying_scenario_text_out <- textOutput("underlying_scenario")

bs_underlying_scenario<- bsTooltip("baselines",
                                   "Select a scenario you would like to apply a stressor to.  The underlying scenario will serve as the basis for the stressor scenario parameters.",
                                   "right", options = list(container = "body"))

stressorName_out_text <- textOutput("text_stressorName")

stressor_name_button <- textInput(inputId = "stressorName",
                                  label = "Name the stressor scenario",
                                  value = "")

bs_stressor_name_button <- bsTooltip("stressorName",
                                      "Choose a name for the stressor scenario you are creating",
                                      "right", options = list(container = "body"))

stressor_description_textArea <- textAreaInput(inputId = "textStressorDescription",
                                               label = "Enter description of stressor scenario",
                                               value = "",
                                               height = '50px')

stressor_type_button <- selectInput(inputId = "stressor_type",
                                    label = "Choose Stressor Type",
                                    choices = c("None Selected", 
                                                "Chemical: Survival", 
                                                "Chemical: Growth",
                                                "Winter"))

bs_stressor_type_button <- bsTooltip("stressor_type",
                                     "Select type of stressor",
                                     "right", options = list(container = "body"))


download_exposure_concentration <- actionButton(inputId = "download_exposure_concentration",
                                                label = "Download Exposure Conc Template",
                                                width = '250px',
                                                style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

bs_download_exposure_concentration_button <- bsTooltip("download_exposure_concentration",
                                                       "Open template file for entering chemical exposure concentrations.",
                                                       "right", options = list(container = "body"))

upload_exposure_concentration <- fileInput(inputId = "upload_exposure_concentrations", label = NULL,
                                           accept = c("text/csv","text/comma-separated-values,text/plain",".csv"),
                                           width = '400px', buttonLabel = "Upload Exposure Concentration",
                                           placeholder = "No file selected",
                                           multiple = FALSE)

bs_upload_exposure_concentration_button <- bsTooltip("upload_exposure_concentrations",
                                                     "Load into memory existing file with chemical exposure concentrations.",
                                                      "right", options = list(container = "body"))

select_chemical_effect_type <- selectInput(inputId = "effect_type",
                                           label = "Choose Chemical Effect Type",
                                           choices = c("None Selected",
                                                       "Threshold Effects Model: TCEM",
                                                       "Pre-determined effects"))

bs_chemical_effect_type_button <- bsTooltip("effect_type",
                                            "Choose the type of chemical effect.",
                                            "right", options = list(container = "body"))

tcem_param1 <- numericInput(inputId = "tcem_lc_conc",
                            label = "",
                            value = 2.5,
                            min = 0.0,
                            step = 0.05)


#lbl_title1 <- as.character(parameters_master$name[which(parameters_master$id == 'lc_conc')])
tt_tcm1 <- paste(as.character(parameters_master$id[which(parameters_master$id == 'lc_conc')]),
                 ": ",
                 as.character(parameters_master$description[which(parameters_master$id == 'lc_conc')]))


bs_tcem_param1 <- bsTooltip(id = "tcem_lc_conc",
                            title = tt_tcm1,
                            placement =  "right",
                            options = list(container = "body"))



tt_tcm2 <- paste(as.character(parameters_master$id[which(parameters_master$id == 'lc_percent')]),
                   ": ",
                   as.character(parameters_master$description[which(parameters_master$id == 'lc_percent')]))

lbl_tcm <- as.character(parameters_master$name[which(parameters_master$id == 'lc_percent')])

tcem_param2 <- numericInput(inputId = "tcem_lc_percent",
                            label = lbl_tcm,
                            value = 0.5,
                            max = 1.0,
                            min = 0.0,
                            step = 0.05)

bs_tcem_param2 <- bsTooltip(id = "tcem_lc_percent",
                            title = tt_tcm2,
                            placement = "right",
                            options = list(container = "body"))

run_tcem_button <- actionButton(inputId = "run_tcem",
                                label = "Run TCEM Algorithm",
                                width = '250px',
                                style = "color: #fff; background-color: #337ab7; border-color: #2e6da4")

tcem_out_text <- htmlOutput("text_tcem")

download_predeterminedEffects_button <- actionButton(inputId = "download_predetermined_effects",
                                                     label = "Download Predetermined Effects Template",
                                                     width = '300px',
                                                     style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

bs_download_predeterminedEffects_button <- bsTooltip("download_predetermined_effects",
                                            "Open template file for entering predetermined effects. File is of CSV type.",
                                            "right", options = list(container = "body"))

download_predeterminedGrowthEffects_button<- actionButton(inputId = "download_predetermined_growth_effects",
                                                          label = "Download Predetermined Growth Effects Template",
                                                          width = '400px',
                                                          style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

bs_download_predeterminedGrowthEffects_button <- bsTooltip("download_predetermined_growth_effects",
                                                           "Open template file for entering predetermined growth effects. File is of CSV type.",
                                                           "right", options = list(container = "body"))

upload_predeterminedEffects_button <- fileInput(inputId = "upload_predetermined_effects",
                                                label = NULL,
                                                accept = c("text/csv","text/comma-separated-values,text/plain",".csv"),
                                                width = '400px',
                                                buttonLabel = "Upload Pre-determined Effects",
                                                placeholder = "No file selected")

bs_upload_predeterminedEffects_button <- bsTooltip("upload_predetermined_effects",
                                                   "Load existing file with predetermined effects into memory. Browse and select file from local drive.",
                                                   "right", options = list(container = "body"))

upload_predeterminedGrowthEffects_button <- fileInput(inputId = "upload_predetermined_growth_effects",
                                                      label = NULL,
                                                      accept = c("text/csv","text/comma-separated-values,text/plain",".csv"),
                                                      width = '600px',
                                                      buttonLabel = "Upload Pre-determined Growth Effects",
                                                      placeholder = "No file selected")

bs_upload_predeterminedGrowthEffects_button <- bsTooltip("upload_predetermined_growth_effects",
                                                         "Load existing file with predetermined growth effects into memory. Browse and select file from local drive.",
                                                         "right", options = list(container = "body"))

  
chemical_id_textInput <- textInput(inputId = "chemical_id",
                                   label = as.character(parameters_master$name[which(parameters_master$id == 'chem_id')]),
                                   value = "")

bs_chemical_id_button <- bsTooltip("chemical_id",
                                   paste(as.character(parameters_master$id[which(parameters_master$id == 'chem_id')]), ": ",
                                         as.character(parameters_master$description[which(parameters_master$id == 'chem_id')])),
                                   "right", options = list(container = "body"))

chemID_out_text <- textOutput("text_chemicalID")

enter_chemicalID_button <- actionButton(inputId = "store_chemicalID",
                                        label = "Store Chemical ID",
                                        width = '250px',
                                        style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

guts_out_text <- textOutput(("text_guts"))

winter_out_text1 <- textOutput("firstDay_winter")

bs_winter_out_text1 <- bsTooltip("start_winter",
                                 paste(as.character(parameters_master$id[which(parameters_master$id == 'winter_start')]), ": ",
                                       as.character(parameters_master$description[which(parameters_master$id == 'winter_start')])),
                                 "right", options = list(container = "body"))

winter_out_text2 <- textOutput("lastDay_winter")
bs_winter_out_text2 <- bsTooltip("end_winter",
                                 paste(as.character(parameters_master$id[which(parameters_master$id == 'winter_end')]), ": ",
                                       as.character(parameters_master$description[which(parameters_master$id == 'winter_end')])),
                                 "right", options = list(container = "body"))

label_zparam <- paste(as.character(parameters_master$id[which(parameters_master$id == 'z_winter')]),
                      ": ",
                      as.character(parameters_master$description[which(parameters_master$id == 'z_winter')]))

winter_zparam <- numericInput(inputId = "winter_cutoff",
                              label = as.character(parameters_master$name[which(parameters_master$id == 'z_winter')]),
                              value = 16,
                              min = 0.0)
bs_winter_zparam <- bsTooltip("winter_cutoff",
                              label_zparam,
                              "right", options = list(container = "body"))

store_winter_parameters_button <- actionButton(inputId = "store_winter_params",
                                               label = "Store Winter Parameters",
                                               width = '250px',
                                               style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

display_stressor_table_button <- actionButton(inputId = "display_stressor_table",
                                              label = "Display Stressor Parameters Table",
                                              width = '250px',
                                              style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

stressor_scenario_complete_text_out <- htmlOutput("stressor_scenario_complete")

hyperlink_stressor_newtab_button <- actionLink(inputId = "hyperlink_stressor_newtab",
                                               label = "Move to visualizing scenario(s)",
                                               width = '300px',
                                               style="#002966; background-color: #f2f2f2; border-color: #2e6da4")

hyperlink_run_stressor_button <- actionLink(inputId = "hyperlink_run_stressor",
                                               label = "Move to running scenario(s)",
                                               width = '300px',
                                               style="#002966; background-color: #f2f2f2; border-color: #2e6da4")

visualize_stressor_text_out <- textOutput("text_visualize_stressor")

run_stressor_text_out <- textOutput("text_run_stressor")

##################################################################################################
# Visualize Scenario(s) buttons/widgets
##################################################################################################
list_scenarios <- list()
check_boxes_Scenarios <- checkboxGroupInput("Check_Scenario_Names", "Select name(s):",
                                            width = '400px',
                                            selected = list_scenarios,
                                            choiceNames = list_scenarios,
                                            choiceValues = list_scenarios)

slider_calendar_text_out <- textOutput("calendar_format")

slider_parameters_button <- sliderInput(inputId = "slider_parameters",
                                        label = "Day number:",
                                        min = 1,
                                        max = 365,
                                        value = 91)

day_selection_button <- numericInput(inputId = "slider_DaySelection", 
                                     label = "Choose ordinal date",
                                     value = 91,
                                     min = 1,
                                     max = 365,
                                     step = 1,
                                     width = '100px')
                                     
plot_growth_button <- actionButton(inputId = "plot_growth",
                                   label = "Plot",
                                   width = '150px',
                                   style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

plot_survival_button <- actionButton(inputId = "plot_survival",
                                     label = "Plot",
                                     width = '150px',
                                     style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

plot_reproduction_button <- actionButton(inputId = "plot_reproduction",
                                         label = "Plot",
                                         width = '150px',
                                         style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

plot_spawning_probabilities_button <- actionButton(inputId = "plot_spawning_probs",
                                                   label = "Plot",
                                                   width = '150px',
                                                   style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

plot_survival_decrements_button <- actionButton(inputId = "plot_survival_decs",
                                                label = "Plot",
                                                width = '150px',
                                                style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

plot_exposure_concentrations_button <- actionButton(inputId = "plot_exposure_concs",
                                                    label = "Plot",
                                                    width = '150px',
                                                    style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

clear_growth_button <- actionButton(inputId = "clear_growth",
                                    label = "Clear",
                                    width = '75px',
                                    style="color: #fff; background-color: orange; border-color: #2e6da4")

clear_survival_button <- actionButton(inputId = "clear_survival",
                                      label = "Clear",
                                      width = '75px',
                                      style="color: #fff; background-color: orange; border-color: #2e6da4")

clear_reproduction_button <- actionButton(inputId = "clear_reproduction",
                                          label = "Clear",
                                          width = '75px',
                                          style="color: #fff; background-color: orange; border-color: #2e6da4")

clear_spawning_probabilities_button <- actionButton(inputId = "clear_spawning_probabilities",
                                                    label = "Clear",
                                                    width = '75px',
                                                    style="color: #fff; background-color: orange; border-color: #2e6da4")

clear_survival_decrements_button <- actionButton(inputId = "clear_survival_decrements",
                                          label = "Clear",
                                          width = '75px',
                                          style="color: #fff; background-color: orange; border-color: #2e6da4")

clear_exposure_concentrations_button <- actionButton(inputId = "clear_exposure_concentrations",
                                              label = "Clear",
                                              width = '75px',
                                              style="color: #fff; background-color: orange; border-color: #2e6da4")

export_growth_functions_button <- actionButton(inputId = "export_growth_modal",
                                               label = "Export",
                                               width = '75px',
                                               style = "color: #fff; background-color: green; border-color: #2e6da4")

export_survival_functions_button <- actionButton(inputId = "export_survival_modal",
                                                 label = "Export",
                                                 width = '75px',
                                                 style = "color: #fff; background-color: green; border-color: #2e6da4")

export_reproduction_functions_button <- actionButton(inputId = "export_reproduction_modal",
                                                     label = "Export",
                                                     width = '75px',
                                                     style = "color: #fff; background-color: green; border-color: #2e6da4")

export_spawning_functions_button <- actionButton(inputId = "export_spawning_modal",
                                                 label = "Export",
                                                 width = '75px',
                                                 style = "color: #fff; background-color: green; border-color: #2e6da4")

export_survival_decrements_button <- actionButton(inputId = "export_survivalDecrement_modal",
                                                  label = "Export",
                                                  width = '75px',
                                                  style = "color: #fff; background-color: green; border-color: #2e6da4")

export_exposure_concentrations_button <- actionButton(inputId = "export_exposureConcentration_modal",
                                                      label = "Export",
                                                      width = '75px',
                                                      style = "color: #fff; background-color: green; border-color: #2e6da4")

growth_modal_window <- bsModal(id = "growthPopup", 
                               title = "Growth Functions", 
                               trigger = "export_growth_modal", 
                               size = "large", 
                               textOutput("textMessageGrowth"),
                               plotOutput("plotGrowth"),
                               downloadButton(outputId = 'downloadPlotGrowth', label = 'Download'))

survival_modal_window <- bsModal(id = "survivalPopup",
                                 title = "Survival Functions", 
                                 trigger = "export_survival_modal", 
                                 size = "large", 
                                 textOutput("textMessageSurvival"),
                                 plotOutput("plotSurvival"),
                                 downloadButton(outputId = 'downloadPlotSurvival', 
                                                label = 'Download'))

reproduction_modal_window <- bsModal(id = "reproductionPopup",
                                     title = "Reproduction Functions", 
                                     trigger = "export_reproduction_modal", 
                                     size = "large", 
                                     textOutput("textMessageReproduction"),
                                     plotOutput("plotReproduction"),
                                     downloadButton(outputId = 'downloadPlotReproduction', 
                                                    label = 'Download')) 

spawning_modal_window <- bsModal(id = "spawningPopup",
                                     title = "Spawning Probabilities", 
                                     trigger = "export_spawning_modal", 
                                     size = "large", 
                                     textOutput("textMessageSpawning"),
                                     plotOutput("plotSpawning"),
                                     downloadButton(outputId = 'downloadPlotSpawning', 
                                                    label = 'Download'))    

survivalDecrement_modal_window <- bsModal(id = "survivalDecrementPopup",
                                          title = "Survival Decrements", 
                                          trigger = "export_survivalDecrement_modal", 
                                          size = "large", 
                                          textOutput("textMessageSurvivalDecrement"),
                                          plotOutput("plotSurvivalDecrement"),
                                          downloadButton(outputId = 'downloadPlotSurvivalDecrement', 
                                                         label = 'Download'))    

expousureConcentration_modal_window <- bsModal(id = "ExposureConcentrationPopup",
                                               title = "Exposure Concentrations", 
                                               trigger = "export_exposureConcentration_modal", 
                                               size = "large", 
                                               textOutput("textMessageExpousureConcentration"),
                                               plotOutput("plotExposureConcentration"),
                                               downloadButton(outputId = 'downloadPlotExposureConcentration', 
                                                              label = 'Download'))    

####################################################################################################
# Export Scenario Sub-tab
####################################################################################################
delete_scenario_button <- actionButton(inputId = "Delete_Scenario",
                                       label = "Delete Scenario",
                                       width = '150px',
                                       style="color: #fff; background-color: blue; border-color: #2e6da4")
            
delete_scenario_modal_window <- bsModal(id = "DeleteScenarioPopup",
                                        title = "Delete Scenario", 
                                        trigger = "Delete_Scenario", 
                                        size = "l", 
                                        verbatimTextOutput("textMessageDeleteScenario"),
                                        actionButton(inputId = 'actionDeleteScenario', 
                                                     label = 'Confirm and Delete',
                                                     width = '175px',
                                                     style="color: #fff; background-color: blue; border-color: #2e6da4"),
                                        hr(),
                                        modalButton(label = "Cancel"))
                                        # tags$head(tags$style("#DeleteScenarioPopup .modal-footer{display:none}")))

                                       
                                            
                                               

####################################################################################################
# Run Models
####################################################################################################
add_simulation_run_button <- actionButton(inputId = "add_SimulationRun",
                                          label = "Add Simulation Run",
                                          width = '250px',
                                          style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

list_scenarios_runs <- list()
check_boxes_Scenarios_Run <- checkboxGroupInput("Check_Scenario_Names_Run", "Select name(s):",
                                                width = '400px',
                                                selected = list_scenarios_runs,
                                                choiceNames = list_scenarios_runs,
                                                choiceValues = list_scenarios_runs)


num_size_classes_button <- numericInput(inputId = "num_size_classes",
                                        label = as.character(parameters_master$name[which(parameters_master$id == 'num_size_classes')]),
                                        value = 100,
                                        min = 80)

bs_num_size_classes_button <- bsTooltip("num_size_classes",
                                        paste(as.character(parameters_master$id[which(parameters_master$id == 'num_size_classes')]), ": ",
                                              as.character(parameters_master$description[which(parameters_master$id == 'num_size_classes')])),
                                        "right", options = list(container = "body"))


solver_order_button <- numericInput(inputId = "solver_order",
                                    label = as.character(parameters_master$name[which(parameters_master$id == 'solver_order')]),
                                    value = 3,
                                    min = 3)

bs_solver_order_button <- bsTooltip("solver_order",
                                    paste(as.character(parameters_master$id[which(parameters_master$id == 'solver_order')]), ": ",
                                          as.character(parameters_master$description[which(parameters_master$id == 'solver_order')])),
                                    "right", options = list(container = "body"))

runid_textBox <- textInput(inputId = "runid", 
                           label = "Run ID",
                           value = "")

runid_out_text <- textOutput("text_runid")

bs_runid_button <- bsTooltip(id = "runid",
                             title = "A string, with a maximum of 5 characters, that is unique for each run.",
                             placement = "right",
                             options = list(container = "body"))

runid_action_button <- actionButton(inputId = "enter_runid",
                                    label = "Submit Run ID",
                                    width = '250px',
                                    style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

initial_population_button <- numericInput(inputId = "initial_population",
                                          label = as.character(parameters_master$name[33]),
                                          value = 100,
                                          min = 10)

bs_initial_population_button <- bsTooltip("initial_population",
                                          paste(as.character(parameters_master$id[33]), ": ",
                                                as.character(parameters_master$description[33])),
                                          "right", options = list(container = "body"))


select_initial_distribution_button <- selectInput(inputId = "initial_distribution",
                                                  label = "Select Initial Distribution",
                                                  choices = c("None Selected",
                                                              "Uniform",
                                                              "Predetermined"))

bs_select_initial_distribution__button <- bsTooltip("initial_distribution",
                                                    "Select type of initial distribution.",
                                                    "right", options = list(container = "body"))


download_predeterminedDist_button <- actionButton(inputId = "download_predetermined_dist",
                                                  label = "Download Predetermined Distribution Template",
                                                  width = '250px',
                                                  style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

bs_download_predeterminedDist__button <- bsTooltip("download_predetermined_dist",
                                                    "Open templete file for entering predetermined initial distributions.",
                                                    "right", options = list(container = "body"))

upload_predeterminedDist_button <- fileInput(inputId = "upload_predetermined_dist",
                                             label = NULL,
                                             accept = c("text/csv","text/comma-separated-values,text/plain",".csv"),
                                             width = '400px',
                                             buttonLabel = "Upload Predetermined Distribution",
                                             placeholder = "No file selected")

bs_upload_predeterminedDist__button <- bsTooltip("upload_predetermined_dist",
                                                   "Load existing file with predetermined initial distributions into memory.",
                                                   "right", options = list(container = "body"))

run_simulations_button <- actionButton(inputId = "run_simulations",
                                       label = "Run Simulation(s)",
                                       width = '250px',
                                       style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

run_simulations_text <- textOutput("run_simulations_message")

####################################################################################################
#  Results
####################################################################################################
list_scenarios_results <- list()
check_boxes_scenarios_results <- checkboxGroupInput("Check_Scenario_Names_Results", "Select name(s):",
                                                    width = '400px',
                                                    selected = list_scenarios_results,
                                                    choiceNames = list_scenarios_results,
                                                    choiceValues = list_scenarios_results)

scenarios_summary_results_button <- actionButton(inputId = "summary_results_table",
                                                 label = "View",
                                                 width = '150px',
                                                 style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

clear_scenarios_summary_results_button <- actionButton(inputId = "clear_scenarios_summary_results",
                                                       label = "Clear",
                                                       width = '75px',
                                                       style="color: #fff; background-color: orange; border-color: #2e6da4")

export_summaryResults_button <- actionButton(inputId = "export_summaryResults_modal",
                                             label = "Export",
                                             width = '75px',
                                             style = "color: #fff; background-color: green; border-color: #2e6da4")

summaryResults_modal_window <- bsModal(id = "summaryResultsPopup",
                                       title = "Summary Results Table", 
                                       trigger = "export_summaryResults_modal", 
                                       size = "large", 
                                       textOutput("textMessageSummaryResults"),
                                       DT::dataTableOutput("plotSummaryResults"),
                                       downloadButton(outputId = 'downloadPlotSummaryResults', label = 'Download'))
                                        

plot_dailyPopulation_button <- actionButton(inputId = "plot_dailyPopulation",
                                            label = "Plot",
                                            width = '150px',
                                            style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

clear_dailyPopulation_button <- actionButton(inputId = "clear_dailyPopulation",
                                             label = "Clear",
                                             width = '75px',
                                             style="color: #fff; background-color: orange; border-color: #2e6da4")

export_dailyPopulation_button <- actionButton(inputId = "export_dailyPopulation_modal",
                                              label = "Export",
                                              width = '75px',
                                              style = "color: #fff; background-color: green; border-color: #2e6da4")
                                     

dailyPopulation_modal_window <- bsModal(id = "dailyPopulationPopup", 
                                        title = "Daily Population", 
                                        trigger = "export_dailyPopulation_modal", 
                                        size = "large", 
                                        textOutput("textMessageDailyPopulation"),
                                        plotOutput("plotDailyPopulation"),
                                        downloadButton(outputId = 'downloadPlotDailyPopulation', label = 'Download'))
                               

plot_populationBiomass_button <- actionButton(inputId = "plot_populationBiomass",
                                              label = "Plot",
                                              width = '150px',
                                              style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

clear_populationBiomass_button <- actionButton(inputId = "clear_populationBiomass",
                                               label = "Clear",
                                               width = '75px',
                                               style="color: #fff; background-color: orange; border-color: #2e6da4")

export_populationBiomass_button <- actionButton(inputId = "export_populationBiomass_modal",
                                                label = "Export",
                                                width = '75px',
                                                style = "color: #fff; background-color: green; border-color: #2e6da4")

populationBiomass_modal_window <- bsModal(id = "populationBiomassPopup",
                                          title = "Population Biomass", 
                                          trigger = "export_populationBiomass_modal", 
                                          size = "large", 
                                          textOutput("textMessagePopulationBiomass"),
                                          plotOutput("plotPopulationBiomass"),
                                          downloadButton(outputId = 'downloadPlotPopulationBiomass', label = 'Download'))

                                        
plot_meanSize_button <- actionButton(inputId = "plot_meanSize",
                                            label = "Plot",
                                            width = '150px',
                                            style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

clear_meanSize_button <- actionButton(inputId = "clear_meanSize",
                                             label = "Clear",
                                             width = '75px',
                                             style="color: #fff; background-color: orange; border-color: #2e6da4")

export_meanSize_button <- actionButton(inputId = "export_meanSize_modal",
                                       label = "Export",
                                       width = '75px',
                                       style = "color: #fff; background-color: green; border-color: #2e6da4")
                                                
meanSize_modal_window <- bsModal(id = "meanSizePopup",
                                 title = "Mean Size", 
                                 trigger = "export_meanSize_modal", 
                                 size = "large", 
                                 textOutput("textMessageMeanSize"),
                                 plotOutput("plotMeanSize"),
                                 downloadButton(outputId = 'downloadPlotMeanSize', label = 'Download'))
                                         

plot_growthPotential_button <- actionButton(inputId = "plot_growthPotential",
                                            label = "Plot",
                                            width = '150px',
                                            style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

clear_growthPotential_button <- actionButton(inputId = "clear_growthPotential",
                                             label = "Clear",
                                             width = '75px',
                                             style="color: #fff; background-color: orange; border-color: #2e6da4")

export_growthPotential_button <- actionButton(inputId = "export_growthPotential_modal",
                                       label = "Export",
                                       width = '75px',
                                       style = "color: #fff; background-color: green; border-color: #2e6da4")

growthPotential_modal_window <- bsModal(id = "growthPotentialPopup",
                                        title = "Growth Potential", 
                                        trigger = "export_growthPotential_modal", 
                                        size = "large", 
                                        textOutput("textMessageGrowthPotential"),
                                        plotOutput("plotGrowthPotential"),
                                        downloadButton(outputId = 'downloadPlotGrowthPotential', label = 'Download'))
                                 

plot_transitionalKernel_button <- actionButton(inputId = "plot_transitionalKernel",
                                               label = "Plot",
                                               width = '150px',
                                               style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

clear_transitionalKernel_button <- actionButton(inputId = "clear_transitionalKernel",
                                                label = "Clear",
                                                width = '75px',
                                                style="color: #fff; background-color: orange; border-color: #2e6da4")

export_transitionalKernel_button <- actionButton(inputId = "export_transitionalKernel_modal",
                                              label = "Export",
                                              width = '75px',
                                              style = "color: #fff; background-color: green; border-color: #2e6da4")

transitionalKernel_modal_window <- bsModal(id = "transitionalKernelPopup",
                                           title = "Transitional Kernel", 
                                           trigger = "export_transitionalKernel_modal", 
                                           size = "large", 
                                           textOutput("textMessageTransitionalKernel"),
                                           plotOutput("plotTransitionalKernel"),
                                           downloadButton(outputId = 'downloadPlotTransitionalKernel', label = 'Download'))
                                        

summary_matrix_button <- actionButton(inputId = "plot_summaryMatrix",
                                      label = "Plot",
                                      width = '150px',
                                      style="color: #fff; background-color: #337ab7; border-color: #2e6da4")

clear_matrix_button <- actionButton(inputId = "clear_matrix",
                                    label = "Clear",
                                    width = '75px',
                                    style="color: #fff; background-color: orange; border-color: #2e6da4")

export_matrix_button <- actionButton(inputId = "export_summaryMatrix_modal",
                                     label = "Export",
                                     width = '75px',
                                     style = "color: #fff; background-color: green; border-color: #2e6da4")
                                               
matrix_modal_window <- bsModal(id = "summaryMatrixPopup", 
                               title = "Summary Matrix", 
                               trigger = "export_summaryMatrix_modal", 
                               size = "large", 
                               textOutput("textMessageSummaryMatrix"),
                               plotOutput("plotSummaryMatrix"),
                               downloadButton(outputId = 'downloadPlotSummaryMatrix', label = 'Download'))


export_summaryMatrixTable_button <- actionButton(inputId = "export_summaryMatrixTable_modal",
                                                 label = "Export Table",
                                                 width = '100px',
                                                 style = "color: #fff; background-color: gray; border-color: #2e6da4")
                                             

matrixTable_modal_window <- bsModal(id = "summaryMatrixTablePopup",
                                    title = "Summary Matrix Table", 
                                    trigger = "export_summaryMatrixTable_modal", 
                                    size = "large", 
                                    textOutput("textMessageSummaryMatrixTable"),
                                    DT::dataTableOutput("plotSummaryMatrixTable"),
                                    downloadButton(outputId = 'downloadPlotSummaryMatrixTable', label = 'Download'))


delete_results_button <- actionButton(inputId = "Delete_Results",
                                      label = "Delete Results",
                                      width = '175px',
                                      style="color: #fff; background-color: blue; border-color: #2e6da4")
                                       

delete_results_modal_window <- bsModal(id = "DeleteResultsPopup",
                                       title = "Delete Results", 
                                       trigger = "Delete_Results", 
                                       size = "large", 
                                       verbatimTextOutput("textMessageDeleteResults"),
                                       actionButton(inputId = 'actionDeleteResults', 
                                                    label = 'Delete and Confirm',
                                                    width = '200px',
                                                    style="color: #fff; background-color: blue; border-color: #2e6da4"),
                                       hr(),
                                       modalButton(label = "Cancel"))    
                                        

