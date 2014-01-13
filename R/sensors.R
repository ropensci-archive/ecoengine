

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

# ----------------------------------------
# x <- full_sensor_list[1, ]$data_url

#' sensor data
#'
#' Request data from any of the sensors binned at various intervals
#' @param data_url The URL returned by \code{\link{ee_sensors}}
#' @param  page  Requested page. Can specify a single page (e.g. \code{1}), a range (\code{1:2}), or "all"
#' @param  page_size Default number of observations per page is 25.
#' @param  foptions Additional arugments to httr
#' @export
#' @seealso \code{\link{ee_sensors})}
#' @examples \dontrun{
#' full_sensor_list <- ee_sensors()
#' x <- full_sensor_list[1, ]$data_url
#' sensor_data <- ee_sensor_data(data_url = x, page = 1:2)
#'}
ee_sensor_data <- function(data_url = NULL, page = NULL, page_size = 25, foptions = list()) {
if(is.null(page)) {
    stop("Page has to be a range or all")
}

data_url <- paste0(data_url, "?format=json")
data <- GET(data_url)
stop_for_status(data)
data_list <- content(data)

total_obs <- data_list$count
page_size <- page_size
total_pages <- ceiling(total_obs/page_size)
req_pages <- seq_along(1:total_pages)


if(identical(class(page), "numeric") | identical(class(page), "integer")) {
    largest_page <- max(page)
    if(largest_page > total_pages) stop("One or more of the requested pages is out of range")
    total_pages <- length(page)
    req_pages <- seq_along(page)
 }

if(total_pages > 100) {
    message(sprintf("You are requesting a large number of pages (%s total). This might cause the server to stop responding. It would be wise to break up the request, either through multiple requests or via parallel execution. See help file for examples", total_pages))
}
    results <- list()
    for(i in seq_along(req_pages)) {
        args <- compact(list(page = i, page_size = page_size))
        temp_data <- GET(data_url, query = args)
        stop_for_status(temp_data)
        sensor_raw <- content(temp_data)$results
        results[[i]] <- ldply(sensor_raw, function(x) {
            cbind(data.frame(t(unlist(x[1:2]))), data.frame(t(unlist(x[3]))))
        })
    }
    final_results <- do.call(rbind, results)
    sensor_data <- list(results = total_obs, call = data_list[[2]], type = "sensor", data = final_results)
    class(sensor_data) <- "ecoengine"
    sensor_data
}




















