tab_income_map_ui <- function(id) {
  ns <- NS(id)
  tabItem(
    tabName = "map",
    tags$style(HTML("
      #map-ui-map {
        position: fixed !important;
        top: 60px;
        left: 0;
        right: 0;
        bottom: 0;
        z-index: 1000;
      }
    ")),
    leaflet::leafletOutput(ns("map"), height = "100vh")
  )
}


tab_income_map_server <- function(id, data_r) {
  moduleServer(id, function(input, output, session) {
    output$map <- leaflet::renderLeaflet({
      df <- data_r() %>%
        filter(!is.na(Lat), !is.na(Lon), !is.na(Median), !is.na(Mean))

      # Color palette: red (low mean) → green (high mean)
      pal <- colorNumeric(
        palette = "viridis",
        domain = df$Mean,
        na.color = "gray"
      )

      leaflet(df) %>%
        addProviderTiles(providers$CartoDB.Positron) %>%
        addCircleMarkers(
          lng = ~Lon,
          lat = ~Lat,
          radius = ~scales::rescale(Median, to = c(3, 15)),
          color = ~pal(Mean),
          stroke = TRUE,
          fillOpacity = 0.8,
          label = ~paste0(City, ", ", State_ab),
          popup = ~paste0(
            "<b>", City, ", ", State_Name, "</b><br>",
            "<b>County:</b> ", County, "<br>",
            "<b>Zip Code:</b> ", Zip_Code, "<br><br>",
            "<b>Mean Income:</b> $", formatC(Mean, format = "f", big.mark = ",", digits = 0), "<br>",
            "<b>Median Income:</b> $", formatC(Median, format = "f", big.mark = ",", digits = 0), "<br>",
            "<b>Stdev:</b> $", formatC(Stdev, format = "f", big.mark = ",", digits = 0), "<br>",
            "<b>Weighted Sum:</b> ", formatC(sum_w, format = "f", big.mark = ",", digits = 1), "<br><br>",
            "<b>Land Area:</b> ", formatC(ALand, big.mark = ","), " m²<br>",
            "<b>Water Area:</b> ", formatC(AWater, big.mark = ","), " m²"
          )
        ) %>%
        addLegend(
          position = "bottomright",
          pal = pal,
          values = ~Mean,
          title = "Mean Income ($)",
          labFormat = labelFormat(prefix = "$"),
          opacity = 1
        )
    })
  })
}

