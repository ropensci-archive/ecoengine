
#'sensor aggregation
#'
#' Aggregated sensor_id ID of desired sensor. See \code{\link{ee_list_sensors}} for a list.
#' @template pages
#' @template dates
#' @param sensor_id The id of the sensor. 
#' @param hours Time interval in hours
#' @param minutes Time interval in minutes
#' @param seconds Time interval in seconds
#' @param days Time interval in days
#' @param weeks Time interval in weeks
#' @param month Time interval in months
#' @param years Time interval in years
#' @param quiet Default is \code{FALSE}. Set to \code{TRUE} to suppress messages.
#' @template foptions
#' @export
#' @examples \dontrun{
#' aggregated_data <-  ee_sensor_agg_get(sensor_id = 1625, weeks = 2)
#'}
ee_sensor_agg_get <- function(sensor_id = NULL, page = NULL, page_size = 25, hours = NULL, minutes = NULL, seconds = NULL, days = NULL, weeks = NULL, month = NULL, years = NULL, min_date = NULL, max_date = NULL, quiet = FALSE, foptions = list()) {

if(is.null(sensor_id)) {
	stop("Sensor ID required. use ee_list_sensors() to obtain a full list of sensors")
}

page <- ifelse(is.null(page), 1, page)
sensor_agg_url <- paste0("http://ecoengine.berkeley.edu/api/sensors/", sensor_id, "/aggregate/?format=json")
interval <- as.list(compact(c(H = hours,  T = minutes, S = seconds, D = days, W = weeks, M = month, Y = years)))
paste_names <- function(interval_name, value) { paste(interval_name, value, collapse = "", sep = "") }
interval <- llply(interval, paste_names, names(interval))
args <- as.list(compact(c(page = page, page_size = 25, min_date = min_date,  interval = interval[[1]], max_date = max_date)))
sensor_call <- GET(sensor_agg_url, query = args, foptions)
stop_for_status(sensor_call)
sensor_res <- content(sensor_call)
if(!quiet) {
	message(sprintf("Retrieving page %s (%s observations total)\n", page, sensor_res$count))
}
if(sensor_res$count == 0)
	return(NULL) else {
		sensor_res_list <- llply(sensor_res$results, function(x) {
			 lapply(x, function(z) { ifelse(is.null(z),"NA", z) })
		})
		sensor_data_agg <- do.call(rbind.data.frame, (lapply(sensor_res_list, LinearizeNestedList)))
		sensor_results <- list(results = sensor_res$count, call = sensor_res[[2]], type = "sensor", data = sensor_data_agg)
    	class(sensor_results) <- "ecoengine"
		sensor_results
		}
}
# [TODO] Now to build a function to paginate aggregate calls

#' Ecoengine sensor aggregations
#'
#'<full description>
#' @param ... all the arguments that get passed to \code{\link{ee_sensor_agg_get}}
#' @export
#' @examples \dontrun{
#' sensor_df <- ee_sensor_agg(sensor_id = 1625, weeks = 2)
#' sensor_df <- ee_sensor_agg(page = "all", sensor_id = 1625, weeks = 2)
#'}
ee_sensor_agg <- function(...) {
	ee_get(..., input_fn = ee_sensor_agg_get, dtype = "sensor")
}

#' Lists subset of the full sensor list
#'
#' @examples \dontrun{
#' ee_list_sensors()
#'}
ee_list_sensors <- function() {
data(full_sensor_list)
full_sensor_list[, c("station_name", "units", "variable", "method_name", "record")]	
}



