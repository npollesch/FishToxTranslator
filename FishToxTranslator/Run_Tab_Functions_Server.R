#######################################################################################################
# Stressor Scenario Name
#######################################################################################################
enter_run_id <- function(inputRunId)
{
  currentRunID <<- inputRunId
  # runID <<- c(runID, inputRunId)
}

verifyRunID <- function(inputRunId)
{
  result <- tolower(inputRunId) %in% tolower(runID)
  return(result)
}

#######################################################################################################
# Predetermined initial distribution
#######################################################################################################
generate_PredeterminedDist_Template <- function(input_num_size_classes)
{
  predetinitialdist <- data.frame(ordinal_date = 1:input_num_size_classes, density_in_class=NA)
  csv_file <- paste("Predetermined_Dist_","time", 
                    gsub(":","_",strsplit(date()," ")[[1]][4]),".csv",
                    sep = "_")
  write.csv(predetinitialdist, file = csv_file, row.names = FALSE)
  return (csv_file)
}

assign_plot_Predetermined_Initial_Distribution <- function(input_file)
{
  ## Upload predetermined initial distribution data
  inputPredeterminedIntitialDist <- read.csv(file = input_file, 
                                             header = TRUE, 
                                             stringsAsFactors = FALSE, 
                                             check.names = FALSE)
  
  ## Assign predetermined initial distribution input the proper variable for simulation
  inputz_t_0 <<- inputPredeterminedIntitialDist[,2]
  
  ## Plot input of predetermined initial distribution
  plot(x = inputPredeterminedIntitialDist[,1],
       y = inputPredeterminedIntitialDist[,2],
       main = "User-specified initial distribution",
       xlab = "Size class",
       ylab = "Density of individuals")
}

run_predetermined_dist_simulation <- function(inputScenariosToRun, inputNumSizeClasses, inputSolverOrder, inputFilePredet, inputFilePredetName)
{
  # Reset modelRunParams values to NA before assigning new ones.
  modelRunParams$noSizeClasses <<- NA
  modelRunParams$solverOrder <<- NA
  modelRunParams$isPredet <<- NA
  modelRunParams$isUnif <<- NA
  modelRunParams$unifN0 <<- NA
  modelRunParams$predetFileString <<- NA
  
  # Store number of size classes
  modelRunParams$noSizeClasses <<- inputNumSizeClasses
  
  # Store solver order
  modelRunParams$solverOrder <<- inputSolverOrder
  
  ## set the modelRunInfo isPredet to TRUE
  modelRunParams$isPredet <<- TRUE
  
  ## set modelRunInfo isUnif to FALSE and set unifN0 to NA, since it won't be specified
  modelRunParams$isUnif <<- FALSE
  modelRunParams$unifN0 <<- NA
  
  # Set predetFileString to pathname of input file
  modelRunParams$predetFileString <<- inputFilePredetName
  
  numCores <- detectCores()
  cl <- makeCluster(numCores)
  clusterExport(cl,"parameters")
  tempOutputs <<- parLapply(cl, 
                            parameters[inputScenariosToRun], 
                            SimulateModel, 
                            z_t_0 = inputz_t_0, 
                            num_size_classes = length(inputz_t_0), 
                            solver_order = inputSolverOrder)
  stopCluster(cl)
  
  # Append runID character to tempOutputs names characters
  # names(tempOutputs) <<- paste(currentRunID, names(tempOutputs))
  
  # Add the tempOutputs to the modelOutputs list
  modelOutputs <<- c(modelOutputs,tempOutputs)
  
  # Add current run ID to the run IDs list
  runID <<- c(runID, currentRunID)
  
  # Add the tempOutputs to the modelRuns list
  modelRuns[[currentRunID]] <<- tempOutputs
  
  # Add the model run information to the modelRunInfo list()
  modelRunInfo[[currentRunID]][["modelRunParams"]] <<- modelRunParams
  modelRunInfo[[currentRunID]][["modelRunScenarios"]] <<- inputScenariosToRun
}

run_uniform_dist_simulation <- function(inputScenariosToRun, inputNumberInitInd, inputNumSizeClasses, inputSolverOrder)
{
  modelRunParams$noSizeClasses <<- NA
  modelRunParams$solverOrder <<- NA
  modelRunParams$isPredet <<- NA
  modelRunParams$isUnif <<- NA
  modelRunParams$unifN0 <<- NA
  modelRunParams$predetFileString <<- NA
  
  # Store number of size classes
  modelRunParams$noSizeClasses <<- inputNumSizeClasses
  
  # Store solver order
  modelRunParams$solverOrder <<- inputSolverOrder
  
  modelRunParams$isUnif <<- TRUE
  modelRunParams$isPredet <<- FALSE
  modelRunParams$predetFileString <<- NA
  modelRunParams$unifN0 <<- inputNumberInitInd
  
  # Run the model
  # Set up parallel model runs using package "parallel"
  numCores <- detectCores()
  cl <- makeCluster(numCores)
  clusterExport(cl,"parameters")
  tempOutputs <<- parLapply(cl, 
                            parameters[inputScenariosToRun], 
                            SimulateModel, 
                            n_0 = inputNumberInitInd, 
                            num_size_classes = inputNumSizeClasses, 
                            solver_order = inputSolverOrder)
  stopCluster(cl)
  
  # Append runID character to tempOutputs names characters
  # names(tempOutputs) <<- paste(currentRunID, names(tempOutputs))
  
  # Add the tempOutputs to the modelOutputs list
  modelOutputs <<- c(modelOutputs, tempOutputs)
  
  # Add current run ID to the run IDs list
  runID <<- c(runID, currentRunID)
  
  # Add the tempOutputs to the modelRuns list
  modelRuns[[currentRunID]] <<- tempOutputs
  
  modelRunInfo[[currentRunID]][["modelRunParams"]] <<- modelRunParams
  modelRunInfo[[currentRunID]][["modelRunScenarios"]] <<- inputScenariosToRun
  
}

run_selected_simulations <- function(inputScenariosToRun, inputNumberInitInd, inputDist)
{
  if (inputDist == 'Predetermined')
  {
    modelOutputs <<- lapply(parameters[inputScenariosToRun], SimulateModel, z_t_0 = inputz_t_0)
    
  }else if (inputDist == 'Uniform')
  {
    modelOutputs <<- lapply(parameters[inputScenariosToRun], SimulateModel, n_0 = inputNumberInitInd)
    
  }else
  {
    return(NULL)
  }
#  summaryTable <- SummaryTable(modelOutputs)
#  return(summaryTable)
}

return_summary_table <- function()
{
  summaryTable <- SummaryTable(modelOutputs)
  return(summaryTable)
}