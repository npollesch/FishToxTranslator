# This function adds imported scenario name to list
submit_imported_scenarioName <- function(importedScenarioName, input_file)
{
  scenario_names <<- c(scenario_names, importedScenarioName)
  
  # Reads in the metadata worksheet of the excel file
  metaDataIn <- read_excel(input_file, 
                           sheet = "Metadata")
  
  # Extracts the Scenario description
  importedScenarioDesc <- as.character(subset(metaDataIn, 
                                              Field == "Scenario Description", 
                                              select = Value))
  
  # Once Scenario Name is submitted, append importedScenarioDesc to scenarioDescriptions list
  scenarioDescriptions[[importedScenarioName]] <<- importedScenarioDesc
  
  # Reads in the parameters worksheet of the excel file
  parametersIn <- as.data.frame(read_excel(input_file, sheet = "Parameters"))
  
  # Once Scenario Name is submitted, append parametersIn to parameters list
  parameters[[importedScenarioName]] <<- parametersIn
  
}

extract_name_imported_scenario <- function(input_file)
{
  # Reads in the metadata worksheet of the excel file
  metaDataIn <- read_excel(input_file, 
                           sheet = "Metadata")
  
  # Extracts the Scenario name
  importedScenarioName <- as.character(subset(metaDataIn, 
                                              Field == "Scenario Name", 
                                              select = Value))
  
  return(importedScenarioName)
}