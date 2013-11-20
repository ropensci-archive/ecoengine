#' Holos data sources
#'
#' Returns a full list of data source supported by the ecoengine
#' @param foptions A list of additional arguments. Currently this function takes none.
#' @export
#' @importFrom httr GET stop_for_status
#' @importFrom plyr ldply
#' @seealso \link\code{about_bee}
#' @return \code{data.frame}
#' @examples \dontrun{
#' holos_sources()
#'}
holos_sources <- function(foptions=list()) {
	base_url <- "http://ecoengine.berkeley.edu/api/sources/?format=json"
    data_sources <- GET(base_url, foptions)
    stop_for_status(data_sources)
    ds <- content(data_sources)
    # The first item is a #
    # Second item is the URL call
    # Item 3 was a NULL
    # Item 4 is the list of sources. Formatting this down into a data.frame
    ds2 <- ldply(ds[[4]], function(x) {
 		data.frame(x)
    })
    ds2
}
