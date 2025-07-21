tab_income_distribution_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "distribution",
          fluidRow(
            column(6, plotOutput(ns("mean_income_plot"))),
            column(6, plotOutput(ns("median_income_plot")))
          )
  )
}

tab_income_distribution_server <- function(id, data_r) {
  moduleServer(id, function(input, output, session) {
    output$mean_income_plot <- renderPlot({
      ggplot(data_r(), aes(x = Mean)) +
        geom_histogram(bins = 30, fill = "#2C3E50", color = "white") +
        labs(title = "Distribution of Mean Income") +
        theme_minimal()
    })

    output$median_income_plot <- renderPlot({
      ggplot(data_r(), aes(x = Median)) +
        geom_histogram(bins = 30, fill = "#3498DB", color = "white") +
        labs(title = "Distribution of Median Income") +
        theme_minimal()
    })
  })
}
