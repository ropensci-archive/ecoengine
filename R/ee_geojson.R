


#' Created geojson from an ecoengine object of type observation
#'
#' This function writes out a geojson file that can easily be imported into many maps applications or directly rendered on services like GitHub. Warning: Current behavior is to overwrite existing files in the same folder that match the filename
#' @param ee_obj object of class ecoengine
#' @param location Location where geojson file should be saved
#' @param file Name of file to be saved. Otherwise file will be named Species_map-(current_date)
#' @export
#' @importFrom assertthat assert_that
#' @importFrom sp SpatialPointsDataFrame
#' @importFrom rgdal writeOGR
#' @importFrom lubridate now
#' @examples \dontrun{
#' lynx_data <- ee_observations(genus = "Lynx", georeferenced = TRUE, quiet = TRUE, progress = FALSE)
#' ee_geojson(lynx_data, location = "~/Desktop", file = "foo")
#' # Now import this file into services like MapBox, or GitHub.
#'}
ee_geojson <- function(ee_obj, location = NULL, file = NULL) {
	assert_that(ee_obj$type == "observations")

	if(is.null(file)) {
		file <- paste0("Species_map-", ".geojson")
	} else {
		file <- paste0(file, ".geojson")
	}

	if(is.null(location)) {
		location <- tempdir()
	}
	species_data <- ee_obj$data
	species_data$latitude  <- as.numeric(species_data$latitude)
	species_data$longitude  <- as.numeric(species_data$longitude)
	speciesMap.SP  <- SpatialPointsDataFrame(species_data[,c(11,12)],species_data[,-c(11,12)])
	unlink(file)
	writeOGR(speciesMap.SP, dsn = file, layer = "speciesMap", driver='GeoJSON')
}
# [BUG]: Can't seem to specify a path correctly.
#  Also can't seem to set the option to overwrite files.