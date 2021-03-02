#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(writexl)
ui <- fluidPage(
    downloadButton("dl", "Download")
)

server <- function(input, output) {

    data_list <- reactive({
        list(
            Metadata = mtcars,
            Parameters = head(mtcars)
        )
    })

    output$dl <- downloadHandler(
        filename = function() {"ae.xlsx"},
        content = function(file) {write_xlsx(data_list(), path = file)}
    )
}


# Run the application
shinyApp(ui = ui, server = server)
