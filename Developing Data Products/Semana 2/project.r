library(leaflet)
df <- read.csv("capitais.csv")
df %>% leaflet() %>%
  addTiles() %>%
  addMarkers(
    lat = df$lat, 
    lng = df$long, 
    popup = paste(df$popup, "<br>", "Population:", df$population),
    clusterOptions = markerClusterOptions()) %>%
  addCircleMarkers(radius = sqrt(df$population/10e3))
