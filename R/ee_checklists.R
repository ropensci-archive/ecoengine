

#' Ecoengine checklists
#'
#' Retrieves exisitng checklists from the ecoengine database
#' @param  subject Enter one of the following subjects: Mammals, Mosses, Beetles, Spiders, Amphibians, Ants, Fungi, Lichen, Plants.
#' @template foptions
#' @export
#' @importFrom assertthat assert_that
#' @importFrom plyr ldply
#' @importFrom httr GET content stop_for_status
#' @return data.frame
#' @examples 
#' all_lists  <- ee_checklists()
#' mammals_list  <- ee_checklists(subject = "Mammals")
#' spiders  <- ee_checklists(subject = "Spiders")
ee_checklists <- function(subject = NULL, foptions = list()) {

	base_url <- "http://ecoengine.berkeley.edu/api/checklists/?format=json"
	full_checklist <- GET(base_url, foptions)
	stop_for_status(full_checklist)
	checklist_data <- content(full_checklist)
	args <- as.list(ee_compact(c(page_size = checklist_data$count)))
	all_data <- GET(base_url, query = args, foptions)
	stop_for_status(all_data)
	all_checklists <- content(all_data)
	# all_checklists_df <- rbind_all(all_checklists$results)
	all_checklists_df <- ldply(all_checklists$results, function(x) data.frame(x))
	if(!is.null(subject)) {
	subject <- eco_capwords(subject)
	sub_result <- all_checklists_df[grep(subject, all_checklists_df$subject), ]
	message(sprintf("Returning %s checklists", nrow(sub_result)))
	return(sub_result)
	} else {
		message(sprintf("Returning %s checklists", all_checklists$count))
		all_checklists_df
	}
}



#'Checklist details
#'
#' Will return details on any checklist 
#' @param list_name URL of a checklist
#' @param  ... Additional arguments (currently not implemented)
#' @importFrom dplyr rbind_all
#' @export
#' @seealso \code{\link{ee_checklists}}
#' @return \code{data.frame}
#' @examples \dontrun{
#' spiders  <- ee_checklists(subject = "Spiders")
#' # Now retrieve all the details for each species on both lists
#' library(plyr) 
#' spider_details <- ldply(spiders$url, checklist_details)
#'}
checklist_details <- function(list_name, ...) {

details <- GET(paste0(list_name, "?format=json"))
details_data <- content(details)
first_results <- rbind_all(details_data$observations)
first_results$url <- paste0(first_results$url, "?format=json")
# Now fetch all the results from the URL (2nd column)
full_results <- lapply(first_results$url, function(x) {
				full_checklist <- content(GET(x))
			    rbindfillnull(full_checklist)
})
rbind_all(full_results)
}


# Function to capitalize words
#' @noRd
eco_capwords <- function(s, strict = FALSE, onlyfirst = FALSE) {
        cap <- function(s) paste(toupper(substring(s,1,1)),
                {s <- substring(s,2); if(strict) tolower(s) else s}, sep="", collapse=" " )
  if(!onlyfirst){
    sapply(strsplit(s, split = " "), cap, USE.NAMES = !is.null(names(s)))
  } else
  {
   sapply(s, function(x) paste(toupper(substring(x,1,1)),tolower(substring(x,2)),sep = "", collapse = " "), USE.NAMES = F)
  }
}
