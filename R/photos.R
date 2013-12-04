#' holos photos
#'
#' Search the photos methods in the Holos API. 
#' @param page page number
#' @param  state_province Need to describe these parameters
#' @param  county See \href{http://en.wikipedia.org/wiki/List_of_counties_in_California}{full list of California counties}
#' @param  genus Need to describe these parameters
#' @param  scientific_name Need to describe these parameters
#' @param  authors Need to describe these parameters
#' @param  remote_id Need to describe these parameters
#' @param  collection_code Type of collection. Can be \code{CalAcademy}, \code{Private}, \code{VTM}, \code{CDFA}. \code{CalFlora} Others TBA 
#' @param  source  Need to describe these parameters
#' @param  min_date Need to describe these parameters
#' @param  max_date Need to describe these parameters
#' @param  related_type Need to describe these parameters
#' @param  related  Need to describe these parameters
#' @param  other_catalog_numbers Need to describe these parameters
#' @param  foptions = list() Other options to pass to curl
#' @export
#' @importFrom httr stop_for_status content GET
#' @importFrom plyr compact
#' @examples \dontrun{
#' holos_photos()
#'}
holos_photos <- function(page = NULL, 
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
						 other_catalog_numbers = NULL, 
						 foptions = list()) {
						 # function isn't ready.	

	photos_url <- "http://ecoengine.berkeley.edu/api/photos/?format=json"
	# Some thoughts. I can check if page is integer
	# if yes, request page.
	# If instead it is "all" or a range. e.g. 1-10
	# Then run a loop/apply that request all those pages and squashes results
	args <- as.list(compact(c(page = page, 						 
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
	data_sources <- GET(photos_url, query = args, foptions)
    stop_for_status(data_sources)
    photos <- content(data_sources)
    page_num <- ifelse(is.null(page), 1, page)
    message(sprintf("Search returned %s photos \n page %s of %s", photos[[1]], page_num, ceiling(photos[[1]]/10)))
    photos_data <- do.call(rbind, photos[[4]])
    photos_data

	# possible outputs:
	# 	author
	# 	date_range
	# 	notes
	# 	media_url
	# 	url
	# 	associated_observations
}

#  A few local tests
holos_photos()
holos_photos(collection_code = "CalAcademy")
holos_photos(county = "Santa Clara County")
holos_photos(county = "Merced County")

# To do:
# Implement search
# Return nicely formatted tables of data
# Allow viewing images from within R 

					