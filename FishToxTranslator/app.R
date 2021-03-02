# Welcome to the Fish Toxicity Translator R Shiny GUI App
# If you have any problems running this code - contact Nate Pollesch (pollesch.nathan@epa.gov)

# Install and load all necessary packages from CRAN/Bioconductor
rm(list = ls())
# This package manager makes installing and running other packages easier
# install.packages("pacman") # This line can be commented out after it is installed once.
library(pacman)
# This command loads all the necssary packages for the app and the FishToxTranslator
pacman::p_load("shiny","shinyjs","plotly","lubridate",
               "readr","DT","shinyWidgets","shinydashboard",
               "shinyBS","purrr","stringr", "Matrix",
               "statmod", "truncnorm", "tibble", "plot.matrix",
               "shinybusy", "readxl", "writexl")

# This command installs and loads the FishToxTranslator Package from the local tar.gz file
# install.packages("FishToxTranslator_0.1.11.tar.gz",type="source")
library(FishToxTranslator)

# This loads the local App Source Files
source("Initialize_Lists.R")
source("Baseline_Tab_Functions_Server.R")
source("Stressor_Tab_Functions_Server.R")
source("DeleteScenario_Tab_Functions_Server.R")
source("DeleteResults_Tab_Functions_Server.R")
source("ImportScenario_Tab_Functions_Server.R")
source("ImportResults_Tab_Functions_Server.R")
source("Visualize_Tab_Functions_Server.R")
source("Run_Tab_Functions_Server.R")
source("Results_Tab_Functions_Server.R")
source("widgets.R")
source("FT_UI.R", local = TRUE)
source("FT_Server.R")

# This runs the Shiny App!
shinyApp(ui <- FT_UI, server <- FT_Server)

