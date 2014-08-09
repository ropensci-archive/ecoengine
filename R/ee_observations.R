#' Observations List
#'
#'API endpoint that represents a list of observations.
#' @template pages
#' @param country country name
#' @param  state_province description needed.
#' @param  county California county. See \code{data(california_counties)}
#' @param  kingdom  kingdom name
#' @param  phylum phylum name
#' @param  order order name
#' @param  clss class name
#' @param  family family name
#' @param  genus genus name.
#' @param  scientific_name A full scientific name
#' @param  kingdom__exact  exact kingdom name
#' @param  phylum__exact exact phylum name
#' @param  order__exact  exact order name
#' @param  clss__exact class name
#' @param  family__exact exact family name
#' @param  genus__exact exact genus name
#' @param  scientific_name__exact exact scientific name
#' @param  remote_id remote ID
#' @param  collection_code collections code
#' @param  source  data source. See \code{\link{ee_sources}}
#' @template dates
#' @param  georeferenced Default is \code{FALSE}. Set to \code{TRUE} to return only georeferenced records.
#' @param  bbox Set a bounding box for your search. Use format \code{bbox=-124,32,-114,42}. Order is min Longitude , min Latitude , max Longitude , max Latitude. Use \code{http://boundingbox.klokantech.com/} this website to quickly grab a bounding box (set format to csv on lower right) 
#' @param exclude Default is \code{NULL}. Pass a list of fields to exclude.
#' @param  quiet Default is \code{FALSE}. Set to \code{TRUE} to supress messages.
#' @template foptions
#' @template progress
#' @export
#' @return \code{data.frame}
#' @importFrom httr content GET 
#' @importFrom utils txtProgressBar setTxtProgressBar
#' @importFrom plyr compact
#' @importFrom lubridate ymd
#' @examples 
#' # vulpes <- ee_observations(genus = "vulpes")
#' \dontrun{
#' pinus <- ee_observations(scientific_name = "Pinus", page_size = 100)
#' # lynx_data <- ee_observations(genus = "Lynx")
#' # Georeferenced data only
#' # lynx_data <- ee_observations(genus = "Lynx", georeferenced = TRUE)
#' # animalia <- ee_observations(kingdom = "Animalia")
#' # Artemisia <- ee_observations(scientific_name = "Artemisia douglasiana")
#' # asteraceae <- ee_observationss(family = "asteraceae")
#' # vulpes <- ee_observations(genus = "vulpes")
#' # Anas <- ee_observations(scientific_name = "Anas cyanoptera", page = "all")
#' # loons <- ee_observations(scientific_name = "Gavia immer", page = "all")
#' # plantae <- ee_observations(kingdom = "plantae")
#' # chordata <- ee_observations(phylum = "chordata")
#' # Class is clss since the former is a reserved keyword in SQL.
#' # aves <- ee_observations(clss = "aves")
#' # aves <- ee_observations(clss = "aves", bbox = '-124,32,-114,42')
#' # aves <- ee_observations(clss = "aves", county = "Alameda county")
#'}
ee_observations <- function(page = NULL, page_size = 1000, country = "United States", state_province = NULL, county = NULL, kingdom  = NULL, phylum = NULL, order  = NULL, clss = NULL, family = NULL, genus = NULL, scientific_name = NULL, kingdom__exact = NULL ,phylum__exact = NULL, order__exact = NULL, clss__exact = NULL, family__exact = NULL, genus__exact = NULL, scientific_name__exact = NULL, remote_id = NULL, collection_code = NULL, source  = NULL, min_date = NULL, max_date = NULL, georeferenced = FALSE, bbox = NULL, exclude = NULL, quiet = FALSE, progress = TRUE, foptions = list()) {
 # obs_url <- "http://ecoengine.berkeley.edu/api/observations/?format=json"
 obs_url <- paste0(ee_base_url(), "observations/?format=geojson")

if(georeferenced) georeferenced = "True"

args <- as.list(ee_compact(c(country = country, kingdom = kingdom, phylum = phylum,order = order, clss = clss,family = family, genus  = genus, scientific_name = scientific_name, kingdom__exact = kingdom__exact, phylum__exact = phylum__exact, county = county, order__exact = order__exact, clss__exact = clss__exact ,family__exact = family__exact , genus__exact  = genus__exact, scientific_name__exact = scientific_name__exact, remote_id = remote_id, collection_code = collection_code, source = source, min_date = min_date, max_date = max_date, bbox = bbox, exclude = exclude, georeferenced = georeferenced, page_size = page_size)))
if(is.null(page)) { page <- 1 }
main_args <- args
main_args$page <- as.character(page)
data_sources <- GET(obs_url, query = args, foptions)
warn_for_status(data_sources)
obs_data <- content(data_sources, type = "application/json")

required_pages <- ee_paginator(page, obs_data$count, page_size = page_size)
all_the_pages <- ceiling(obs_data$count/page_size)

if(!quiet)  message(sprintf("Search contains %s observations (downloading %s of %s pages)", obs_data$count, length(required_pages), all_the_pages))
if(progress) pb <- txtProgressBar(min = 0, max = length(required_pages), style = 3)


    results <- list()
    for(i in required_pages) {
        args$page <- i 
        data_sources <- GET(obs_url, query = args, foptions)
        obs_data <- content(data_sources, type = "application/json")
        obs_results <- lapply(obs_data$features, LinearizeNestedList)
        obs_df_cleaned <- lapply(obs_results, function(x) {
                             x$`properties/begin_date` <- ifelse(is.null(x$`properties/begin_date`), "NA", x$`properties/begin_date`)
                             x$`properties/end_date` <- ifelse(is.null(x$`properties/end_date`), "NA", x$`properties/end_date`)
                             # if(x$type == "Feature") {
                             #    x$`geometry/coordinates/1` = x$`geometry/coordinates/2` = NA
                             # }
                             x
                            })
        # bug is here
        obs_df <- lapply(obs_df_cleaned, function(x) {
            data.frame(t(unlist(x)))
        })
        obs_cleaned_df <- do.call(rbind.fill, obs_df)

        results[[i]] <- obs_cleaned_df
        if(progress) setTxtProgressBar(pb, i)
    }
    obs_data_all <- do.call(rbind, results)
    obs_data_all$geometry.type  <- NULL
    names(obs_data_all) <- gsub("properties.", "", names(obs_data_all))
    names(obs_data_all)[which(names(obs_data_all)=="geometry.coordinates.1")] <- "longitude"
    names(obs_data_all)[which(names(obs_data_all)=="geometry.coordinates.2")] <- "latitude"
    obs_data_all$latitude <- suppressWarnings(as.numeric(as.character(obs_data_all$latitude)))
    obs_data_all$longitude <- suppressWarnings(as.numeric(as.character(obs_data_all$longitude)))
    obs_data_all$begin_date <- suppressWarnings(ymd(as.character(obs_data_all$begin_date)))
    obs_data_all$end_date <- suppressWarnings(ymd(as.character(obs_data_all$end_date)))

observation_results <- list(results = obs_data$count, call = main_args, type = "FeatureCollection", data = obs_data_all)

class(observation_results) <- "ecoengine"
if(progress) close(pb)

observation_results
}







