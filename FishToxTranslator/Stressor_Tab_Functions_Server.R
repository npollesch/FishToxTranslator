#######################################################################################################
# Stressor Scenario Name
#######################################################################################################
enter_stressor_scenario_name <- function(baselineScenarioName, stressorScenarioName, currentScenarioDescription)
{
  CurrentStressorScenarioName <<- stressorScenarioName
  # scenario_names <<- c(scenario_names, stressorScenarioName)
  parameters[[stressorScenarioName]] <<- parameters[[baselineScenarioName]]
  
  CurrentScenarioDescription <<- currentScenarioDescription
  scenarioDescriptions[[stressorScenarioName]] <<- currentScenarioDescription
}

#######################################################################################################
# Winter functions
#######################################################################################################
store_winter_parameters <- function(inputStressorScenarioName, inputWinterStart, inputWinterEnd, inputWinterSizeCutoff)
{
  parameters[[inputStressorScenarioName]]$z_winter <<- inputWinterSizeCutoff
  
  # Set winter dates
  winterDates <- SetWinterDates(winterStartDate=inputWinterStart,winterEndDate=inputWinterEnd)
  parameters[[inputStressorScenarioName]]$is_winter <<- winterDates
  
  # Calculate Winter daily survival: Needs winter start and end dates
  winterSurvivalProbs <- GenerateWinterSurvival(winterStartDate=inputWinterStart,winterEndDate=inputWinterEnd)
  parameters[[inputStressorScenarioName]]$s_winter <<- winterSurvivalProbs
  
  result <- tolower(inputStressorScenarioName) %in% tolower(scenario_names)
  if (result == FALSE)
  {
    scenario_names <<- c(scenario_names, CurrentStressorScenarioName)
  }
}

plot_winter_decreasing_survival <- function(inputStressorScenarioName, inputWinterStart, inputWinterEnd, inputWinterSizeCutoff)
{
  # Plot decreasing survival over winter based on duration and size cutoff
  winterLength <- length(DateDuration(inputWinterStart,inputWinterEnd))
  dailyWinterSurvival <- 0.0001^(1/winterLength)
  plot(dailyWinterSurvival^(1:winterLength),
       xlab = "Winter day",
       ylab = "Cumulative survival probability",
       main = paste("Cumulative winter survival for individuals < ",inputWinterSizeCutoff," mm", sep=""))
}


#######################################################################################################
# TCEM functions
#######################################################################################################
run_tcem <- function(inputStressorScenarioName, tcem1, tcem2)
{
  TCEMNeeds <- parameters_master$id[grepl("TCEM",parameters_master$called_by)]
  
  # Can filter this against known/entered parameters in the scenario to determine which are needed
  TCEMInputsRequest <- TCEMNeeds[!TCEMNeeds %in% names(parameters[[inputStressorScenarioName]])]
  parameters[[inputStressorScenarioName]][,as.character(TCEMInputsRequest)] <<- NA
  
  # GUI: Get TCEM Parameters and append to parameters data.frame
  parameters[[inputStressorScenarioName]]$lc_percent <<- tcem2
  parameters[[inputStressorScenarioName]]$lc_conc <<- tcem1
  
  # Run the TCEM algorithm
  TCEMOutput <- TCEM(exposure_concentrations = parameters[[inputStressorScenarioName]]$exp_concentrations,
                     lc_con = parameters[[inputStressorScenarioName]]$lc_con[1],
                     lc_percent = parameters[[inputStressorScenarioName]]$lc_percent[1])
  
  # Plot the TCEM predicted daily survival decrement
  # Note: The negative of the TCEM function output is plotted here to show survival 
  # decrement (although that value is positive)
  plot(-TCEMOutput, 
       main="TCEM Daily Survival Decrements",
       xlab="Ordinal Date",
       ylab="Daily Survival Decrement",
       type="l")
  
  # Add TCEM output to parameters data.frame
  parameters[[inputStressorScenarioName]]$survival_decrement <<- TCEMOutput
  
}

#######################################################################################################
# Return functions
#######################################################################################################
return_stressor_parameters <- function(inputStressorScenarioName)
{
  return(parameters[[inputStressorScenarioName]])
}


