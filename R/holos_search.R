

#' ee search
#'
#' Search the ecoengine
#' @param query search term
#' @param  foptions = list() Additional (optional) arguments to httr
#' @export
#' @keywords search
#' @examples \dontrun{
#' ee_search(query = "genus:Lynx", facet.field = "Genus")
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




