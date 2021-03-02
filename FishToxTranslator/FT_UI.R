source("tabsPanel.R")

FT_UI <- fluidPage(
  useShinyjs(),
  tags$script("$(document).on('shiny:connected', function(event) {
var myWidth = $(window).width();
              Shiny.onInputChange('shiny_width',myWidth)
              
              });"),

  tags$script("$(document).on('shiny:connected', function(event) {
              var myHeight = $(window).height();
              Shiny.onInputChange('shiny_height',myHeight)
              
              });"),
  tags$head(
    tags$style(HTML("hr {border-top: 2px solid #000000;}"))
  ),
  navbarPage(title = "Fish Toxicity Translator v0.1",
             tabHome,
             tab1,
             tab2,
             tab3,
             tab4,
             id = "fish_toxicity_app"),

  tags$head(tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});')),
  tags$style(HTML(" 
        .navbar { background-color: white;}
        .navbar-default .navbar-nav > li > a {color:black;}
        .navbar-default .navbar-nav > .active > a,
        .navbar-default .navbar-nav > .active > a:focus,
        .navbar-default .navbar-nav > .active > a:hover {color: black;background-color: lightgray;}
        .navbar-default .navbar-nav > li > a:hover[data-value='About'] {color:#641be3;background-color: lightgray; text-decoration:none;}
        .navbar-default .navbar-nav > li > a:hover[data-value='Scenario Builder'] {color:#4472c4;background-color: lightgray;text-decoration:none;}
        .navbar-default .navbar-nav > li > a:hover[data-value='Visualize Built Scenario(s)'] {color: #548235;background-color: lightgray;text-decoration:none;}
        .navbar-default .navbar-nav > li > a:hover[data-value='Run Scenarios'] {color:#bc003f;background-color: lightgray;text-decoration:none;}
        .navbar-default .navbar-nav > li > a:hover[data-value='Results'] {color: black;background-color: lightgray;text-decoration:none;}
        .navbar-default .navbar-nav > li > a[data-value='About'] {color:#641be3; font-weight: bold;}
        .navbar-default .navbar-nav > li > a[data-value='Scenario Builder'] {color:#4472c4;font-weight: bold;}
        .navbar-default .navbar-nav > li > a[data-value='Visualize Built Scenario(s)'] {color: #548235;font-weight: bold;}
        .navbar-default .navbar-nav > li > a[data-value='Run Scenarios'] {color:#bc003f;font-weight: bold;}
        .navbar-default .navbar-nav > li > a[data-value='Results'] {color: black;font-weight: bold;}
                  "))
))
