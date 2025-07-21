tab_distribution_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "distribution",
          fluidRow(
            selectInput(ns("column"), "Select Numeric Column", choices = NULL),
            plotOutput(ns("histogram"))
          )
  )
}

tab_distribution_server <- function(id, data_r) {
  moduleServer(id, function(input, output, session) {
    observe({
      updateSelectInput(session, "column", choices = names(data_r()[, sapply(data_r(), is.numeric)]))
    })

    output$histogram <- renderPlot({
      req(input$column)
      ggplot(data_r(), aes_string(input$column)) +
        geom_histogram(bins = 30, fill = "steelblue", color = "white") +
        theme_minimal()
    })
  })
}
