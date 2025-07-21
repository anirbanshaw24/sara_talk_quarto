# app.R

library(shiny)

ui <- fluidPage(
  titlePanel("Single-File Shiny App (No Modules)"),

  sidebarLayout(
    sidebarPanel(
      h4("Choose variable to plot"),
      selectInput("var", "Select variable:", choices = names(mtcars))
    ),

    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    var <- input$var
    hist(mtcars[[var]], main = paste("Histogram of", var), col = "steelblue", border = "white")
  })
}

shinyApp(ui, server)
