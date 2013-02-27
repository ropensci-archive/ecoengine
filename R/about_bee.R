

#'About the Berkeley Ecoinformatics Engine
#'
#' Function returns the current status of fast-evolving API. Returns endpoints and category. Default return is a \code{list} but one can also request a nicely formatted \code{data.frame} by setting the \code{as.df} argument to \code{TRUE}.
#' @param as.df = FALSE Returns a list unless this set to \code{TRUE}
#' @return \code{list}
#' @export
#' @examples \dontrun{
#' about_bee()
#' about_bee(as.df = TRUE)
#'}
about_bee <- function(as.df = FALSE) {
base_url <- "http://ecoengine.berkeley.edu/api/"
 url <- paste0(base_url, "?format=json")
 about <- getURL(url)
 about <- as.list(fromJSON(I(about)))
 if(!as.df) {
    return(about)
    } else {
        about_df <- ldply(about, function(f) {
             res <- as.data.frame(f)
            } )
        names(about_df) <- c("type", "endpoint")
        return(about_df)
    }
}
