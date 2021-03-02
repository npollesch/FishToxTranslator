extract_runID_scenarioName <- function(input_file)
{
  # Reads in the metadata worksheet of the excel file
  metaDataIn <- read_excel(input_file, sheet = "Metadata")
  
  # Extracts the imported RunID and scenarioName
  submittedRunID <<- as.character(subset(metaDataIn,
                                         Field == "Run ID", 
                                         select = Value))
  
  submittedResultsName <<- as.character(subset(metaDataIn, 
                                               Field == "Scenario Name", 
                                               select = Value))
  
  # Need to check if importedRunID is in runID
  runID_Exists <<- submittedRunID %in% runID
  
  # Need to check if importedScenarioName is in scenario_names
  scenarioName_Exists <<- submittedResultsName %in% scenario_names
}

submit_results_name <- function(inputScenarioName, input_file)
{
  # Assign name of imported scenario to temporary variable
  submittedResultsName  <<- inputScenarioName
  
  runID <<- cbind(runID, submittedRunID)
  
  # Reads in the metadata worksheet of the excel file
  metaDataIn <- read_excel(input_file, 
                           sheet = "Metadata")
  
  # Extracts the Scenario description
  importedScenarioDesc <- as.character(subset(metaDataIn, 
                                              Field == "Scenario Description", 
                                              select = Value))
  
  # Once Scenario Name is submitted, append importedScenarioDesc to scenarioDescriptions list
  scenarioDescriptions[[submittedResultsName]] <<- importedScenarioDesc
  
  # Reads in ModelRunInfo worksheet
  modelRunInfoIn <<- as.data.frame(read_excel(input_file, 
                                              sheet = "ModelRunInfo"))
  
  # Creates list space to store imported modelRunInfo
  modelRunInfo[[submittedRunID]] <<- list(modelRunParams = data.frame(), modelRunScenarios = c())
  
  # Adds modelRunInfo imported to modelRunInfo list
  modelRunInfo[[submittedRunID]][["modelRunParams"]] <<- modelRunInfoIn
  modelRunInfo[[submittedRunID]][["modelRunScenarios"]] <<- cbind(modelRunInfo[[submittedRunID]][["modelRunScenarios"]],
                                                                  submittedResultsName)
  
  # Reads in the modelRuns data from worksheet of the excel file
  dailySummaryIn <- as.data.frame(read_excel(input_file,sheet="dailySummary"))
  midpointsIn <- unname(as.vector(t(read_excel(input_file,sheet="midpoints"))))
  sizesIn <- as.list(unname(as.data.frame(t(read_excel(input_file,sheet="sizes")))))
  annualKernelIn <- unname(as.matrix(read_excel(input_file,sheet="annualKernel")))
  
  # Once everything is read in, append to modelOutputsList
  
  modelRuns[[submittedRunID]][[submittedResultsName]][["dailySummary"]] <<- dailySummaryIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["midpoints"]] <<- midpointsIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["sizes"]] <<- sizesIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["cumulativeTransitionKernel"]] <<- annualKernelIn
  
}


