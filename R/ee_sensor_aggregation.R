
#'sensor aggregation
#'
#' Aggregated sensor data for any station.
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
#' @template progress
#' @template foptions
#' @importFrom lubridate ymd_hms
#' @importFrom utils txtProgressBar setTxtProgressBar
#' @export
#' @examples 
#' aggregated_data <-  ee_sensor_agg(sensor_id = 1625, weeks = 2, page = 1)
#' # aggregated_data <-  ee_sensor_agg(sensor_id = 1625, weeks = 2, page = "all")

ee_sensor_agg <- function(sensor_id = NULL, page = NULL, page_size = 25, hours = NULL, minutes = NULL, seconds = NULL, days = NULL, weeks = NULL, month = NULL, years = NULL, min_date = NULL, max_date = NULL, quiet = FALSE, progress = TRUE, foptions = list()) {

if(is.null(sensor_id)) {
	stop("Sensor ID required. use ee_list_sensors() to obtain a full list of sensors")
}

sensor_agg_url <- paste0("http://ecoengine.berkeley.edu/api/sensors/", sensor_id, "/aggregate/?format=json")
interval <- as.list(ee_compact(c(H = hours,  T = minutes, S = seconds, D = days, W = weeks, M = month, Y = years)))
paste_names <- function(interval_name, value) { paste(interval_name, value, collapse = "", sep = "") }
interval <- lapply(interval, paste_names, names(interval))
args <- as.list(ee_compact(c(page_size = 25, min_date = min_date,  interval = interval[[1]], max_date = max_date)))
if(is.null(page)) { page <- 1 }
main_args <- args
main_args$page <- as.character(page)
sensor_call <- GET(sensor_agg_url, query = args, foptions)
warn_for_status(sensor_call)
sensor_res <- content(sensor_call)

if(sensor_res$count == 0) {
	return(NULL)
}
required_pages <- ee_paginator(page, sensor_res$count)
total_p <- ceiling(sensor_res$count/page_size)

if(!quiet) {
message(sprintf("Search contains %s records (downloading %s page(s) of %s)", sensor_res$count, length(required_pages), total_p))
}

if(progress) pb <- txtProgressBar(min = 0, max = length(required_pages), style = 3)

   results <- list()
    for(i in required_pages) {
        args$page <- i 
        temp_data <- GET(sensor_agg_url, query = args)
        sensor_aggs <- content(temp_data)$results	
		sensor_res_list <- lapply(sensor_aggs, function(x) {
			 lapply(x, function(z) { ifelse(is.null(z),"NA", z) })
		})
		sensor_data_agg <- do.call(rbind.data.frame, (lapply(sensor_res_list, LinearizeNestedList)))
		sensor_data_agg$begin_date <- ymd_hms(sensor_data_agg$begin_date)
		results[[i]] <- sensor_data_agg
		if(progress) setTxtProgressBar(pb, i)
    }
		
	sensor_data_agg <- do.call(rbind, results)
	sensor_results <- list(results = sensor_res$count, call = main_args, type = "sensor", data = sensor_data_agg)
    class(sensor_results) <- "ecoengine"
    if(progress) close(pb)    
	sensor_results
}






