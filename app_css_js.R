# app.R
library(shiny)
# Module UI
mod_plot_ui <- function(id) {
  ns <- NS(id)
  tagList(
    # Inline CSS
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

    # Inline JS using a <script> tag
    tags$script(HTML("
      Shiny.addCustomMessageHandler('greet', function(message) {
        alert('Hello, ' + message + '!');
      });
    ")),

    h1("Modular Plot App with CSS + JS"),
    selectInput(ns("var"), "Select variable:", choices = names(mtcars)),
    actionButton(ns("go"), "Plot", class = "btn"),
    plotOutput(ns("plot"))
  )
}

# Module Server
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
      # Send JS message
      session$sendCustomMessage("greet", "Anirban")
    })
  })
}

# App UI
ui <- fluidPage(
  mod_plot_ui("main")
)

# App Server
server <- function(input, output, session) {
  mod_plot_server("main")
}

shinyApp(ui, server)
