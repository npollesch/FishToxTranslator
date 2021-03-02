#####################################################################################################
#  Functions associated with the Results tab.
#####################################################################################################
return_summary_results_table <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(NULL)
  }else
  {
    # summaryTableResults <- SummaryTable(modelOutputs[inputScenariosForResults])
    summaryTableResults <- SummaryTable(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    return(summaryTableResults)
  }
}

plot_Daily_Population <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(10)
  }else
  {
    PlotPopulation(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    # PlotPopulation(modelOutputs[inputScenariosForResults])
  }
}

plot_Population_Biomass <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(10)
  }else
  {
    PlotBiomass(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    # PlotBiomass(modelOutputs[inputScenariosForResults])
  }
}

plot_Mean_Size <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(10)
  }else
  {
    PlotMeanSize(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    # PlotMeanSize(modelOutputs[inputScenariosForResults])
  }
}

plot_Growth_Potential <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(10)
  }else
  {
    PlotGrowthPotential(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    # PlotGrowthPotential(modelOutputs[inputScenariosForResults])
  }
}

plot_Transitional_Kernel <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(10)
  }else
  {
    PlotTransitionKernel(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    # PlotTransitionKernel(modelOutputs[inputScenariosForResults])
  }
}

plot_Summary_Matrix <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(10)
    
  }else if (length(inputScenariosForResults) < 2)
  {
    return(10)
    
  }else
  {
    PlotSummaryMatrix(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    # PlotSummaryMatrix(modelOutputs[inputScenariosForResults])
  }
}