

#' ee_sensors_get
#'
#' Returns UC reserve system sensor data
#' @template pages
#' @param  remote_id Need to describe these parameters
#' @param  collection_code Type of collection. Can be \code{CalAcademy}, \code{Private}, \code{VTM}, \code{CDFA}. \code{CalFlora} Others TBA 
#' @param  source  Need to describe these parameters
#' @param  min_date Need to describe these parameters
#' @param  max_date Need to describe these parameters
#' @template foptions
#' @export
#' @examples \dontrun{
#' ee_sensors_get()
#'}
ee_sensors_get <- function(page = NULL, 
                        page_size = 25,
						remote_id = NULL, 
						collection_code = NULL, 
						source = NULL, 
						min_date = NULL, 
						max_date = NULL, 
						foptions = list()) {

sensor_url <- "http://ecoengine.berkeley.edu/api/sensors/?format=json"
    args <- as.list(compact(c(page = page,
                              page_size = page_size,                       
                            remote_id = remote_id, 
                            collection_code = collection_code, 
                            source  = source , 
                            min_date = min_date, 
                            max_date = max_date
   							)))
    sensor_data <- GET(sensor_url, query = args, foptions)
    stop_for_status(sensor_data)
    sensor_results <- content(sensor_data)
    basic_sensor_data <- ldply(sensor_results$results, function(x) {
                             geo_data <- data.frame(t(unlist(x[5])))
                             main_data <- (x[-5])
                             main_data$end_date <- ifelse(is.null(main_data$end_date), "NA", main_data$end_date)
                             md <-(data.frame(as.list(main_data)))        
                             res <- cbind(md, geo_data)
                            })
}
# [BUG] the geojson is not correctly flattened


#' ee sensors
#'
#'Returns a full list of sensors with available data
#' @param ... same arguments as \code{\link{ee_sensors}}. Use this function over ee_sensors_get. 
#' @param page_size Number of observations per page
#' @importFrom lubridate ymd_hms
#' @export
#' @return data.frame
#' @examples \dontrun{
#' # This call will return a full set of available sensors.
#' full_sensor_list <- ee_sensors()
#'}
ee_sensors <- function(..., page_size = 25) {
    sensor_request <- content(GET("http://ecoengine.berkeley.edu/api/sensors/?format=json"))
    total_results <- sensor_request$count
    all_available_pages <- ceiling(total_results/page_size) 
    all_results <- list()       
    for(i in seq(all_available_pages)) {
        all_results[[i]] <- ee_sensors_get(page = i, page_size = page_size)
    }

    res <- ldply(all_results)
    res$record <- as.integer(res$record)
    res$geojson.coordinates1 <- as.numeric(res$geojson.coordinates1)
    res$geojson.coordinates2 <- as.numeric(res$geojson.coordinates2)
    res$begin_date <- ymd_hms(res$begin_date)
    # Suppressing warnings here because we can't coerce NULLs into Data format
    res$end_date <- suppressWarnings(ymd_hms(res$end_date))
    res
}


#' Sensor data get
#'
#' Retrieves data for any sensor returned by \code{\link{ee_sensors}}.
#' @param data_url The URL returned by \code{\link{ee_sensors}}
#' @template pages
#' @param  quiet Default is \code{FALSE}. Set to \code{TRUE} to suppress output.
#' @template foptions
#' @export
#' @examples \dontrun{
#' full_sensor_list <- ee_sensors()
#' x <- full_sensor_list[1, ]$data_url
#' z <- ee_sensor_data_get(x, page = 2)
#' z1 <- ee_sensor_data_get(x, page = 3)
#'}
ee_sensor_data_get <- function(data_url = NULL, page = NULL, page_size = 25, quiet = FALSE, foptions = list()) {

    if(length(page) > 1) {
            stop("Please supply only one page at a time. See ee_sensor_data for pagination.")
            }
    data_url <- paste0(data_url, "?format=json")
    data <- GET(data_url)
    stop_for_status(data)
    data_list <- content(data)
    total_obs <- data_list$count
    if(!quiet) {
    message(sprintf("Search returned %s photos (downloading page %s of %s)", total_obs, page, ceiling(total_obs/page_size)))
    }
    args <- compact(list(page = page, page_size = page_size))
    temp_data <- GET(data_url, query = args)
    stop_for_status(temp_data)
    sensor_raw <- content(temp_data)$results
    results <- do.call(rbind.data.frame, lapply(sensor_raw, LinearizeNestedList))
    sensor_data <- list(results = total_obs, call = data_list[[2]], type = "sensor", data = results)
    class(sensor_data) <- "ecoengine"
    sensor_data
}


#' sensor data
#'
#' @param ... All argument that get passed to \code{\link{ee_sensor_data_get}}
#' This function is a wrapper around \code{\link{ee_sensor_data_get}}. Allows a user to request several pages worth of data.
#' @export
#' @seealso \code{\link{ee_sensors})}
#' @examples \dontrun{
#' full_sensor_list <- ee_sensors()
#' x <- full_sensor_list[1, ]$data_url
#' sensor_data <- ee_sensor_data(data_url = x,  page = 1:2)
#' sensor_data_3 <- ee_sensor_data(data_url = x,  page = 1)
#'}
ee_sensor_data <- function(...) {
    ee_get(..., input_fn = ee_sensor_data_get, dtype = "sensor")
}




















