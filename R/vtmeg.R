

#' Weislander vegetation data
#'
#' Retrieves all vegetation records from the Weislander surveys
#' @param page Page number
#' @param  page_size Default is \code{25}. API default is \code{10}
#' @param  quiet = FALSE Set to \code{TRUE} to suppress messages
#' @param  foptions Additional arguments for httr
#' @export
#' @seealso \code{\link{vtmeg()}}
#' @return data.frame
#' @examples \dontrun{
#' veg_data <- vtmeg_get()
#' veg_data <- vtmeg_get(quiet = TRUE)
#'}
vtmeg_get <- function(page = NULL, page_size = 25, quiet = FALSE, foptions = list()) {
	vtmeg_url <- "http://ecoengine.berkeley.edu/api/vtmveg/?format=json"
	if(is.null(page)) page <- 1
    args <- compact(as.list(c(page = page, page_size = page_size)))
	vtcall <- GET(vtmeg_url, query = args, foptions)
	stop_for_status(vtcall)
	vtdata <- content(vtcall)
	results <- vtdata
	# TODO coerce results to a data.frame
	# Also create a new ecoengine class and make this type vtmeg
	if(!quiet) message(sprintf("Found %s vegetation records.", vtdata$count))
	vt_results <- list(results = vtdata$count, call = vtcall$call, type = "vegetation_survey", data = results) # results not yet coerced to data.frame	
 	class(vt_results) <- "ecoengine"
	vt_results
}
# TODO: coerce results to a data.frame
# Method print wont work because it cannot count nrow



vtmeg <- function(..., page = NULL) {
	page <- ifelse(is.null(page), 1, page)

}
# TODO: work through pagination just like the others.