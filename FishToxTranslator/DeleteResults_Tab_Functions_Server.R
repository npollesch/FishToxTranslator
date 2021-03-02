delete_Results <- function(inputRunID, inputResultsName)
{
  print("Inside delete_Results")
  print(inputRunID)
  print(inputResultsName)
  
  # Remove results from modelRuns list
  modelRuns[[inputRunID]][[inputResultsName]] <<- NULL
  
  if (is_empty(modelRuns[[inputRunID]]))
  {
    modelRuns[[inputRunID]] <<- NULL
    modelRunInfo[[inputRunID]] <<- NULL
    runID <<- runID[-which(runID %in% inputRunID)]
  }else
  {
    tempList1 <- modelRunInfo[[inputRunID]][["modelRunScenarios"]]
    nameIndex <- which(modelRunInfo[[inputRunID]][["modelRunScenarios"]] %in% inputResultsName)
    tempList2 <- tempList1[-nameIndex]
    modelRunInfo[[inputRunID]][["modelRunScenarios"]] <<- tempList2 
  }
 # modelOutputs[which(names(modelOutputs) %in% inputResultsToDelete)] <<- NULL
}

