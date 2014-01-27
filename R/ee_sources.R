#' Ecoengine data sources
#'
#' Returns a full list of data sources supported by the ecoengine
#' @template foptions
#' @export
#' @importFrom httr GET content stop_for_status
#' @importFrom lubridate ymd_hms
#' @importFrom dplyr rbind_all
#' @return \code{data.frame}
#' @examples 
#' source_list <- ee_sources()
ee_sources <- function(foptions = list()) {
	base_url <- "http://ecoengine.berkeley.edu/api/sources/?format=json"
    data_sources <- GET(base_url, foptions)
    stop_for_status(data_sources)
    ds <- content(data_sources)
    sources <- rbind_all(ds$results)
    sources$retrieved <- ymd_hms(sources$retrieved)
    sources
}


