source("SubTabs_Panel.R", local = TRUE)

tabHome <- tabPanel("About",
                    div(img(src='ft_logov01beta.png', width=300, halign = "center"),style="text-align: center;"),

                      h2("What is the Fish Toxicity Translator?"),
                      h4('The Fish Toxicity Translator is a model that translates the acute effects of toxic exposure to population level impacts for a specified life history and chemical exposure profile.  Annual simulations are created by modeling daily dynamics, life history, exposure, and effects are customizable and results focus on deviations from baseline scenarios.'),
                    tags$ul(
                    h5(tags$li('The Fish Toxicity Translator works by introducing stressor scenarios to an underlying annual baseline life history model')),
                      h5(tags$li(paste('The model has a built-in parameterization for Fathead minnow (P. promelas) life history and can be parameterized for other species using the available Species Life History Template',sep=""))),
                      h5(tags$li('Non-chemical stressors can also be modeled and overlaid on baseline or chemical stressor scenarios.  The current non-chemical stressor included in the model is over-winter growth and survival')),
                      h5(tags$li('Model results are provided as deviations from baseline population dynamics and multiple stressor scenarios can be compared to each other as well as the baseline')),
                      h5(tags$li('Model results include a variety of population demographics, including population size structure and time-series of daily population changes'))),
                      h2("Fish Toxicity Translator Workflow"),
                      div(img(src='workflow_diagram.png', width=729, halign = "center"),style="text-align: center;"),
                      h2("Contact Information"),
                      h5("This beta version of the graphical user interface and model is undergoing continous development for the user interface, the underlying model structure, and the guidance documentation.  Please do not hesitate to contact Nate Pollesch (pollesch.nathan@epa.gov) or Matthew Etterson (etterson.matthew@epa.gov) with any questions.")
                  )

tab1 <- tabPanel("Scenario Builder",
                 tags$style(".popover{
            max-width: 50%;
          }"),
                 div(popify(el=h3("Scenario Builder"),placement="right",title="<b>Scenario Builder</b>",content="The Fish Toxicity Translator compares multiple scenarios to explore differential effects of stressor exposures on population level outcomes. Baseline scenarios are created first and stressors are overlaid.  Scenario building is when input values and data are specified to create the multiple scenarios to investigate."),style = 'width:225px;'),

                 tabsetPanel(subtab1,
                             subtab2,
                             subtab3,
                             subtab4,
                             subtab5,
                             id = "tabsetPanel_scenarios")
                 )

tab2 <- tabPanel("Visualize Built Scenario(s)",
                 tags$style(".popover{
            max-width: 50%;
          }"),
                 div(popify(el=h3("Visualize Built Scenario(s)"),placement="right",title="<b>Visualize Built Scenario(s)</b>",content="The visualization step allows you to compare scenarios before they are simulated.  Visualization options include daily differences in growth, reproduction, and survival functions and differences in exposures and associated effects by scenario.  Click and unclick built scenarios to include them in plots; various plots can be displayed and cleared for convenience."),style = 'width:300px;'),

                 sidebarLayout
                    (
                      sidebarPanel
                      (
                        shinyjs::hidden(
                          div(id = "Visualization_GRS",
                              check_boxes_Scenarios,
                              h4(""),
                              hr(),
                              h4("Visualize: Growth, Reproduction, and Survival"),
                              hr(),
                              day_selection_button,
                              h4(""),
                              slider_parameters_button,
                              h4(""),
                              h4("Growth Functions"),
                              fluidRow(
                                plot_growth_button,
                                clear_growth_button,
                                export_growth_functions_button
                              ),
                              h4(""),
                              h4("Survival Functions"),
                              fluidRow(
                                plot_survival_button,
                                clear_survival_button,
                                export_survival_functions_button
                              ),
                              h4(""),
                              h4("Reproduction Functions"),
                              fluidRow(
                                plot_reproduction_button,
                                clear_reproduction_button,
                                export_reproduction_functions_button
                              ),
                              h4(""))
                        ),
                        shinyjs::hidden(
                          div(id = "Visualization_SPB",
                              hr(),
                              h4("Visualize: Scenario Parameters"),
                              hr(),
                              h4("Spawning Probabilities"),
                              fluidRow(
                                plot_spawning_probabilities_button,
                                clear_spawning_probabilities_button,
                                export_spawning_functions_button
                              ),
                              h4(""))
                        ),

                        shinyjs::hidden(
                          div(id = "Visualization_SDEC",
                              h4("Survival Decrements"),
                              fluidRow(
                                plot_survival_decrements_button,
                                clear_survival_decrements_button,
                                export_survival_decrements_button
                              ),
                              h4(""),
                              h4("Exposure Concentrations"),
                              fluidRow(
                                plot_exposure_concentrations_button,
                                clear_exposure_concentrations_button,
                                export_exposure_concentrations_button
                              )
                        ))

                      ),

                      mainPanel
                      (

                        shinyjs::hidden(div(id = "Growth_out_Main",
                                            plotOutput(outputId = "Growth_out"))),
                        
                        growth_modal_window,

                        shinyjs::hidden(div(id = "Survival_out_Main",
                                            plotOutput(outputId = "Survival_out"))),
                        
                        survival_modal_window,

                        shinyjs::hidden(div(id = "Reproduction_out_Main",
                                            plotOutput(outputId = "Reproduction_out"))),
                        
                        reproduction_modal_window,

                        shinyjs::hidden(div(id = "SpawningProb_out_Main",
                                            plotOutput(outputId = "SpawningProb_Out"))),
                        
                        spawning_modal_window,

                        shinyjs::hidden(div(id = "SurvivalDecrement_out_Main",
                                            plotOutput(outputId = "SurvivalDecrement_out"))),
                        
                        survivalDecrement_modal_window,

                        shinyjs::hidden(div(id = "ExposureConcentration_out_Main",
                                            plotOutput(outputId = "ExposureConcentration_out"))),
                        
                        expousureConcentration_modal_window

                      )

                    )
)


