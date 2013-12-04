
#' Observations List
#'
#'API endpoint that represents a list of observations. Prameter options have not been fleshed out yet
#' @param country description needed.
#' @param  state_province description needed.
#' @param  county description needed.
#' @param  kingdom  description needed.
#' @param  phylum description needed.
#' @param  order  description needed.
#' @param  clss description needed.
#' @param  family description needed.
#' @param  genus description needed.
#' @param  scientific_name description needed.
#' @param  remote_id description needed.
#' @param  collection_code description needed.
#' @param  source  description needed.
#' @param  min_date description needed.
#' @param  max_date description needed.
#' @param  page  Page numberdescription needed.
#' @param  foptions description needed.
#' @export
#' @return \code{data.frame}
#' @import httr content GET 
#' @import plyr compact
#' @examples \dontrun{
#' holos_observations(country = "United States")
#'}
holos_observations <- function(country = "United States", state_province = NULL, county = NULL, kingdom  = NULL, phylum = NULL, order  = NULL, clss = NULL, family = NULL, genus = NULL, scientific_name = NULL, remote_id = NULL, collection_code = NULL, source  = NULL, min_date = NULL, max_date = NULL, page = NULL, foptions = list()) {
 obs_url <- "http://ecoengine.berkeley.edu/api/observations/?format=json"
 args <- as.list(compact(c(country = country, kingdom = kingdom,phylum = phylum,order = order, clss = clss,family = family, genus  = genus, scientific_name = scientific_name,remote_id = remote_id, collection_code = collection_code, source = source, min_date = min_date, max_date = max_date, page = page)))
data_sources <- GET(obs_url, query = args, foptions)
stop_for_status(data_sources)
obs_data <- content(data_sources)
message(sprintf("%s observations found", obs_data[[1]]))
# The data are already returned in a nice list that include
# number of results, the everything in appropriate slots.
obs_df <- as.data.frame(do.call(rbind, obs_data[[4]]))
return(obs_df)
}
# Testing locally first.
# xx <- holos_observations(country = "United States")



