
#' Print a summary for an ecoengine object
#' @method print ecoengine
#' @S3method print ecoengine
#' @param x An object of class \code{ecoengine}
#' @param ... additional arguments
print.ecoengine <- function(x, ...) {
    value <- NA

	string <- "Number of results: %s \n Call: %s \n Output dataset: %s rows"
    vals   <- c(x$results,  x$call, nrow(x$data))
    cat(do.call(sprintf, as.list(c(string, vals))))
    cat("\n")
}



#' Plots metrics for an ecoengine object
#' 
#' @method plot ecoengine
#' @S3method plot ecoengine
#' @param x An object of class \code{ecoengine}
#' @param ... additional arguments
plot.ecoengine <- function(x, ...) {

value <- NA
# just to trick check()    
if (!is(x, "ecoengine"))   
    stop("Not an ecoengine object")
# Rest of this is not coded up. 
# Will have to figure out what to plot on a case by case basis or possibily ditch this.

}



