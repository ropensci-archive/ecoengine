

#' Holos search
#'
#' Search the ecoengine
#' @param query search term
#' @param facet Field to facet on. Possibilities include: kingdom, genus, family, clss, phylum
#' @param  foptions = list() Additional (optional) arguments to httr
#' @export
#' @importFrom solr solr_facet
#' @examples \dontrun{
#' holos_search(query = "Pinus", facet = "Genus")
#'}
holos_search <- function(query = NULL, facet = NULL, foptions = list()) {
search_url <- "http://ecoengine.berkeley.edu/api/search/"
browser()
# this fails
result <- solr_facet(q = query, facet.field = facet, url = search_url)
}

# Notes
# search_url <- "http://ecoengine.berkeley.edu/api/search/?q=genus:Lynx"
# This API call (just the URL) wil work in browser
