#' ee_photos_get
#'
#' Search the photos methods in the Holos API. 
#' @param page page number
#' @param page_size  Number of results per page. Default is 25.
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
#' @importFrom plyr compact rbind.fill
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
#' alameda <- ee_photos_get(county = california_counties[1, 1])
#' alameda$data
#' # You can also get all the data for Alameda county with one request
#' alameda <- ee_photos_get_get(county = california_counties[1, 1], page = "all")
#' # Spidering through the rest of the counties can easily be automated.
#' # Or by author
#' charles_results <- ee_photos_get(author = "Charles Webber")
#' # You can also request all pages in a single call by using ee_photos_get()
#' # In this example below, there are 6 pages of results (52 result items). #' Function will return all at once.
#' all_cdfa <- ee_photos_get(collection_code = "CDFA", page = "all")
#'}
ee_photos_get <- function(page = NULL, 
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
	# Some thoughts. I can check if page is integer
	# if yes, request page.
	# If instead it is "all" or a range. e.g. 1-10
	# Then run a loop/apply that request all those pages and squashes results
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
	data_sources <- GET(photos_url, query = args, foptions)
    stop_for_status(data_sources)
    photos <- content(data_sources)
    page_num <- ifelse(is.null(page), 1, page)
    if(!quiet) {
    message(sprintf("Search returned %s photos (downloading page %s of %s)", photos$count, page_num, ceiling(photos[[1]]/10)))
	}

	 photos_data <- do.call(rbind.fill, lapply(photos[[4]], rbindfillnull))

    # photos_data <- as.data.frame(do.call(rbind, photos[[4]]))
    photos_results <- list(results = photos$count, call = photos[[2]], type = "photos", data = photos_data)
    class(photos_results) <- "ecoengine"
    return(photos_results)
}



#'ee_photos
#'
#'This wrapper around ee_photos(). Allows a user to retrive all data at once for a query rather than request a page at a time.
#' @param page Use \code{all} to request all pages for a particular query.
#' @param ... All the arguments that go into \code{ee_photos}
#'
#' \itemize{
#' \item{"page"                   } {Page Number}                                                        
#' \item{"state_province"        } {Need to describe these parameters}
#' \item{"county"                } {Package include a full list of counties. To load dataset (california_counties)}
#' \item{"genus"                  } {Genus           }                                                                   
#' \item{"scientific_name"       } {Scientific Name }                                                                   
#' \item{"authors"                } {List of authors }                                                                   
#' \item{"remote_id"            } {Description     }                                                                   
#' \item{"collection_code"      } {Description     }                                                                   
#' \item{"source"                 } {Description     }                                                                   
#' \item{"min_date"              } {Lower date bound}                                                                   
#' \item{"max_date"              } {Upper date bound}                                                                   
#' \item{"related_type"          } {Description     }                                                                   
#' \item{"related "               } {Description     }                                                                   
#' \item{"other_catalog_numbers"} {Description     }                                                                   
#' }
#'
#' @export
#' @importFrom utils txtProgressBar setTxtProgressBar
#' @seealso  \code{\link{ee_photos_get}}
#' @examples \dontrun{
#' all_cdfa <- ee_photos(collection_code = "CDFA", page = "all")
#' some_cdfa <- ee_photos(collection_code = "CDFA", page = 1:2)
#' some_other_cdfa <- ee_photos(collection_code = "CDFA", page = c(1:4,6)) 
#'}
ee_photos <- function(..., page = NULL) {

# First figure out how many pages total for a call regardless of supplied page range
	x <- ee_photos_get(..., quiet = TRUE)
	total_results <- NULL
	total_results <- x$results
	all_available_pages <- ceiling(total_results/10)	

if(!is.null(page) && page!="all") {
	max_pages <- length(page)
	all_pages <- page
	total_results <- max_pages * 10
}

if(identical(page, "all")) {
x <- ee_photos_get(..., quiet = TRUE)	
total_results <- NULL
# Reqest page 1 to get the total record count
total_results <- x$results
# Calculate total number of pages to request. 
max_pages <- all_pages <- ceiling(total_results/10)	
}

if(!is.null(page)) {

	result_list <- list()
	message(sprintf("Retrieving %s pages (total: %s) \n", max_pages, total_results))


		if(is.numeric(page)) {
			if(max(page) > all_available_pages) {
				stop("Page range is invalid", call. = FALSE) 
			} else {
			all_pages <- page
			}
		}
		pb <- txtProgressBar(min = 0, max = max_pages, style = 3)

		if(total_results > 1000) {
		message(sprintf("Retrieving %s (%s requests) results. This may take a while \n", total_results, ceiling(total_results/10)))
		}

		if(identical(page, "all")) { 
		for(i in seq_along(1:all_pages)) {
		result_list[[i]] <- ee_photos_get(..., page = i, quiet = TRUE)$data
		setTxtProgressBar(pb, i)
		# Nice trick (I think) to sleep 2 seconds after every 25 API calls.
		if(i %% 25 == 0) Sys.sleep(2)		
		} 
	 	} else { 
		for(i in seq_along(all_pages)) {
		# There is a problem here when using non sequential pages.
		j <- all_pages[[i]]
		# message(sprintf("Current page index is %s", j))
		# browser()	
		result_list[[i]] <- ee_photos_get(..., page = j, quiet = TRUE)$data
		setTxtProgressBar(pb, i)
		# Nice trick (I think) to sleep 2 seconds after every 25 API calls.
		if(i %% 25 == 0) Sys.sleep(2)
		}

		}

		# result_data <- as.data.frame(do.call(rbind, result_list))
		result_data <- do.call(rbind.fill, result_list)
		all_photo_results <- list(results = nrow(result_data), call = x[[2]], type = "photos", data = result_data)
		class(all_photo_results) <- "ecoengine"

	}  

	if(is.null(page)) { 
		pb <- txtProgressBar(min = 0, max = 1, style = 3)
		# In case user forgets to request all pages then it just become a regular query.
		all_photo_results <- ee_photos_get(...)
	}

	close(pb)
	all_photo_results

}



#' @noRd
# Internal function to convert list to data.frame when it contains NULL
rbindfillnull <- function(x) {
  x <- unlist(x)
  x[is.null(x)] <- "none"
  data.frame(as.list(x), stringsAsFactors = FALSE)
}



					