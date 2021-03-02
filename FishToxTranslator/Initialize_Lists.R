## Intialize data.frames and lists used throughout code
parameters <- list() #list to store parameters for different scenarios
scenario_names <- vector() # Vector for storing scenario names
CurrentBaselineScenarioName <- NA
CurrentStressorScenarioName <- NA
CurrentImportedScenarioName <- NA

# Create an empty list to store scenario descriptions
scenarioDescriptions <- list()
CurrentScenarioDescription <- NA

inputz_t_0 <- list()

# Define run id variable
runID <- vector()
currentRunID <- NA

submittedRunID <- c()
submittedResultsName <- c()
runID_Exists <- FALSE
scenarioName_Exists <- FALSE

# Initialize lists to store model output
# temp List stores the most recent model runs
tempOutputs <- list()

# modelOutputs will store all completed model runs
modelOutputs <- list()

# Create list to store model run parameters.
modelRunParams <- data.frame(noSizeClasses = NA,
                             solverOrder = NA,
                             isPredet = NA,
                             isUnif = NA, 
                             unifN0 = NA,
                             predetFileString = NA)

# Create list to store tempOutputs
modelRuns <- list()

# Create list to store model run information
modelRunInfo <- list()

# Create variable to store current scenario names used in the last simulation run
SelectedSimulationRunScenarios <- vector()

# Create start and end times for reporting
startTimes <- c()
endTimes <- c()

inputPredeterminedGrowthEffectsData <- data.frame()
