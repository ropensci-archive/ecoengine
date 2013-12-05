

#' holos_sensors
#'
#' Returns UC reserve system sensor data
#' @param page page number
#' @param  remote_id Need to describe these parameters
#' @param  collection_code Type of collection. Can be \code{CalAcademy}, \code{Private}, \code{VTM}, \code{CDFA}. \code{CalFlora} Others TBA 
#' @param  source  Need to describe these parameters
#' @param  min_date Need to describe these parameters
#' @param  max_date Need to describe these parameters
#' @param foptions A list of additional arguments. Currently this function takes none.
#' @export
#' @examples \dontrun{
#' holos_sensors()
#'}
holos_sensors <- function(page = NULL, 
						remote_id = NULL, 
						collection_code = NULL, 
						source = NULL, 
						min_date = NULL, 
						max_date = NULL, 
						foptions = list()) {

sensor_url <- "http://ecoengine.berkeley.edu/api/sensors/?format=json"
    args <- as.list(compact(c(page = page,                       
                            remote_id = remote_id, 
                            collection_code = collection_code, 
                            source  = source , 
                            min_date = min_date, 
                            max_date = max_date
   							)))
    sensor_data <- GET(sensor_url, foptions)
    stop_for_status(sensor_data)
    sensor_results <- content(sensor_data)
    basic_sensor_data <- as.data.frame(do.call(rbind, sensor_results[[4]]))
    basic_sensor_data
}
holos_sensors()