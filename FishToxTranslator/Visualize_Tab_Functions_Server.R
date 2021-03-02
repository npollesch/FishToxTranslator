####~ Visualize ###
plot_growth_parameters <- function(inputScenariosToVis, dateInput)
{
  if (is.null(inputScenariosToVis))
  {
    return(10)
  }else
  {
    PlotGrowth(parameters[inputScenariosToVis],dateInput)
  }
}

plot_survival_parameters <- function(inputScenariosToVis, dateInput)
{
  if (is.null(inputScenariosToVis))
  {
    return(10)
  }else
  {
    PlotSurvival(parameters[inputScenariosToVis],dateInput)
  }
}

plot_reproduction_parameters <- function(inputScenariosToVis, dateInput)
{
  if (is.null(inputScenariosToVis))
  {
    return(10)
  }else
  {
    PlotReproduction(parameters[inputScenariosToVis],dateInput)
  }
}

plot_scenarios_spawning_probabilities <- function(inputScenariosToVis)
{
  if (is.null(inputScenariosToVis))
  {
    return(10)
  }else
  {
    PlotSpawningProbs(parameters[inputScenariosToVis])
  }
}

plot_scenarios_survival_decrements <- function(inputScenariosToVis)
{
  surv_decr_exists <- FALSE

  if (is.null(inputScenariosToVis))
  {
    return(10)
  }else
  {
    for (scenario in 1:length(inputScenariosToVis))
    {
      surv_decr_exists <- exists("survival_decrement", parameters[[inputScenariosToVis[scenario]]])
      if (surv_decr_exists == TRUE) break
    }
    if (surv_decr_exists == TRUE)
    {
      PlotSurvivalDecrements(parameters[inputScenariosToVis])
    }
    else
    {
      shinyjs::hide(id = "Visualization_SDEC")
      return(10)
    }
  }
}

plot_scenarios_exposure_concentrations <- function(inputScenariosToVis)
{
  exp_conc_exists <- FALSE

  if (is.null(inputScenariosToVis))
  {
    return(10)
  }else
  {
    for (scenario in 1:length(inputScenariosToVis))
    {
      exp_conc_exists <- exists("exp_concentrations", parameters[[inputScenariosToVis[scenario]]])
      if (exp_conc_exists == TRUE) break
    }
    if (exp_conc_exists == TRUE)
    {
      PlotExposureConcentrations(parameters[inputScenariosToVis])
    }
    else
    {
      shinyjs::hide(id = "Visualization_SDEC")
      return(10)
    }
  }
}

