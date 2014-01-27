

#' ee_footprints
#'
#' List of ecoengine footprints.
#' @template foptions
#' @importFrom dplyr rbind_all
#' @export
#' @return data.frame
#' @examples 
#' footprints <- ee_footprints()

ee_footprints <- function(foptions = list()) {
	footprints_url <- "http://ecoengine.berkeley.edu/api/footprints/?format=json"
	footprints <- GET(footprints_url, foptions)
	 stop_for_status(footprints)
	 res <- content(footprints)
	 x <- lapply(res$results, function(x) x[-4])
	 rbind_all(x)
}



