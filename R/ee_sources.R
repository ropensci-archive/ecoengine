#' Ecoengine data sources
#'
#' Returns a full list of data sources supported by the ecoengine
#' @template foptions
#' @export
#' @importFrom httr GET content stop_for_status
#' @importFrom lubridate ymd_hms
#' @return \code{data.frame}
#' @examples \dontrun{
#' source_list <- ee_sources()
#'}
ee_sources <- function(foptions = list()) {
	base_url <- "http://ecoengine.berkeley.edu/api/sources/?format=json"
    data_sources <- GET(base_url, foptions)
    stop_for_status(data_sources)
    ds <- content(data_sources)
    sources <- as.data.frame(do.call(rbind.data.frame, ds$results))
    sources$retrieved <- ymd_hms(sources$retrieved)
    sources
}


