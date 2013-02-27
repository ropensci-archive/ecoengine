
#' Observations List
#'
#'API endpoint that represents a list of observations. Prameter options have not been fleshed out yet
#' @param type = NULL filter by type
#' @export
#' @return \code{data.frame}
#' @import plyr RCurl RJSONIO
#' @examples \dontrun{
#' observation()
#'}
bee_observations <- function(type = NULL) {
 base_url <- "http://ecoengine.berkeley.edu/api/"
 url <- paste0(base_url, "?format=json")
 # Will flesh this out next when I get a bigger chunk of time
}
