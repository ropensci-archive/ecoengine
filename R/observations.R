#' Observations List
#'
#'API endpoint that represents a list of observations. Prameter options have not been fleshed out yet
#' @param country description needed.
#' @param  state_province description needed.
#' @param  county description needed.
#' @param  kingdom  description needed.
#' @param  phylum description needed.
#' @param  order  description needed.
#' @param  clss description needed.
#' @param  family description needed.
#' @param  genus description needed.
#' @param  scientific_name description needed.
#' @param  kingdom_exact  description needed.
#' @param  phylum_exact description needed.
#' @param  order_exact  description needed.
#' @param  clss_exact description needed.
#' @param  family_exact description needed.
#' @param  genus_exact description needed.
#' @param  scientific_name_exact description needed.
#' @param  remote_id description needed.
#' @param  collection_code description needed.
#' @param  source  description needed.
#' @param  min_date description needed.
#' @param  max_date description needed.
#' @param  page  Page page number. 
#' @param  page_size  Number of results per page. Default is 10
#' @param  quiet Default is \code{FALSE}. Set to \code{TRUE} to supress messages.
#' @param  foptions description needed.
#' @export
#' @return \code{data.frame}
#' @importFrom httr content GET 
#' @importFrom plyr compact
#' @examples \dontrun{
#' ee_observations_get(country = "United States")
#' ee_observations_get(scientific_name_exact = "Pinus")
#'}
ee_observations_get <- function(country = "United States", state_province = NULL, county = NULL, kingdom  = NULL, phylum = NULL, order  = NULL, clss = NULL, family = NULL, genus = NULL, scientific_name = NULL, kingdom_exact = NULL ,phylum_exact = NULL, order_exact = NULL, clss_exact = NULL, family_exact = NULL, genus_exact = NULL, scientific_name_exact = NULL, remote_id = NULL, collection_code = NULL, source  = NULL, min_date = NULL, max_date = NULL, page = NULL, page_size = 10,  quiet  = FALSE, foptions = list()) {
 obs_url <- "http://ecoengine.berkeley.edu/api/observations/?format=json"
 if(page_size > 1000) {
 		message("This is a unusually large page size and will likely cause the server to time out")
 }


 args <- as.list(compact(c(country = country, kingdom = kingdom, phylum = phylum,order = order, clss = clss,family = family, genus  = genus, scientific_name = scientific_name, kingdom_exact = kingdom_exact, phylum_exact = phylum_exact, order_exact = order_exact, clss_exact = clss_exact ,family_exact = family_exact , genus_exact  = genus_exact, scientific_name_exact = scientific_name_exact, remote_id = remote_id, collection_code = collection_code, source = source, min_date = min_date, max_date = max_date, page = page, page_size = page_size)))
data_sources <- GET(obs_url, query = args, foptions)
stop_for_status(data_sources)
obs_data <- content(data_sources)
if(!quiet) {
message(sprintf("%s observations found", obs_data[[1]]))
}
# The data are already returned in a nice list that include
# number of results, the everything in appropriate slots.
obs_df <- as.data.frame(do.call(rbind, obs_data[[4]]))
observation_results <- list(results = obs_data$count, call = obs_data[[2]], type = "observations", data = obs_df)
class(observation_results) <- "ecoengine"
return(observation_results)
}



#' Ecoengine observations
#'
#'Retrieves observation records from BigCB
#' @param ... all the arguments that get passed to \code{\link{ee_observations_get}}
#' @param  page Page number or range. Use "all" to retrieve all pages. May time out for extremely large queries
#' @param  page_size The number of observations per page. Default is 10. Do not set this too high or the server will time out
#' @export
#' @importFrom utils txtProgressBar setTxtProgressBar
#' @seealso \code{\link{ee_observations_get}}
#' @examples \dontrun{
#' ee_observations(scientific_name_exact = "Pinus", page = 1)
#' ee_observations(scientific_name_exact = "Pinus", page = 1:2)
#'}
ee_observations <- function(..., page_size = 25, page = NULL) {
	
	total_results <- NULL
	page_size <- ifelse(is.null(page_size), 25, page_size)

	x <- ee_observations_get(..., quiet = TRUE)
	total_results <- x$results
	all_available_pages <- ceiling(total_results/page_size)	

	if(identical(class(page), "character") && !identical(page , "all")) {
	stop("Page range not understood. Please use all or specify a numeric range")
}

	if(!is.null(page) && page!="all") { # still doesn't catch non=numeric, non-integer
	max_pages <- length(page)
	all_pages <- page
	total_results <- max_pages * page_size
}


if(identical(page , "all")) {
total_results <- x$results
max_pages <- all_pages <- ceiling(total_results/page_size)	
}

if(!is.null(page)) {
	result_list <- list()
	message(sprintf("Retrieving %s pages (total: %s records) \n", max_pages, total_results))


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
		result_list[[i]] <- ee_observations_get(..., page_size = page_size, page = i, quiet = TRUE)$data
		setTxtProgressBar(pb, i)
		# Nice trick (I think) to sleep 2 seconds after every 25 API calls.
		if(i %% 25 == 0) Sys.sleep(2)		
		} 
	 	} else { 
		for(i in seq_along(all_pages)) {
		j <- all_pages[[i]]

		result_list[[i]] <- ee_observations_get(..., page_size = page_size, page = j, quiet = TRUE)$data
		setTxtProgressBar(pb, i)
		# Nice trick (I think) to sleep 2 seconds after every 25 API calls.
		if(i %% 25 == 0) Sys.sleep(2)
			}
		}
		result_data <- do.call(rbind.fill, result_list)
		all_obs_results <- list(results = nrow(result_data), call = x[[2]], type = "observations", data = result_data)
		class(all_obs_results) <- "ecoengine"
}
	if(is.null(page)) { 
		pb <- txtProgressBar(min = 0, max = 1, style = 3)
		# In case user forgets to request all pages then it just become a regular query.
		all_obs_results <- ee_observations_get(...)
	}

close(pb)
all_obs_results
# assemble data into the ee class
# return the ee class object

}



