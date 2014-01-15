

#' ee search
#'
#' Search the ecoengine
#' @param query search term
#' @template foptions
#' @importFrom data.table rbindlist
#' @export
#' @keywords search
#' @examples \dontrun{
#' lynx_results <- ee_search(query = "genus:Lynx")
#'}
ee_search <- function(query = NULL, foptions = list()) {

search_url <- "http://ecoengine.berkeley.edu/api/search/?format=json"
args <- as.list(compact(c(q = query)))
result <- GET(search_url, query = args, foptions)
es_results <- content(result)
fields <- es_results$fields
# This removes list items with nothing nested. 
ee_filter <- function(i) {
	length(i) > 0
}
fields_compacted <- Filter(ee_filter, fields)

faceted_search_results <- lapply(fields_compacted, function(y) { 
	temp_fields <- do.call(rbind.data.frame, lapply(y, LinearizeNestedList))
	# temp_fields <- as.data.frame(t(unlist(y))) 
	names(temp_fields) <- c("field", "results", "search_url")
	temp_fields
})
rbindlist(faceted_search_results)
}

# ------------------------------------------------
# Some notes, I realized this is not all that different from the ee_observations function. 
# This does a full on query across all fields 
# ------------------------------------------------


#'Search observations
#'
#' A powerful way to search through the observations. 
#' @param query = The search term
#' @template foptions
#' @param  quiet Default is FALSE. Set to TRUE to suppress messages.
#' @template pages
#' @export
#' @keywords search
#' @seealso \code{\link{ee_search})}
#' @return data.frame
#' @examples \dontrun{
#' ee_search_obs_get(query  = "Lynx")
#' ee_search_obs_get(query  = "genus:Lynx")
#'}
ee_search_obs_get <- function(query = NULL, page = NULL, page_size = 25, quiet = FALSE, foptions = list()) {
	obs_search_url <- "http://ecoengine.berkeley.edu/api/observations/?format=json"	
	args <- compact(as.list(c(q = query, page = page, page_size = 25)))
	obs_search <- GET(obs_search_url, query = args, foptions)
	obs_results <- content(obs_search)
	if(!quiet) message(sprintf("Search returned %s results \n", obs_results$count))

	# Split the two, with and without coordinates since we can't merge them into a data.frame otherwise
	without_geojson <- Filter(function(x) { is.null(x$geojson) }, obs_results$results)
	with_geojson <- Filter(function(x) { !is.null(x$geojson) }, obs_results$results)

	with_geojson_df <- ldply(with_geojson, function(x) {
						 geo_data <- data.frame(t(unlist(x[10])))
						 main_data <- unlist(x[-10])
  						 main_data[is.null(main_data)] <- "none" # doesn't address empty strings
  						 md <-(data.frame(as.list(main_data), stringsAsFactors = FALSE))	
  						 cbind(md, geo_data)
					})

	without_geojson_df <- ldply(without_geojson, function(x) {
						main_data <- unlist(x[-10])
  						main_data[is.null(main_data)] <- "none" # doesn't address empty strings
  						md <-(data.frame(as.list(main_data), stringsAsFactors = FALSE))	
	}) 

	obs_data <- rbind.fill(with_geojson_df, without_geojson_df)  
	all_obs_results <- list(results = obs_results$count, call = obs_results[[2]], type = "observations", data = obs_data)
	class(all_obs_results) <- "ecoengine"
    return(all_obs_results)
}


#' ee_search_obs
#'
#' Elastic search on observations. This wrapper for \code{\link{ee_search_obs}}
#' @param ... all the arguments that get passed to \code{\link{ee_search_obs}}
#' @template pages
#' @template foptions
#' @importFrom plyr rbind.fill
#' @importFrom data.table rbindlist
#' @export
#' @examples \dontrun{
#' all_lynx_data <- ee_search_obs(query  = "Lynx", page = "all")
#'}
ee_search_obs <- function(..., page = NULL, page_size = 25, foptions = list()) {
	 	obs_call <- ee_search_obs_get(..., quiet = TRUE)
	 	total_obs <- obs_call$results
	 	total_pages <- ceiling(total_obs/page_size)


	if(identical(class(page), "numeric") || identical(class(page), "integer")) {
		message("Page class is numeric/integer")
		last_page <- max(page)
		if(last_page > total_pages) {
				stop("Request includes a page not in range")	
			} else {
			total_pages <- length(page)				
			}
	}

	# If all pages
	if(identical(page, "all")) {
		if(total_obs > 5000) { 
			message("This request may take some time given the large size of the request")
	}
		message(sprintf("Retrieving %s records ...\n", total_obs))
		all_results <- list()
		for(i in seq_along(1:total_pages)) {
			all_results[[i]] <- ee_search_obs_get(..., page = i, page_size = page_size, quiet = TRUE)$data
			# API currently allows 25 calls per second
			if(i %% 25 == 0) Sys.sleep(1)
		}
	result_data <- do.call(rbind.fill, all_results)
	all_obs_results <- list(results = nrow(result_data), call = obs_call$call, type = "observations", data = result_data)
	class(all_obs_results) <- "ecoengine"
	}
	# If some pages
	if(identical(class(page), "numeric") || identical(class(page), "integer")) {
	all_results <- list()	
	for(i in seq_along(total_pages)) {
			all_results[[i]] <- ee_search_obs_get(..., page = i, page_size = page_size, quiet = TRUE)$data
			# API currently allows 25 calls 
			if(i %% 25 == 0) Sys.sleep(1)
		}
	result_data <- do.call(rbindlist, all_results)
	all_obs_results <- list(results = nrow(result_data), call = obs_call$call, type = "observations", data = result_data)
	class(all_obs_results) <- "ecoengine"
	}	
	# If no page
	if(is.null(page)) {
		all_obs_results <- ee_search_obs_get(..., quiet = TRUE)
	}

	all_obs_results
}




