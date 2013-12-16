

#'<brief desc>
#'
#'<full description>
#' @param  subject Enter one of the following subjects: Mammals, Mosses, Beetles, Spiders, Amphibians, Ants, Fungi, Lichen, Plants.
#' @param  foptions = list() <what param does>
#' @export
#' @importFrom assertthat assert_that
#' @return data.frame
#' @examples \dontrun{
#' mammals_list  <- holos_checklists(subject = "Mammals")
#'}
holos_checklists <- function(subject = NULL, foptions = list()) {
	base_url <- "http://ecoengine.berkeley.edu/api/checklists/"
	
	# assert_that(is.character(subject))

	subk <- switch(subject,
					"Mammals"    = "bigcb:specieslist:1",
					"Mosses"     = "bigcb:specieslist:13",
					"Beetles"    = "bigcb:specieslist:14",
					"Spiders"    = "bigcb:specieslist:15",
					"Amphibians" = "bigcb:specieslist:16",
					"Ants"       = "bigcb:specieslist:17",
					"Fungi"      = "bigcb:specieslist:18",
					"Lichen"     = "bigcb:specieslist:19",
					"Plants"     = "bigcb:specieslist:2",
					"Spiders"    = "bigcb:specieslist:20"
					)
	if(is.null(subject)) base_url <- paste0(base_url, "?format=json")
	if(!is.null(subject)) base_url <- paste0(base_url, subk, "?format=json")	
	args <- list(subject = subk)
	checklist_sources <- GET(base_url, query = args, foptions)
    stop_for_status(checklist_sources)
    checklist_results <- content(checklist_sources)
    # Returns 11 items. Below is the example for mosses
				# "bigcb:specieslist:13"
				# "Mosses"
				# "http://ecoengine.berkeley.edu/api/sources/18/"
				# "http://bigcb.berkeley.edu/cgi/bigcb_speclist_show?ListID=13"
				# "1975-01-01T00:00:00"
				# "1975-12-31T00:00:00"
				# "California"
				# ""
				# "http://ecoengine.berkeley.edu/api/footprints/angelo-reserve/"
				# "Dr. Thomas and S.F. State U. class"
    # # 
    checklist_results <- as.data.frame(do.call(rbind, checklist_results[[11]]))
	full_checklist_results <- llply(checklist_results[[2]], function(x) {
    	   full_url <- paste0(x, "?format=json")
    	   data <- content(GET(full_url))
    })
    complete_checklist <- as.data.frame(do.call(rbind, full_checklist_results))
}

# x1 <- holos_checklists(subject = "Mammals")
# x2 <- holos_checklists(subject = "Plants")
# x3 <- holos_checklists(subject = "Amphibians")

# holos_checklists()
# holos_checklists(subject = "Mosses")

# Todos
# Function works for now.  But need to give it the full list of arguments.
# 


# holos_checklists<- function(page = NULL,
#                          kingdom = NULL,
#                          phylum = NULL, 
#                          order = NULL,
#                          clss = NULL,
#                          family = NULL,
#                          genus = NULL, 
#                          scientific_name = NULL, 
#                          authors = NULL, 
#                          remote_id = NULL, 
#                          collection_code = NULL, 
#                          source  = NULL, 
#                          min_date = NULL, 
#                          max_date = NULL, 
#                         foptions = list()) {
#     base_url <- "http://ecoengine.berkeley.edu/api/checklists/?format=json"
#     args <- as.list(compact(c(page = page,                       
#                             kingdom = kingdom, 
#                             phylum = phylum, 
#                             order = order, 
#                             clss = clss, 
#                             family = family, 
#                             genus = genus, 
#                             scientific_name = scientific_name, 
#                             authors = authors, 
#                             remote_id = remote_id, 
#                             collection_code = collection_code, 
#                             source  = source , 
#                             min_date = min_date, 
#                             max_date = max_date
#    							)))
#     checklist_sources <- GET(base_url, foptions)
#     stop_for_status(checklist_sources)
#     checklist_results <- content(checklist_sources)
#     # Returns 11 items. Below is the example for mosses
# 				# [1] "bigcb:specieslist:13"
# 				# [1] "Mosses"
# 				# [1] "http://ecoengine.berkeley.edu/api/sources/18/"
# 				# [1] "http://bigcb.berkeley.edu/cgi/bigcb_speclist_show?ListID=13"
# 				# [1] "1975-01-01T00:00:00"
# 				# [1] "1975-12-31T00:00:00"
# 				# [1] "California"
# 				# [1] ""
# 				# [1] "http://ecoengine.berkeley.edu/api/footprints/angelo-reserve/"
# 				# [1] "Dr. Thomas and S.F. State U. class"
#     # # 
#     checklist_results <- as.data.frame(do.call(rbind, checklist_results[[11]]))
#     checklist_results
# }
# holos_checklists(kingdom = "Animalia")





