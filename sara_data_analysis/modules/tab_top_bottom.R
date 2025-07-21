tab_top_bottom_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "topbottom",
          fluidRow(
            column(6, h4("Top 10 Places by Mean Income"), DT::dataTableOutput(ns("top10"))),
            column(6, h4("Bottom 10 Places by Mean Income"), DT::dataTableOutput(ns("bottom10")))
          )
  )
}

tab_top_bottom_server <- function(id, data_r) {
  moduleServer(id, function(input, output, session) {
    output$top10 <- DT::renderDataTable({
      data_r() %>%
        arrange(desc(Mean)) %>%
        head(10) %>%
        DT::datatable()
    })

    output$bottom10 <- DT::renderDataTable({
      data_r() %>%
        arrange(Mean) %>%
        head(10) %>%
        DT::datatable()
    })
  })
}
