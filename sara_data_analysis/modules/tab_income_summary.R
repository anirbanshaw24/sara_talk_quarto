tab_income_summary_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "summary",
          fluidRow(
            valueBoxOutput(ns("avg_income")),
            valueBoxOutput(ns("med_income")),
            valueBoxOutput(ns("income_sd"))
          ),
          fluidRow(
            valueBoxOutput(ns("total_weighted")),
            valueBoxOutput(ns("n_places")),
            valueBoxOutput(ns("range_income"))
          ),
          DT::dataTableOutput(ns("table"))
  )
}

tab_income_summary_server <- function(id, data_r) {
  moduleServer(id, function(input, output, session) {
    output$avg_income <- renderValueBox({
      valueBox(round(mean(data_r()$Mean, na.rm = TRUE)), "Average Income", icon = icon("dollar-sign"), color = "green")
    })

    output$med_income <- renderValueBox({
      valueBox(round(median(data_r()$Median, na.rm = TRUE)), "Median Income", icon = icon("balance-scale"), color = "blue")
    })

    output$income_sd <- renderValueBox({
      valueBox(round(sd(data_r()$Mean, na.rm = TRUE)), "Income Std Dev", icon = icon("chart-line"), color = "yellow")
    })

    output$total_weighted <- renderValueBox({
      valueBox(round(sum(data_r()$sum_w, na.rm = TRUE)), "Total Weighted Sum", icon = icon("calculator"), color = "purple")
    })

    output$n_places <- renderValueBox({
      valueBox(nrow(data_r()), "Number of Places", icon = icon("map-marker-alt"), color = "teal")
    })

    output$range_income <- renderValueBox({
      range_val <- range(data_r()$Mean, na.rm = TRUE)
      valueBox(paste0(range_val[1], " - ", range_val[2]), "Income Range", icon = icon("arrows-alt-h"), color = "red")
    })

    output$table <- DT::renderDataTable({
      DT::datatable(data_r())
    })
  })
}
