output$tab1_worldmap_leaflet <- renderLeaflet({
  
  world_map_palette <- colorBin(
    c(brewer.pal(length(
      pretty(
        shapefiles_participating_countries$standardized_report_per_round
      ) - 1
    ), "YlGnBu")),
    bins = pretty(
      shapefiles_participating_countries$standardized_report_per_round
    ),
    pretty = TRUE
  )
  
  
  world_map_label <- function(country, st_report_per_round) {
    paste("Country: ", country)
  }
  
  world_map_popup <- function(country, st_report_per_round){
    paste(
      "Country:", country,
      "<br>",
      "Standardised report:",round(st_report_per_round,2)
    )
  }
  
  map <- shapefiles_participating_countries %>%
    leaflet() %>%
    # addTiles() %>%
    addProviderTiles(providers$CartoDB.PositronNoLabels, options = leafletOptions(worldCopyJump = FALSE)) %>%
    addPolygons(
      fillColor = ~ world_map_palette(standardized_report_per_round),
      popup = ~ world_map_popup(country, standardized_report_per_round),
      label = ~ world_map_label(country, standardized_report_per_round),
      weight = 1
    ) %>%
    addLegend(
      pal = world_map_palette,
      values = ~standardized_report_per_round,
      opacity = 0.6,
      ##transparency again
      title = "Standardized report per round"
    )
  
  hide("loading-tab1_worldmap")
  
  map
  
})




