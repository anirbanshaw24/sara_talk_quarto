# app.R

library(shiny)
# === Module UI ===
mod_plot_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(ns("var"), "Select variable:", choices = names(mtcars)),
    plotOutput(ns("plot"))
  )
}

# === Module Server ===
mod_plot_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$plot <- renderPlot({
      var <- input$var
      hist(mtcars[[var]], main = paste("Histogram of", var), col = "steelblue", border = "white")
    })
  })
}

# === App UI ===
ui <- fluidPage(
  titlePanel("Single-File Modular Shiny App"),
  sidebarLayout(
    sidebarPanel(h4("Choose variable to plot")),
    mainPanel(
      mod_plot_ui("plot1")
    )
  )
)

# === App Server ===
server <- function(input, output, session) {
  mod_plot_server("plot1")
}

# === Run App ===
shinyApp(ui, server)
