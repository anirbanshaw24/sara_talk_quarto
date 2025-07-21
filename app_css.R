# app.R
library(shiny)
# Define module UI
mod_plot_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$style(HTML("
      h1 {
        color: darkblue;
        font-size: 2em;
      }
      .btn {
        background-color: #4CAF50;
        color: white;
      }
    ")),
    h1("Modular Plot App with Inline CSS"),
    selectInput(ns("var"), "Select variable:", choices = names(mtcars)),
    actionButton(ns("go"), "Plot", class = "btn"),
    plotOutput(ns("plot"))
  )
}

mod_plot_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$go, {
      output$plot <- renderPlot({
        var <- input$var
        hist(mtcars[[var]],
             main = paste("Histogram of", var),
             col = "steelblue",
             border = "white")
      })
    })
  })
}

# Main app UI
ui <- fluidPage(
  mod_plot_ui("main")
)

# Main app server
server <- function(input, output, session) {
  mod_plot_server("main")
}

shinyApp(ui, server)
