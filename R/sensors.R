

#' ee_sensors
#'
#' Returns UC reserve system sensor data
#' @param page page number
#' @param page_size Number of observations per page
#' @param  remote_id Need to describe these parameters
#' @param  collection_code Type of collection. Can be \code{CalAcademy}, \code{Private}, \code{VTM}, \code{CDFA}. \code{CalFlora} Others TBA 
#' @param  source  Need to describe these parameters
#' @param  min_date Need to describe these parameters
#' @param  max_date Need to describe these parameters
#' @param foptions A list of additional arguments. Currently this function takes none.
#' @export
#' @examples \dontrun{
#' ee_sensors_get()
#' ee_sensors_get(page = 40)
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
    basic_sensor_data <- as.data.frame(do.call(rbind, sensor_results[[4]]))
    basic_sensor_data
}


#' ee sensors
#'
#'Returns a full list of sensors with available data
#' @param ... same arguments as \code{\link{ee_sensors}}
#' @param page_size Number of observations per page
#' @export
#' @return data.frame
#' @examples \dontrun{
#' # This call will return a full set of available sensors.
#' full_sensor_list <- ee_sensors()
#'}
ee_sensors <- function(..., page_size = 25) {
    x <- content(GET("http://ecoengine.berkeley.edu/api/sensors/?format=json"))
    total_results <- x$count
    all_available_pages <- ceiling(total_results/page_size) 
    all_results <- list()       
    for(i in seq(all_available_pages)) {
        all_results[[i]] <- ee_sensors_get(page = i, page_size = page_size)
    }
    return(ldply(all_results))
}
