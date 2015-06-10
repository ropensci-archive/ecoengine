#' Experimental leaflet map from mapbox
#'
#' @noRd
#' @export
#' @importFrom dplyr count select filter mutate arrange left_join
#' @importFrom RColorBrewer brewer.pal
#' @examples \dontrun{
#' ee_observations(genus = "vulpes", georeferenced = TRUE) %>%  ee_maps
#' }
ee_maps <- function(eco, htmlfile = "index.html") {
df <- eco$data
unique_species <- df %>%
count(scientific_name) %>%
arrange(desc(n))

cols <- colorRampPalette(RColorBrewer::brewer.pal(11, "Spectral"))
colors <- cols(nrow(unique_species))
unique_species$marker_color <- colors
# Remove all the extra fields and only keep what goes in the geoJSON
filtered_df <- left_join(df, unique_species, by = "scientific_name")
filtered_df <- filtered_df %>%
  select("title" = scientific_name,
  	"description" = begin_date,
  	"marker-color" = marker_color,  # THis is for mapbox
  	 "url" = url,
  	 latitude,
  	 longitude)
# Soon I should add other mapbox options here
filtered_df$`marker-size` <- "small"

filtered_df <- filtered_df %>% mutate(description = sprintf("Collected on %s", description))
pos <- c(which(names(filtered_df) == "latitude"), which(names(filtered_df) == "longitude"))
leafletR::toGeoJSON(filtered_df, lat.lon = pos, name = "points", overwrite = TRUE)

file.create(htmlfile)
file1 <- system.file("index0.html", package = "ecoengine")
points <- "points.geojson"
file2 <- system.file("index1.html", package = "ecoengine")
fileConn <- file(htmlfile)
writeLines(c(readLines(file1), readLines(points), readLines(file2)), fileConn)
close(fileConn)
browseURL(htmlfile)
}