#######################################################################################################
# Exposure Concentrations
#######################################################################################################
generate_ExposureConcentration_Template <- function()
{
  expDF <- data.frame(ordinal_date = 1:365, exp_concentrations = NA)
  csv_file <- paste("exposure_concentrations","time", 
                    gsub(":","_",strsplit(date()," ")[[1]][4]),".csv",
                    sep = "_")
  write.csv(expDF, file = csv_file, row.names = FALSE)
  return (csv_file)
}
 
assign_exposure_concentrations <- function(scenario, input_file)
{
  upload_scenario <- read.csv(file = input_file, 
                              header = TRUE, 
                              stringsAsFactors = FALSE, 
                              check.names = FALSE)
  
  parameters[[scenario]]$exp_concentrations <<- upload_scenario$exp_concentrations
}

plot_exposure_concentrations <- function(scenario)
{
  plot(parameters[[scenario]]$exp_concentrations,
       main="Daily Exposure Concentrations",
       xlab="Ordinal date",
       ylab="Concentration",
       type="l")
}

#######################################################################################################
# Pre-determined Effects
#######################################################################################################
generate_Predetermined_Effects_Template <- function()
{
  # Create empty predetermined effects data.frame
  predeteffDF <- data.frame(ordinal_date = 1:365, survival_decrement = NA)
  
  # Download predetermined effects data frame
  csv_file <- paste("Predetermined_Effects_Template","_time", 
                    gsub(":","_",strsplit(date()," ")[[1]][4]),".csv",
                    sep = "_")
  write.csv(predeteffDF, file = csv_file, row.names=FALSE)
  return (csv_file)
}

assign_predetermined_effects <- function(inputStressorScenarioName, input_file)
{
  upload_scenario <- read.csv(file = input_file, 
                              header = TRUE, 
                              stringsAsFactors = FALSE, 
                              check.names = FALSE)
  
  parameters[[inputStressorScenarioName]]$survival_decrement <<- upload_scenario$survival_decrement
  
}

generate_Predetermined_Growth_Effects_Template <- function()
{
  # Create empty predetermined growth effects data.frame
  predeteffDF <- data.frame(ordinal_date = 1:365, growth_percent = NA)
  
  # Download predetermined effects data frame
  csv_file <- paste("Predetermined_Growth_Effects_Template.csv","_time", 
                    gsub(":","_",strsplit(date()," ")[[1]][4]),".csv",
                    sep = "_")
  write.csv(predeteffDF, file = csv_file, row.names=FALSE)
  return (csv_file)
}

assign_predetermined_growth_effects <- function(inputStressorScenarioName, input_file)
{
  inputPredeterminedGrowthEffectsData <<- read.csv(file = input_file, 
                                                  header = TRUE, 
                                                  stringsAsFactors = FALSE, 
                                                  check.names = FALSE)
                              
  # Add predetermined growth effects (growth_percent) data to parameter data.frame
  parameters[[inputStressorScenarioName]]$growth_percent <<- inputPredeterminedGrowthEffectsData$growth_percent
  
  # Set Growth Effect dates
  growthEffectsDates <- SetExposureDates(parameters[[inputStressorScenarioName]]$growth_percent)
  parameters[[inputStressorScenarioName]]$are_growth_effects <<- growthEffectsDates
}


store_chemicalID <- function(inputStressorScenarioName, inputChemical_id)
{
  parameters[[inputStressorScenarioName]]$chem_id <<- inputChemical_id
}

plot_survival_decrement <- function(inputStressorScenarioName)
{
  plot(-parameters[[inputStressorScenarioName]]$survival_decrement,
       main = paste("Daily Survival Decrement - ",
       parameters[[inputStressorScenarioName]]$chem_id[1], sep = ""),
       xlab = "Ordinal date",
       ylab = "Survival Decrement",
       type = "l")
}

plot_growth_percent <- function(inputStressorScenarioName)
{
  # Plot input of growth percent
  plot(x = inputPredeterminedGrowthEffectsData[,1],
       y = inputPredeterminedGrowthEffectsData[,2],
       main = paste("Daily Growth Percent - ",
       parameters[[inputStressorScenarioName]]$chem_id[1], sep = ""),
       xlab = "Ordinal date",
       ylab = "Growth Percent",
       type = "l")
}
