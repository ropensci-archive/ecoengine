
#' Print a summary for an ecoengine object
#' @method print ecoengine
#' @S3method print ecoengine
#' @param x An object of class \code{ecoengine}
#' @param ... additional arguments
print.ecoengine <- function(x, ...) {
    value <- NA

	string <- "Number of results: %s \n Call: %s \n Output dataset: %s rows"
    vals   <- c(x$results,  x$call, nrow(x$data))
    cat(do.call(sprintf, as.list(c(string, vals))))
    cat("\n")
}



#' Plots metrics for an ecoengine object
#' 
#' @method plot ecoengine
#' @S3method plot ecoengine
#' @param x An object of class \code{ecoengine}
#' @param ... additional arguments
plot.ecoengine <- function(x, ...) {

value <- NA
# just to trick check()    
if (!is(x, "ecoengine"))   
    stop("Not an ecoengine object")
# Rest of this is not coded up. 
# Will have to figure out what to plot on a case by case basis or possibily ditch this.

}



#' Ecoengine paginator
#'
#' This function allows for paginating through calls that return more observations than the throttling limit. Although the API itself defaults to 10 observations per page, this package default to 25. This request requires an input function (currently supports photos, observations and checklists), a page range (can be a single page, page range, or "all") and a data type for the purposes of constructing a \code{ecoengine} class. The type can be "photos", "observations", "checklists" (more to be added).
#' @param ... Arguments that get passed to the input function.
#' @param  input_fn An input function that needs to be recursively called to retrieve all results.
#' @param  page A page number, page size, 
#' @param  dtype data type can be \code{photos}, \code{observations}, \code{checklists}. 
#' @param  page_size Number of observations per page. Package default is \code{25}
#' @importFrom assertthat assert_that
#' @export
#' @examples \dontrun{
#' some_cdfa <- ee_get(collection_code = "CDFA", page = 1, input_fn = ee_photos_get, dtype = "photos")
#'}
ee_get <- function(..., input_fn = NULL, page = NULL, page_size = 25,  dtype =  NULL) {

	# if(is.null(dtype)) {
	# 	stop("Specify a data type for ecoengine class")
	# }
	assert_that(is.character(dtype))
	total_results <- NULL

	x <- input_fn(..., quiet = TRUE)
	total_results <- x$results
	all_available_pages <- ceiling(total_results/page_size)	
	if(identical(class(page), "character") & !identical(page , "all")) {
	stop("Page range not understood. Please use all or specify a numeric range")
}

	if(!is.null(page) & !identical(page, "all")) {
	# still doesn't catch non=numeric, non-integer. TODO
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
		result_list[[i]] <- input_fn(..., page_size = page_size, page = i, quiet = TRUE)$data
		setTxtProgressBar(pb, i)
		# Nice trick (I think) to sleep 2 seconds after every 25 API calls.
		if(i %% 25 == 0) Sys.sleep(2)		
		} 
	 	} else { 
		for(i in seq_along(all_pages)) {
		j <- all_pages[[i]]

		result_list[[i]] <- input_fn(..., page_size = page_size, page = j, quiet = TRUE)$data
		setTxtProgressBar(pb, i)
		# Nice trick (I think) to sleep 2 seconds after every 25 API calls.
		if(i %% 25 == 0) Sys.sleep(2)
			}
		}
		result_data <- do.call(rbind.fill, result_list)
		all_obs_results <- list(results = nrow(result_data), call = x[[2]], type = dtype, data = result_data)
		class(all_obs_results) <- "ecoengine"
}
	if(is.null(page)) { 
		pb <- txtProgressBar(min = 0, max = 1, style = 3)
		# In case user forgets to request all pages then it just become a regular query.
		all_obs_results <- input_fn(...)
	}

close(pb)
all_obs_results
}
# Notes:
# Function works correctly on the first example tested (photos)
# Now to test this out for observations, checklists, and vtmveg. Once it works correctly, optimize here, rebase everything (remove extraneous code) and push to package.
