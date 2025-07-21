tab_summary_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "summary",
          fluidRow(
            valueBoxOutput(ns("n_places")),
            valueBoxOutput(ns("mean_population")),
            valueBoxOutput(ns("total_water"))
          ),
          DT::dataTableOutput(ns("table"))
  )
}

tab_summary_server <- function(id, data_r) {
  moduleServer(id, function(input, output, session) {
    output$n_places <- renderValueBox({
      valueBox(nrow(data_r()), "Total Places", icon = icon("city"), color = "blue")
    })

    output$mean_population <- renderValueBox({
      valueBox(round(mean(data_r()$Mean, na.rm = TRUE), 0), "Mean Value", icon = icon("users"), color = "green")
    })

    output$total_water <- renderValueBox({
      valueBox(format(sum(data_r()$AWater, na.rm = TRUE), big.mark = ","), "Total Water Area", icon = icon("water"), color = "teal")
    })

    output$table <- DT::renderDataTable({
      DT::datatable(data_r())
    })
  })
}
