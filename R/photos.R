#' ee_photos_get
#'
#' Search the photos methods in the Holos API. 
#' @template pages
#' @param  state_province Need to describe these parameters
#' @param  county California counties. Package include a full list of counties. To load dataset \code{data(california_counties)}
#' @param  genus Need to describe these parameters
#' @param  scientific_name Need to describe these parameters
#' @param  authors Need to describe these parameters
#' @param  remote_id Need to describe these parameters
#' @param  collection_code Type of collection. Can be \code{CalAcademy}, \code{Private}, \code{VTM}, \code{CDFA}. \code{CalFlora} Others TBA 
#' @param  source  Need to describe these parameters
#' @template dates
#' @param  related_type Need to describe these parameters
#' @param  related  Need to describe these parameters
#' @param  other_catalog_numbers Need to describe these parameters
#' @param  quiet Default is \code{FALSE}. Set to \code{TRUE} to suppress output.
#' @param  foptions = list() Other options to pass to curl
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
#' alameda <- ee_photos_get(county = california_counties[1, 1])
#' alameda$data
#' # You can also get all the data for Alameda county with one request
#' alameda <- ee_photos_get(county = california_counties[1, 1], page = "all")
#' # Spidering through the rest of the counties can easily be automated.
#' # Or by author
#' charles_results <- ee_photos_get(author = "Charles Webber")
#' # You can also request all pages in a single call by using ee_photos_get()
#' # In this example below, there are 6 pages of results (52 result items). #' Function will return all at once.
#' racoons <- ee_photos_get(scientific_name = "Procyon lotor", quiet = TRUE)
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
    message(sprintf("Search returned %s photos (downloading page %s of %s)", photos$count, page_num, ceiling(photos[[1]]/page_size)))
	}
	photos_data <- do.call(rbind.fill, lapply(photos[[4]], rbindfillnull))
	photos_data$begin_date <- suppressWarnings(ymd_hms(photos_data$begin_date))
	# photos_data$begin_date <- as.Date(photos_data$begin_date)
	# photos_data$end_date <- as.Date(photos_data$end_date)
	photos_data$end_date <- suppressWarnings(ymd_hms(photos_data$end_date))
    photos_results <- list(results = photos$count, call = photos[[2]], type = "photos", data = photos_data)
    class(photos_results) <- "ecoengine"
    return(photos_results)
}



#'ee_photos
#'
#'This wrapper around ee_photos(). Allows a user to retrive all data at once for a query rather than request a page at a time.
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
#' some_other_cdfa <- ee_photos(collection_code = "CDFA", page = c(1,3)) 
#'}
ee_photos <- function(...) {
	ee_get(..., input_fn = ee_photos_get, dtype = "photos")
}



#' @noRd
# Internal function to convert list to data.frame when it contains NULL
rbindfillnull <- function(x) {
  x <- unlist(x)
  x[is.null(x)] <- "none"
  data.frame(as.list(x), stringsAsFactors = FALSE)
}



					