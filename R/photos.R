

holos_photos <- function(page = NULL, foptions=list()) {
	# function isn't ready.	
	# list of possible arguments
	# state_province
	# county
	# genus
	# scientific_name
	# authors
	# remote_id
	# collections_code
	# source 
	# min_date
	# max_date
	# related_type
	# related 
	# other_catalog_numbers

	photos_url <- "http://ecoengine.berkeley.edu/api/photos/?format=json"
	args <- as.list(compact(c(page = page)))
	data_sources <- GET(photos_url, query = args, foptions)
    stop_for_status(data_sources)
    ds <- content(data_sources)
    ds

	# possible outputs:
	# 	author
	# 	date_range
	# 	notes
	# 	media_url
	# 	url
	# 	associated_observations
}
holos_photos()


# To do:
# Implement search
# Return nicely formatted tables of data
# Allow viewing images from within R 