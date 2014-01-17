

#' Weislander vegetation data
#'
#' Retrieves all vegetation records from the Weislander surveys
#' @template pages
#' @param  quiet Default is \code{FALSE}. Set to \code{TRUE} to suppress messages
#' @template foptions
#' @export
#' @return data.frame
#' @examples \dontrun{
#' some_veg_data <- vtmveg_get()
#'}
vtmveg_get <- function(page = NULL, page_size = 25, quiet = FALSE, foptions = list()) {
	vtmveg_url <- "http://ecoengine.berkeley.edu/api/vtmveg/?format=json"
	if(is.null(page)) page <- 1
    args <- compact(as.list(c(page = page, page_size = page_size)))
	vtcall <- GET(vtmveg_url, query = args, foptions)
	stop_for_status(vtcall)
	vtdata <- content(vtcall)

	results <- vtdata$results
	# TODO coerce results to a data.frame
	# Also create a new ecoengine class and make this type vtmeg
	if(!quiet) message(sprintf("Found %s vegetation records.", vtdata$count))
	browser()
	results_1 <- do.call(rbind, lapply(results, LinearizeNestedList))	
	vt_results <- list(results = vtdata$count, call = vtcall$call, type = "vegetation_survey", data = results) # results not yet coerced to data.frame	
 	class(vt_results) <- "ecoengine"
	vt_results
}
# TODO: coerce results to a data.frame
# Method print wont work because it cannot count nrow
# @seealso \code{\link{vtmveg}}


vtmveg <- function(..., page = NULL) {
	page <- ifelse(is.null(page), 1, page)

}
# TODO: work through pagination just like the others.