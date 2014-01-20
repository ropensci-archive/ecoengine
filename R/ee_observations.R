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
#' @param  bbox Set a bounding box for your search. Use format \code{bbox=-124,32,-114,42}
#' @param  quiet Default is \code{FALSE}. Set to \code{TRUE} to supress messages.
#' @template foptions
#' @template progress
#' @export
#' @return \code{data.frame}
#' @importFrom httr content GET 
#' @importFrom utils txtProgressBar setTxtProgressBar
#' @importFrom plyr compact
#' @examples 
#' us <- ee_observations(country = "United States")
#' pinus <- ee_observations(scientific_name = "Pinus")
#' lynx_data <- ee_observations(genus = "Lynx")
#' # Georeferenced data only
#' \dontrun{
#' lynx_data <- ee_observations(genus = "Lynx", georeferenced = TRUE)
#' animalia <- ee_observations(kingdom = "Animalia")
#' Artemisia <- ee_observations(scientific_name = "Artemisia douglasiana")
#' asteraceae <- ee_observationss(family = "asteraceae")
#' vulpes <- ee_observations(genus = "vulpes")
#' Anas <- ee_observations(scientific_name = "Anas cyanoptera", page = "all")
#' loons <- ee_observations(scientific_name = "Gavia immer", page = "all")
#' plantae <- ee_observations(kingdom = "plantae")
#' chordata <- ee_observations(phylum = "chordata")
#' # Class is clss since the former is a reserved keyword in SQL.
#' aves <- ee_observations(clss = "aves")
#'}
ee_observations <- function(page = NULL, page_size = 25, country = "United States", state_province = NULL, county = NULL, kingdom  = NULL, phylum = NULL, order  = NULL, clss = NULL, family = NULL, genus = NULL, scientific_name = NULL, kingdom__exact = NULL ,phylum__exact = NULL, order__exact = NULL, clss__exact = NULL, family__exact = NULL, genus__exact = NULL, scientific_name__exact = NULL, remote_id = NULL, collection_code = NULL, source  = NULL, min_date = NULL, max_date = NULL, georeferenced = FALSE, bbox = NULL, quiet = FALSE, progress = TRUE, foptions = list()) {
 obs_url <- "http://ecoengine.berkeley.edu/api/observations/?format=json"

if(georeferenced) georeferenced = "True"

args <- as.list(compact(c(country = country, kingdom = kingdom, phylum = phylum,order = order, clss = clss,family = family, genus  = genus, scientific_name = scientific_name, kingdom__exact = kingdom__exact, phylum__exact = phylum__exact, order__exact = order__exact, clss__exact = clss__exact ,family__exact = family__exact , genus__exact  = genus__exact, scientific_name__exact = scientific_name__exact, remote_id = remote_id, collection_code = collection_code, source = source, min_date = min_date, max_date = max_date, georeferenced = georeferenced, page_size = page_size)))
if(is.null(page)) { page <- 1 }
main_args <- args
main_args$page <- as.character(page)
data_sources <- GET(obs_url, query = args, foptions)
stop_for_status(data_sources)
obs_data <- content(data_sources)

required_pages <- ee_paginator(page, obs_data$count)


if(!quiet)  message(sprintf("Search contains %s observations (downloading %s of %s pages)", obs_data$count, length(required_pages), max(required_pages)))
if(progress) pb <- txtProgressBar(min = 0, max = length(required_pages), style = 3)


    results <- list()
    for(i in required_pages) {
    	args$page <- i 
    	data_sources <- GET(obs_url, query = args, foptions)
    	obs_data <- content(data_sources)
    	obs_results <- obs_data$results
    	obs_df_cleaned <- ldply(obs_results, function(x) {
							 x$begin_date <- ifelse(is.null(x$begin_date), "NA", x$begin_date)
							 x$end_date <- ifelse(is.null(x$end_date), "NA", x$end_date)

							 if(is.null(x[[10]])) { 
							 geo_data <- data.frame(geojson.type ="NA", geojson.coordinates1 ="NA", geojson.coordinates2 ="NA")	
							 } else {
                             geo_data <- data.frame(t(unlist(x[10])))
                             }
                             main_data <- (x[-10])
                             main_data$end_date <- ifelse(is.null(main_data$end_date), "NA", main_data$end_date)
                             md <-(data.frame((main_data)))
                             cbind(md, geo_data)
                            })
    	results[[i]] <- obs_df_cleaned
        if(progress) setTxtProgressBar(pb, i)
   		if(i %% 25 == 0) Sys.sleep(2) 
    }
    
	obs_data_all <- do.call(rbind, results)
    names(obs_data_all)[which(names(obs_data_all)=="geojson.coordinates1")] <- "latitude"
    names(obs_data_all)[which(names(obs_data_all)=="geojson.coordinates2")] <- "longitude"
observation_results <- list(results = obs_data$count, call = main_args, type = "observations", data = obs_data_all)

class(observation_results) <- "ecoengine"
if(progress) close(pb)

observation_results
}







