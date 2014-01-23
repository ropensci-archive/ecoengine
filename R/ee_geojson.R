


#' Created geojson from an ecoengine object of type observation
#'
#' This function writes out a geojson file that can easily be imported into many maps applications or directly rendered on services like GitHub. Warning: Current behavior is to overwrite existing files in the same folder that match the filename
#' @param ee_obj object of class ecoengine
#' @param dest Location where geojson file should be saved
#' @param name Name of file to be saved. Otherwise file will be named Species_map-(current_date)
#' @export
#' @importFrom assertthat assert_that
#' @importFrom leafletR toGeoJSON
#' @examples \dontrun{
#' lynx_data <- ee_observations(genus = "Lynx", georeferenced = TRUE, quiet = TRUE, progress = FALSE)
#' ee_geojson(lynx_data, dest = "~/Desktop", name = "foo")
#' ee_geojson(lynx_data,  name = "foo")
#' # Now import this file into services like MapBox, or GitHub.
#'}
ee_geojson <- function(ee_obj, dest = NULL, name = NULL) {
	assert_that(ee_obj$type == "observations")
	name <- ifelse(is.null(name), "ee_geojson", name)
	dest <- ifelse(is.null(dest), tempdir(), dest)
	species_data <- ee_obj$data
	toGeoJSON(data = species_data, name = name, dest = dest, lat.lon=c(12, 11))	
}

