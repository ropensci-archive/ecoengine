

#' ee_sensors
#'
#' Returns UC reserve system sensor data
#' @template pages
#' @param  remote_id Need to describe these parameters
#' @param  collection_code Type of collection. Can be \code{CalAcademy}, \code{Private}, \code{VTM}, \code{CDFA}. \code{CalFlora} Others TBA 
#' @param  source  Need to describe these parameters
#' @template dates
#' @template foptions
#' @export
#' @examples  
#' # Currently there are only 40 sensors, so request only needs to be pages 1 and 2.
#' ee_sensors()
#' all_sensors <- ee_sensors()
ee_sensors <- function(page = NULL, 
                        page_size = 25,
						remote_id = NULL, 
						collection_code = NULL, 
						source = NULL, 
						min_date = NULL, 
						max_date = NULL,
						foptions = list()) {
sensor_url <- "http://ecoengine.berkeley.edu/api/sensors/?format=json"
    args <- ee_compact(list(page = page,
                              page_size = page_size,                       
                            remote_id = remote_id, 
                            collection_code = collection_code, 
                            source  = source, 
                            min_date = min_date, 
                            max_date = max_date
   							))
    args$page <- NULL
    sensor_data <- GET(sensor_url, query = args, foptions)
    warn_for_status(sensor_data)
    sensor_results <- content(sensor_data)
    if(is.null(page)) { page <- 1 }
    required_pages <- ee_paginator(page, sensor_results$count)
    

      results <- list()
    for(i in required_pages) {
        args$page <- i 
            basic_sensor_data <- ldply(sensor_results$results, function(x) {
                             geo_data <- data.frame(t(unlist(x[5])))
                             main_data <- (x[-5])
                             main_data$end_date <- ifelse(is.null(main_data$end_date), "NA", main_data$end_date)
                             md <-(data.frame(as.list(main_data)))        
                             cbind(md, geo_data)
                            })

        results[[i]] <- basic_sensor_data
    }

    res <- do.call(rbind, results)
    res$record <- as.integer(res$record)
    res$geojson.coordinates1 <- as.numeric(res$geojson.coordinates1)
    res$geojson.coordinates2 <- as.numeric(res$geojson.coordinates2)
    res$begin_date <- ymd_hms(res$begin_date)
    # Suppressing warnings here because we can't coerce NULLs into Date format
    res$end_date <- suppressWarnings(ymd_hms(res$end_date))
    res
  
}


#' Sensor data 
#'
#' Retrieves data for any sensor returned by \code{\link{ee_list_sensors}}.
#' @param sensor_id The id of the sensor. 
#' @template pages
#' @param  quiet Default is \code{FALSE}. Set to \code{TRUE} to suppress output.
#' @template progress
#' @template foptions
#' @importFrom utils txtProgressBar setTxtProgressBar
#' @export
#' @examples \dontrun{
#' full_sensor_list <- ee_sensors()
#' station <- ee_list_sensors()$record
#' page_1_data <- ee_sensor_data(sensor_id = station[1], page = 1)
#' page_2_data <- ee_sensor_data(station[1], page = 1:3)
#'}
ee_sensor_data <- function(sensor_id = NULL, page = NULL, page_size = 25, quiet = FALSE, progress = TRUE, foptions = list()) {

    data_url <- paste0("http://ecoengine.berkeley.edu/api/sensors/", sensor_id, "/data?format=json")
    args <- ee_compact(list(page_size = page_size))
    main_args <- args
    if(is.null(page)) { page <- 1 }
    main_args$page <- as.character(page)
    temp_data <- GET(data_url, query = args)
    warn_for_status(temp_data)
    sensor_raw <- content(temp_data)

    required_pages <- ee_paginator(page, sensor_raw$count)
    total_p <- ceiling(sensor_raw$count/page_size)

    if(!quiet) {
    message(sprintf("Search contains %s records (downloading %s page(s) of %s)", sensor_raw$count, length(required_pages), total_p))
    }

    if(progress) pb <- txtProgressBar(min = 0, max = length(required_pages), style = 3)

    results <- list()
    for(i in required_pages) {
        args$page <- i 
        temp_data <- GET(data_url, query = args)
        sensor_iterate <- content(temp_data)$results
        if(!is.null(sensor_iterate)) {
        raw_data <- do.call(rbind.data.frame, lapply(sensor_iterate, LinearizeNestedList))
        names(raw_data) <- c("local_date", "value", "data_quality_qualifierid", "data_quality_qualifier_description", "data_quality_valid")
        raw_data$local_date <- suppressWarnings(ymd_hms(raw_data$local_date))
        } else {
            raw_data <- NULL
        }
        
        results[[i]] <- raw_data
     if(progress) setTxtProgressBar(pb, i)
     if(i %% 25 == 0) Sys.sleep(2) 
    }

    results_data <- ldply(ee_compact(results))
    sensor_data <- list(results = sensor_raw$count, call = main_args, type = "sensor", data = results_data)
    class(sensor_data) <- "ecoengine"
    if(progress) close(pb)    
    sensor_data
}




#' Lists subset of the full sensor list
#'
#' @export
#' @examples \dontrun{
#' ee_list_sensors()
#'}
ee_list_sensors <- function() {
full_sensor_list[, c("station_name", "units", "variable", "method_name", "record")] 
}


















