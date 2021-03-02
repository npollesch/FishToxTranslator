# Baseline Tab Functions

####################################################################################################
# Baseline Name
####################################################################################################
enter_baseline_scenario_name <- function(currentScenarioName, currentScenarioDescription)
{
  CurrentBaselineScenarioName <<- currentScenarioName
  scenario_names <<- c(scenario_names, currentScenarioName)
  
  CurrentScenarioDescription <<- currentScenarioDescription
  scenarioDescriptions[[CurrentBaselineScenarioName]] <<- currentScenarioDescription
}

####################################################################################################
# Verify scenario name
####################################################################################################
verifyScenarioName <- function(inputScenarioName)
{
  result <- tolower(inputScenarioName) %in% tolower(scenario_names)
  return(result)
}

####################################################################################################
# Parameter Template Creation
####################################################################################################
LifeHistory_Parameters <- function()
{
  lifeHistoryTemplate <- subset(parameters_master,gui_category=="baseline")
  lifeHistoryTemplate <- add_column(lifeHistoryTemplate,value=NA,.after="id")
  lifeHistoryTemplate <- lifeHistoryTemplate[,1:5]
  
  csv_file <- paste("lifeHistoryTemplate","time", 
                    gsub(":","_",strsplit(date()," ")[[1]][4]),".csv",
                    sep = "_")
  write.csv(lifeHistoryTemplate, file = csv_file, row.names = FALSE)
  return (csv_file)
}

load_fhm_parameters <- function(currentScenarioName, chosenSpecies)
{
  chosenSpeciesDataObject <- as.character(species_library$parameter_data[which(species_library$common_name==chosenSpecies)])
  chosenLifeHistoryParameters <- get(chosenSpeciesDataObject)
  parameters[[currentScenarioName]] <<- TemplateToDataFrame(chosenLifeHistoryParameters)
}

####################################################################################################
# Spawning Algorithm
####################################################################################################
run_spawning_algorithm <- function(currentScenarioName)
{
  # GUI: Run Spawning Algorithm
  dailySpawningProb <- GenerateSpawningProbs(repro_start=parameters[[currentScenarioName]]$repro_start[1],
                                             repro_end=parameters[[currentScenarioName]]$repro_end[1],
                                             spawns_max_season=parameters[[currentScenarioName]]$spawns_max_season[1],
                                             spawn_int=parameters[[currentScenarioName]]$spawn_int[1])
  
  parameters[[currentScenarioName]] <<- cbind(parameters[[currentScenarioName]],p_spawn=dailySpawningProb)
}

assign_history_pars <- function(currentScenarioName, input_life_history)
{
  newLifeHistory <- read.csv(file = input_life_history, header = TRUE,
                             stringsAsFactors = FALSE, check.names = FALSE)
  parameters[[currentScenarioName]] <<- TemplateToDataFrame(newLifeHistory)
}

return_history_pars <- function(currentScenarioName)
{
  return(parameters[[currentScenarioName]])
}

####################################################################################################
# set parameters
####################################################################################################
set_all_parameters <- function(currentScenarioName)
{
  par[[currentScenarioName]] <<- parameters[[currentScenarioName]]
  #  parameters <<- list()
  
}

####################################################################################################
# Plotting functions
####################################################################################################
plot_spawning_probabilities <- function(currentScenarioName)
{
  # Display plot upon algorithm completion
  plot(parameters[[currentScenarioName]]$p_spawn,
       main = "Daily Spawning Probability",
       xlab = "Ordinal Date",
       ylab = "Spawning Probability")
}


####################################################################################################
# Export functions
####################################################################################################
export_baseline_parameters <- function(scenario)
{
  df_params <- parameters[[scenario]]
  file_name <- paste(scenario, "_parameters_time",gsub(":","_",strsplit(date()," ")[[1]][4]),".csv",sep="_")
  write.csv(df_params, file = file_name, row.names = FALSE)
}