tab3 <- tabPanel("Run Scenarios",

          tags$style(".popover{
            max-width: 50%;
          }"),
          div(popify(el=h3("Run Scenarios"),placement="right",title="<b>Run Scenarios</b>",content="Choose the model scenarios you would like to simulate. Initial conditions and computational parameters are input below."),style = 'width:200px;'),

                 sidebarLayout(

                   sidebarPanel(
                     add_simulation_run_button,
                     h4(""),
                     
                     shinyjs::hidden(
                       div(id = "Run_Scenarios_Options",
                           check_boxes_Scenarios_Run,
                           h4(""),
                           runid_textBox,
                           bs_runid_button,
                           h4(""),
                           runid_action_button,
                           h4(""),
                           runid_out_text,
                           h4(""))),
                     
                     shinyjs::hidden(div(id = "Run_Parameters_Distributions",
                                         h4("Computational Parameters"),
                                         "Default computational parameters are recommended, altering these values may result in numerical inaccuracies or increased simulation run times.",
                                         h4(""),
                                         num_size_classes_button,
                                         bs_num_size_classes_button,
                                         h4(""),
                                         solver_order_button,
                                         bs_solver_order_button,
                                         h4(""),
                                         h4("Initial conditions and simulation parameters"),
                                         select_initial_distribution_button,
                                         bs_select_initial_distribution__button,
                                         
                                         conditionalPanel(condition = "input.initial_distribution == 'Predetermined'",
                                                          download_predeterminedDist_button,
                                                          bs_download_predeterminedDist__button,
                                                          h4(""),
                                                          upload_predeterminedDist_button,
                                                          bs_upload_predeterminedDist__button),
                                         
                                         conditionalPanel(condition = "input.initial_distribution == 'Uniform'",
                                                          initial_population_button,
                                                          bs_initial_population_button))),

                     shinyjs::hidden(div(id = "run_simulations_section",
                                         run_simulations_button,
                                         h4("")))
                     ),

                   mainPanel(
                     shinyjs::hidden(div(id = "Predetermined_Initial_Distribution_Main",
                                         plotOutput(outputId = "Predetermined_Initial_Distribution_out")))

                   )  # Main Panel closing bracket
                 )    # sidebarLayout closing bracket

)    # Tab Panel closing bracket



tab4 <- tabPanel("Results",
                        tags$style(".popover{
                   max-width: 50%;
                 }"),
                div(popify(el=h3("Results"),placement="right",title="<b>Results</b>",content="In the results step, model outputs are visualized and compared.  Numerical text-based summaries of model outputs are produced as well as a variety of visualizations to explore model behavior across scenarios and within a single modeled scenario."),style = 'width:150px;'),
                 
                 tabsetPanel(subtab41,
                             subtab42,
                             subtab43,
                             subtab44)

)
