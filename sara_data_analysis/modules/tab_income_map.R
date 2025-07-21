tab_income_map_ui <- function(id) {
  ns <- NS(id)
  tabItem(tabName = "map",
          leaflet::leafletOutput(ns("map"), height = 600)
  )
}

tab_income_map_server <- function(id, data_r) {
  moduleServer(id, function(input, output, session) {
    output$map <- leaflet::renderLeaflet({
      leaflet::leaflet(data_r()) %>%
        leaflet::addTiles() %>%
        leaflet::addCircleMarkers(
          ~Lon, ~Lat,
          popup = ~paste0("<b>", City, "</b><br>Mean: $", Mean, "<br>Median: $", Median),
          radius = ~scales::rescale(Mean, to = c(3, 10)),
          color = ~ifelse(Mean > median(data_r()$Mean, na.rm = TRUE), "green", "red"),
          stroke = FALSE, fillOpacity = 0.6
        )
    })
  })
}
