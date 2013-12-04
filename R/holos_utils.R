
#' Print a summary for an holos object
#' @method print holos
#' @S3method print holos
#' @param x An object of class \code{holos}
#' @param ... additional arguments
print.holos <- function(x, ...) {
    value <- NA

	string <- "Number of results: %s \n Call: %s \n Output dataset: %s rows"
    vals   <- c(x$results,  x$call, nrow(x$data))
    cat(do.call(sprintf, as.list(c(string, vals))))
    cat("\n")
}



#' Plots metrics for an holos object
#' 
#' @method plot holos
#' @S3method plot holos
#' @param x An object of class \code{holos}
#' @param ... additional arguments
plot.holos <- function(x, ...) {

value <- NA
# just to trick check()    
if (!is(x, "holos"))   
    stop("Not an holos object")
# Rest of this is not coded up. 
# Will have to figure out what to plot on a case by case basis or possibily ditch this.

}

