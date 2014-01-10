

#' ee search
#'
#' Search the ecoengine
#' @param query search term
#' @param  foptions = list() Additional (optional) arguments to httr
#' @export
#' @keywords search
#' @examples \dontrun{
#' ee_search(query = "genus:Lynx")
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
	temp_fields <- as.data.frame(t(unlist(y))) 
	names(temp_fields) <- c("field", "results", "search_url")
	temp_fields
})
faceted_search_results
}
# TODO: coerce return list into a df



#'Search observations
#'
#' A powerful way to search through the observations. 
#' @param query = The search term
#' @param  foptions = list()  Additional arguments for httr
#' @export
#' @keywords search
#' @seealso \code{\link{ee_search})}
#' @return data.frame
#' @examples \dontrun{
#' ee_search_obs(query  = "Lynx")
#' ee_search_obs(query  = "genus:Lynx")
#'}
ee_search_obs <- function(query = NULL, foptions = list()) {
# http://ecoengine.berkeley.edu/api/observations/?q=Lynx
	obs_search_url <- "http://ecoengine.berkeley.edu/api/observations/?format=json"	
	args <- compact(as.list(c(q = query)))
	obs_search <- GET(obs_search_url, query = args, foptions)
	obs_results <- content(obs_search)
	message(sprintf("Search returned %s results \n", obs_results$count))
	# Split the two, with and without coordinates since we can't merge them into a data.frame otherwise
	without_geojson <- Filter(function(x) { is.null(x$geojson) }, obs_results$results)
	with_geojson <- Filter(function(x) { !is.null(x$geojson) }, obs_results$results)

	with_geojson_df <- ldply(with_geojson, function(x) {
						 geo_data <- data.frame(t(unlist(x[10])))
						 main_data <- unlist(x[-10])
  						 main_data[is.null(main_data)] <- "none"
  						 md <-(data.frame(as.list(main_data), stringsAsFactors = FALSE))	
  						 cbind(md, geo_data)
					})

	without_geojson_df <- ldply(without_geojson, function(x) {
						main_data <- unlist(x[-10])
  						main_data[is.null(main_data)] <- "none"
  						md <-(data.frame(as.list(main_data), stringsAsFactors = FALSE))	
	 					md$geojson.type  <- NA
	 					md$geojson.coordinates1  <- NA
	 					md$geojson.coordinates2 <- NA
	 					md
	}) 

	rbind(with_geojson_df, without_geojson_df)  
}

