#' holos_photos
#'
#' Search the photos methods in the Holos API. 
#' @param page page number
#' @param  state_province Need to describe these parameters
#' @param  county California counties. Package include a full list of counties. To load dataset \code{data(california_counties)}
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
#' @param  quiet Default is \code{FALSE}. Set to \code{TRUE} to suppress output.
#' @param  foptions = list() Other options to pass to curl
#' @export
#' @importFrom httr stop_for_status content GET
#' @importFrom plyr compact
#' @seealso related: \code{\link{holos_photos_get}} \code{\link{california_counties}}
#' @examples \dontrun{
#' # Request all photos. This request will paginate. Don't use holos_photos_get #' on such a large request
#' holos_photos()
#' # Search by collection code. See notes above on options
#' holos_photos(collection_code = "CalAcademy")
#' holos_photos(collection_code = "VTM")
#' holos_photos(collection_code = "CalFlora")
#' holos_photos(collection_code = "CDFA")
#' # Search by county.
#' holos_photos(county = "Santa Clara County")
#' holos_photos(county = "Merced County")
#' # The package also contains a full list of counties
#' data(california_counties)
#' alameda <- holos_photos(county = california_counties[1, 1])
#' alameda$data
#' # You can also get all the data for Alameda county with one request
#' alameda <- holos_photos_get(county = california_counties[1, 1], page = "all")
#' # Spidering through the rest of the counties can easily be automated.
#' # Or by author
#' holos_photos(author = "Charles Webber")
#' # You can also request all pages in a single call by using holos_photos_get()
#' # In this example below, there are 6 pages of results (52 result items). #' Function will return all at once.
#' all_cdfa <- holos_photos_get(collection_code = "CDFA", page = "all")
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
						 quiet = FALSE,
						 other_catalog_numbers = NULL, 
						 foptions = list()) {

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
    if(!quiet) {
    message(sprintf("Search returned %s photos (downloading page %s of %s)", photos[[1]], page_num, ceiling(photos[[1]]/10)))
	}
    photos_data <- do.call(rbind, photos[[4]])
    photos_results <- list(results = photos[[1]], call = photos[[2]], type = "photos", data = photos_data)
    class(photos_results) <- "holos"
    return(photos_results)
	# possible outputs:
	# 	author
	# 	date_range
	# 	notes
	# 	media_url
	# 	url
	# 	associated_observations
}



#'holos_photos_get
#'
#'This wrapper around holos_photos(). Allows a user to retrive all data at once for a query rather than request a page at a time.
#' @param page Use \code{all} to request all pages for a particular query.
#' @param ... All the arguments that go into \code{holos_photos}
#' @export
#' @seealso  \code{\link{holos_photos}}
#' @examples \dontrun{
#' all_cdfa <- holos_photos_get(collection_code = "CDFA", page = "all")
#' some_cdfa <- holos_photos_get(collection_code = "CDFA", page = 1:2)
#' some_other_cdfa <- holos_photos_get(collection_code = "CDFA", page = c(1:4,6))
#'}
holos_photos_get <- function(..., page = NULL) {
if(!is.null(page)) {
	total_results <-NULL
	result_list <- list()
	x <- holos_photos(..., quiet = TRUE)
	# Reqest page 1 to get the total record count
	total_results <- x$results
	# Calculate total number of pages to request. 
	all_pages <- ceiling(total_results/10)


		if(is.numeric(page)) {
			if(max(page) > all_pages) {
				stop("Page range is invalid", call. = FALSE) 
			} else {
			all_pages <- page
			}
		}


		if(total_results > 1000) {
		message(sprintf("Retrieving %s (%s requests) results. This may take a while", total_results, ceiling(total_results/10)))
		}

		if(identical(page,"all")) { 
		for(i in seq_along(1:all_pages)) {
		result_list[[i]] <- holos_photos(..., page = i)$data
		# Nice trick (I think) to sleep 2 seconds after every 10 API calls.
		if(i %% 10 == 0) Sys.sleep(2)		
		} 
	 	} else { 
		for(i in all_pages) {
		result_list[[i]] <- holos_photos(..., page = i, quiet = TRUE)$data
		# Nice trick (I think) to sleep 2 seconds after every 10 API calls.
		if(i %% 10 == 0) Sys.sleep(2)
		}

		}


		result_data <- as.data.frame(do.call(rbind, result_list))
		all_photo_results <- list(results = x[[1]], call = x[[2]], type = "photos", data = result_data)
		class(all_photo_results) <- "holos"

	} else { 
		# In case user forgets to request all pages then it just become a regular query.
		all_photo_results <- holos_photos(...)
	}

# Return all results
	all_photo_results
}
# TODO make this take any page range in addition to all




# Notes

# Don't have an example for remote_id or for sources
# Have asked Kevin and Falk about this.

# -------------------
# To do:
# Return nicely formatted tables of data (Whisker)
# Allow viewing images from within R 
# Allow holos_photos_get to take a page range.

					