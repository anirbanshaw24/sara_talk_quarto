library(shiny)
library(shinydashboard)
library(tidyverse)

source("modules/tab_filters.R")
source("modules/tab_income_summary.R")
source("modules/tab_income_distribution.R")
source("modules/tab_top_bottom.R")
source("modules/tab_income_map.R")
source("modules/utils.R")

data <- read_csv("data/income_by_location.csv")

ui <- dashboardPage(
  dashboardHeader(title = "U.S. Income Analytics"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Filters", tabName = "filters", icon = icon("filter")),
      menuItem("Income Summary", tabName = "summary", icon = icon("table")),
      menuItem("Income Distribution", tabName = "distribution", icon = icon("chart-bar")),
      menuItem("Top & Bottom Places", tabName = "topbottom", icon = icon("sort-amount-down-alt")),
      menuItem("Income Map", tabName = "map", icon = icon("map"))
    )
  ),
  dashboardBody(
    tags$head(includeCSS("www/custom.css")),
    tabItems(
      tab_filters_ui("filters"),
      tab_income_summary_ui("summary"),
      tab_income_distribution_ui("distribution"),
      tab_top_bottom_ui("topbottom"),
      tab_income_map_ui("map")
    )
  )
)

server <- function(input, output, session) {
  filtered_data <- tab_filters_server("filters", data)

  tab_income_summary_server("summary", filtered_data)
  tab_income_distribution_server("distribution", filtered_data)
  tab_top_bottom_server("topbottom", filtered_data)
  tab_income_map_server("map", filtered_data)
}

shinyApp(ui, server)