submit_results_runID <- function(inputRunID, input_file)
{
  # Assign run ID of imported scenario to temporary variable
  submittedRunID <<- inputRunID
  
  runID <<- cbind(runID, submittedRunID)
  
  # Reads in the metadata worksheet of the excel file
  metaDataIn <- read_excel(input_file, 
                           sheet = "Metadata")
  
  # Extracts the Scenario description
  importedScenarioDesc <- as.character(subset(metaDataIn, 
                                              Field == "Scenario Description", 
                                              select = Value))
  
  # Once Scenario Name is submitted, append importedScenarioDesc to scenarioDescriptions list
  scenarioDescriptions[[submittedResultsName]] <<- importedScenarioDesc
  
  # Reads in ModelRunInfo worksheet
  modelRunInfoIn <<- as.data.frame(read_excel(input_file, 
                                              sheet = "ModelRunInfo"))
  
  # Creates list space to store imported modelRunInfo
  modelRunInfo[[submittedRunID]] <<- list(modelRunParams = data.frame(), modelRunScenarios = c())
  
  # Adds modelRunInfo imported to modelRunInfo list
  modelRunInfo[[submittedRunID]][["modelRunParams"]] <<- modelRunInfoIn
  modelRunInfo[[submittedRunID]][["modelRunScenarios"]] <<- cbind(modelRunInfo[[submittedRunID]][["modelRunScenarios"]],
                                                                  submittedResultsName)
  
  # Reads in the modelRuns data from worksheet of the excel file
  dailySummaryIn <- as.data.frame(read_excel(input_file,sheet="dailySummary"))
  midpointsIn <- unname(as.vector(t(read_excel(input_file,sheet="midpoints"))))
  sizesIn <- as.list(unname(as.data.frame(t(read_excel(input_file,sheet="sizes")))))
  annualKernelIn <- unname(as.matrix(read_excel(input_file,sheet="annualKernel")))
  
  # Once everything is read in, append to modelOutputsList
  
  modelRuns[[submittedRunID]][[submittedResultsName]][["dailySummary"]] <<- dailySummaryIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["midpoints"]] <<- midpointsIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["sizes"]] <<- sizesIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["cumulativeTransitionKernel"]] <<- annualKernelIn
  
}

submit_imported_NameRunID <- function(inputRunID, inputScenarioName, input_file)
{
  # Assign run ID of imported scenario to temporary variable
  submittedRunID <<- inputRunID
  
  runID <<- cbind(runID, submittedRunID)
  
  # Assign name of imported scenario to temporary variable
  submittedResultsName  <<- inputScenarioName
  
  # Reads in the metadata worksheet of the excel file
  metaDataIn <- read_excel(input_file, 
                           sheet = "Metadata")
  
  # Extracts the Scenario description
  importedScenarioDesc <- as.character(subset(metaDataIn, 
                                              Field == "Scenario Description", 
                                              select = Value))
  
  # Once Scenario Name is submitted, append importedScenarioDesc to scenarioDescriptions list
  scenarioDescriptions[[submittedResultsName]] <<- importedScenarioDesc
  
  # Reads in ModelRunInfo worksheet
  modelRunInfoIn <<- as.data.frame(read_excel(input_file, 
                                              sheet = "ModelRunInfo"))
  
  # Creates list space to store imported modelRunInfo
  modelRunInfo[[submittedRunID]] <<- list(modelRunParams = data.frame(), modelRunScenarios = c())
  
  # Adds modelRunInfo imported to modelRunInfo list
  modelRunInfo[[submittedRunID]][["modelRunParams"]] <<- modelRunInfoIn
  modelRunInfo[[submittedRunID]][["modelRunScenarios"]] <<- cbind(modelRunInfo[[submittedRunID]][["modelRunScenarios"]],
                                                                  submittedResultsName)
  
  # Reads in the modelRuns data from worksheet of the excel file
  dailySummaryIn <- as.data.frame(read_excel(input_file,sheet="dailySummary"))
  midpointsIn <- unname(as.vector(t(read_excel(input_file,sheet="midpoints"))))
  sizesIn <- as.list(unname(as.data.frame(t(read_excel(input_file,sheet="sizes")))))
  annualKernelIn <- unname(as.matrix(read_excel(input_file,sheet="annualKernel")))
  
  # Once everything is read in, append to modelOutputsList
  
  modelRuns[[submittedRunID]][[submittedResultsName]][["dailySummary"]] <<- dailySummaryIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["midpoints"]] <<- midpointsIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["sizes"]] <<- sizesIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["cumulativeTransitionKernel"]] <<- annualKernelIn
  
}

verifyResultsScenarioName <- function(inputScenarioName)
{
  inputScenarioName %in% scenario_names
}

verifyResultsRunID <- function(inputRunID)
{
  inputRunID %in% runID
}

