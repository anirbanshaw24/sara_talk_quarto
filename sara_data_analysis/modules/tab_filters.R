tab_filters_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "filters",
          fluidRow(
            column(4, selectInput(ns("state"), "State", choices = NULL, multiple = TRUE)),
            column(4, selectInput(ns("type"), "Place Type", choices = NULL, multiple = TRUE)),
            column(4, selectizeInput(ns("county"), "County", choices = NULL, multiple = TRUE, options = list(maxOptions = 10000))
)
          )
  )
}

tab_filters_server <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    updateSelectInput(session, "state", choices = unique(data$State_Name))
    updateSelectInput(session, "type", choices = unique(data$Type))

    # Server-side optimized selectize for large list
    updateSelectizeInput(session, "county", choices = unique(data$County), server = TRUE)

    reactive({
      data %>%
        filter(
          if (!is.null(input$state)) State_Name %in% input$state else TRUE,
          if (!is.null(input$type)) Type %in% input$type else TRUE,
          if (!is.null(input$county)) County %in% input$county else TRUE
        )
    })
  })
}

