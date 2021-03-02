delete_scenario <- function(inputScenarioToDelete)
{
  # Remove scenario from parameter list
  parameters[which(names(parameters) %in% inputScenarioToDelete)] <<- NULL
  
  # Remove scenario from list of scenario Names
  scenario_names <<- scenario_names[-which(scenario_names == inputScenarioToDelete)]
}