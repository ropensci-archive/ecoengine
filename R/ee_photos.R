#' ee_photos
#'
#' Search the photos methods in the Holos API. 
#' @template pages
#' @param  state_province Need to describe these parameters
#' @param  county California counties. Package include a full list of counties. To load dataset \code{data(california_counties)}
#' @param  genus genus name
#' @param  scientific_name scientiifc name
#' @param  authors author name
#' @param  remote_id remote id
#' @param  collection_code Type of collection. Can be \code{CalAcademy}, \code{Private}, \code{VTM}, \code{CDFA}. \code{CalFlora} Others TBA 
#' @param  source data source. See \code{\link{ee_sources}}
#' @template dates
#' @param  related_type Need to describe these parameters
#' @param  related  Need to describe these parameters
#' @param  other_catalog_numbers Need to describe these parameters
#' @param  quiet Default is \code{FALSE}. Set to \code{TRUE} to suppress messages.
#' @template foptions
#' @export
#' @importFrom httr stop_for_status content GET
#' @importFrom plyr compact rbind.fill
#' @importFrom lubridate ymd_hms
#' @seealso related: \code{\link{ee_photos_get}} \code{\link{california_counties}}
#' @examples \dontrun{
#' # Request all photos. This request will paginate. Don't use ee_photos_get #' on such a large request
#' ee_photos_get()
#' # Search by collection code. See notes above on options
#' ee_photos_get(collection_code = "CalAcademy")
#' ee_photos_get(collection_code = "VTM")
#' ee_photos_get(collection_code = "CalFlora")
#' ee_photos_get(collection_code = "CDFA")
#' # Search by county.
#' ee_photos_get(county = "Santa Clara County")
#' ee_photos_get(county = "Merced County")
#' # The package also contains a full list of counties
#' data(california_counties)
#' alameda <- ee_photos(county = california_counties[1, 1])
#' alameda$data
#' # You can also get all the data for Alameda county with one request
#' alameda <- ee_photos(county = "Alameda county", page = "all")
#' # Spidering through the rest of the counties can easily be automated.
#' # Or by author
#' charles_results <- ee_photos(author = "Charles Webber", page = 1:2)
#' # You can also request all pages in a single call by using ee_photos()
#' # In this example below, there are 6 pages of results (52 result items). 
#' Function will return all at once.
#' racoons <- ee_photos(scientific_name = "Procyon lotor", page = "all")
#'}
ee_photos <- function(page = NULL, 
						 state_province = NULL, 
						 county = NULL, 
						 genus = NULL, 
						 scientific_name = NULL, 
						 authors = NULL, 
						 remote_id = NULL, 
						 collection_code = NULL, 
						 source  = NULL, 
						 min_date = NULL, 
						 max_date = NULL, 
						 related_type = NULL, 
						 related  = NULL,
						 page_size = 25,
						 quiet = FALSE,
						 other_catalog_numbers = NULL, 
						 foptions = list()) {
	photos_url <- "http://ecoengine.berkeley.edu/api/photos/?format=json"
	args <- as.list(compact(c(page = page, 	
							page_size = page_size,					 
							state_province = state_province, 
						 	county = county, 
						 	genus = genus, 
						 	scientific_name = scientific_name, 
						 	authors = authors, 
						 	remote_id = remote_id, 
						 	collection_code = collection_code, 
						 	source  = source , 
						 	min_date = min_date, 
						 	max_date = max_date, 
						 	related_type = related_type, 
						 	related  = related , 
						 	other_catalog_numbers = other_catalog_numbers)))
	args$page <- NULL
	data_sources <- GET(photos_url, query = args, foptions)
    stop_for_status(data_sources)
    photos <- content(data_sources)
    if(is.null(page)) { page <- 1 }
	required_pages <- ee_paginator(page, photos$count)
    

     if(!quiet) {
    message(sprintf("Search contains %s photos (downloading %s of %s pages)", photos$count, length(required_pages), max(required_pages)))
	}

    
    results <- list()
    for(i in required_pages) {
    	args$page <- i 
    	data_sources <- GET(photos_url, query = args, foptions)
    	photos <- content(data_sources)
    	photos_data <- do.call(rbind.fill, lapply(photos[[4]], rbindfillnull))
    	results[[i]] <- photos_data
    	if(i %% 25 == 0) Sys.sleep(2) 
    }
    
    browser()

	photos_data <- do.call(rbind.fill, results)
	photos_data$begin_date <- suppressWarnings(ymd_hms(photos_data$begin_date))
	photos_data$end_date <- suppressWarnings(ymd_hms(photos_data$end_date))
	photos[[2]] <- ifelse(is.null(photos[[2]]),"NA", photos[[2]])
    photos_results <- list(results = photos$count, call = photos[[2]], type = "photos", data = photos_data)
    class(photos_results) <- "ecoengine"
    return(photos_results)
}


    ee_paginator <- function(page, total_obs) {
    	all_pages <- ceiling(total_obs/25)
    	if(total_obs < 25) { req_pages <- 1 }
    	if(identical(page, "all")) { req_pages <- seq_along(1: all_pages)}
    	if(length(page) == 1 & identical(class(page), "numeric")) { req_pages <- page }
    	if(identical(class(page), "integer")) {
    		if(max(page) > all_pages) {
    			stop("Pages requested outside the range")
    		} else {
    			req_pages <- page
    		}
    	}

  		req_pages
    }





#' @noRd
# Internal function to convert list to data.frame when it contains NULL
rbindfillnull <- function(x) {
  x <- unlist(x)
  x[is.null(x)] <- "none"
  data.frame(as.list(x), stringsAsFactors = FALSE)
}



					