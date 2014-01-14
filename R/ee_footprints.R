

#' ee_footprints
#'
#' List of ecoengine footprints
#' @template foptions
#' @export
#' @return data.frame
#' @examples \dontrun{
#' ee_footprints()
#'}
ee_footprints <- function(foptions = list()) {
	footprints_url <- "http://ecoengine.berkeley.edu/api/footprints/?format=json"
	footprints <- GET(footprints_url, foptions)
	 stop_for_status(footprints)
	 res <- content(footprints)
	 results <- do.call(rbind, res$results)
	 data.frame(results[, -4])
}

