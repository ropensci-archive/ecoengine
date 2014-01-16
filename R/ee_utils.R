
#' Print a summary for an ecoengine object
#' @method print ecoengine
#' @S3method print ecoengine
#' @param x An object of class \code{ecoengine}
#' @param ... additional arguments
print.ecoengine <- function(x, ...) {
    value <- NA

	string <- " [Type]: %s\n [Number of results]: %s \n [Call]: %s \n [Output dataset]: %s rows"
    vals   <- c(x$type, x$results,  x$call, nrow(x$data))
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


#' ee_pages - Returns total number of pages for any ecoengine request
#'
#' @param ee Object of class \code{ecoengine}
#' @param  page_size Default page size. Currently set to \code{25} package wide.
#' @export
#' @return integer
#' @examples \dontrun{
#' page_1_data <- ee_sensor_data_get(1625, page = 2)
#' ee_pages(page_1_data)
#'}
ee_pages <- function(ee, page_size = 25) {
    if(!identical(class(ee), "ecoengine"))
        stop("Object must be of class ecoengine")

   return(ceiling(ee$results/page_size)) 
}

#' Ecoengine paginator
#'
#' This function allows for paginating through calls that return more observations than the throttling limit. Although the API itself defaults to 10 observations per page, this package default to 25. This request requires an input function (currently supports photos, observations and checklists), a page range (can be a single page, page range, or "all") and a data type for the purposes of constructing a \code{ecoengine} class. The type can be "photos", "observations", "checklists" (more to be added).
#' @param ... Arguments that get passed to the input function.
#' @template pages
#' @param  input_fn An input function that needs to be recursively called to retrieve all results.
#' @param  dtype data type can be \code{photos}, \code{observations}, \code{checklists}. 
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




#' @noRd
# This is an internal function to linearize lists
# Source: https://gist.github.com/mrdwab/4205477
# Author page (currently unreachable):  https://sites.google.com/site/akhilsbehl/geekspace/articles/r/linearize_nested_lists_in
# Original Author: Akhil S Bhel
# Notes: Current author could not be reached and original site () appears defunct. Copyright remains with original author
LinearizeNestedList <- function(NList, LinearizeDataFrames=FALSE,
                                NameSep="/", ForceNames=FALSE) {
    # LinearizeNestedList:
    #
    # https://sites.google.com/site/akhilsbehl/geekspace/
    #         articles/r/linearize_nested_lists_in_r
    #
    # Akhil S Bhel
    # 
    # Implements a recursive algorithm to linearize nested lists upto any
    # arbitrary level of nesting (limited by R's allowance for recursion-depth).
    # By linearization, it is meant to bring all list branches emanating from
    # any nth-nested trunk upto the top-level trunk s.t. the return value is a
    # simple non-nested list having all branches emanating from this top-level
    # branch.
    #
    # Since dataframes are essentially lists a boolean option is provided to
    # switch on/off the linearization of dataframes. This has been found
    # desirable in the author's experience.
    #
    # Also, one'd typically want to preserve names in the lists in a way as to
    # clearly denote the association of any list element to it's nth-level
    # history. As such we provide a clean and simple method of preserving names
    # information of list elements. The names at any level of nesting are
    # appended to the names of all preceding trunks using the `NameSep` option
    # string as the seperator. The default `/` has been chosen to mimic the unix
    # tradition of filesystem hierarchies. The default behavior works with
    # existing names at any n-th level trunk, if found; otherwise, coerces simple
    # numeric names corresponding to the position of a list element on the
    # nth-trunk. Note, however, that this naming pattern does not ensure unique
    # names for all elements in the resulting list. If the nested lists had
    # non-unique names in a trunk the same would be reflected in the final list.
    # Also, note that the function does not at all handle cases where `some`
    # names are missing and some are not.
    #
    # Clearly, preserving the n-level hierarchy of branches in the element names
    # may lead to names that are too long. Often, only the depth of a list
    # element may only be important. To deal with this possibility a boolean
    # option called `ForceNames` has been provided. ForceNames shall drop all
    # original names in the lists and coerce simple numeric names which simply
    # indicate the position of an element at the nth-level trunk as well as all
    # preceding trunk numbers.
    #
    # Returns:
    # LinearList: Named list.
    #
    # Sanity checks:
    #
    stopifnot(is.character(NameSep), length(NameSep) == 1)
    stopifnot(is.logical(LinearizeDataFrames), length(LinearizeDataFrames) == 1)
    stopifnot(is.logical(ForceNames), length(ForceNames) == 1)
    if (! is.list(NList)) return(NList)
    #
    # If no names on the top-level list coerce names. Recursion shall handle
    # naming at all levels.
    #
    if (is.null(names(NList)) | ForceNames == TRUE)
        names(NList) <- as.character(1:length(NList))
    #
    # If simply a dataframe deal promptly.
    #
    if (is.data.frame(NList) & LinearizeDataFrames == FALSE)
        return(NList)
    if (is.data.frame(NList) & LinearizeDataFrames == TRUE)
        return(as.list(NList))
    #
    # Book-keeping code to employ a while loop.
    #
    A <- 1
    B <- length(NList)
    #
    # We use a while loop to deal with the fact that the length of the nested
    # list grows dynamically in the process of linearization.
    #
    while (A <= B) {
        Element <- NList[[A]]
        EName <- names(NList)[A]
        if (is.list(Element)) {
            #
            # Before and After to keep track of the status of the top-level trunk
            # below and above the current element.
            #
            if (A == 1) {
                Before <- NULL
            } else {
                Before <- NList[1:(A - 1)]
            }
            if (A == B) {
                After <- NULL
            } else {
                After <- NList[(A + 1):B]
            }
            #
            # Treat dataframes specially.
            #
            if (is.data.frame(Element)) {
                if (LinearizeDataFrames == TRUE) {
                    #
                    # `Jump` takes care of how much the list shall grow in this step.
                    #
                    Jump <- length(Element)
                    NList[[A]] <- NULL
                    #
                    # Generate or coerce names as need be.
                    #
                    if (is.null(names(Element)) | ForceNames == TRUE)
                        names(Element) <- as.character(1:length(Element))
                    #
                    # Just throw back as list since dataframes have no nesting.
                    #
                    Element <- as.list(Element)
                    #
                    # Update names
                    #
                    names(Element) <- paste(EName, names(Element), sep=NameSep)
                    #
                    # Plug the branch back into the top-level trunk.
                    #
                    NList <- c(Before, Element, After)
                }
                Jump <- 1
            } else {
                NList[[A]] <- NULL
                #
                # Go recursive! :)
                #
                if (is.null(names(Element)) | ForceNames == TRUE)
                    names(Element) <- as.character(1:length(Element))
                Element <- LinearizeNestedList(Element, LinearizeDataFrames,
                                               NameSep, ForceNames)
                names(Element) <- paste(EName, names(Element), sep=NameSep)
                Jump <- length(Element)
                NList <- c(Before, Element, After)
            }
        } else {
            Jump <- 1
        }
        #
        # Update book-keeping variables.
        #
        A <- A + Jump
        B <- length(NList)
    }
    return(NList)
}
