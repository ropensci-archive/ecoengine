
#'sensor aggregation
#'
#' Aggregated sensor data
#' @template pages
#' @template dates
#' @param interval .......
#' @template foptions
#' @export
#' @examples \dontrun{
#' ee_sensor_agg(min = "1994-04-04", max="2001-01-01")
#'}
ee_sensor_agg <- function(page = NULL, page_size = 25, interval = NULL, min_date = NULL, max_date = NULL, foptions = list()) {
	# to be coded.
}

# you can use "interval=x" where x can be years, months, weeks, days, or hours. There is also a way to define a custom range but I'm not sure how that works.

# For example, here is the URL for "Angelo Meadow WS - Solar Radiation Total MJ/m^2" by week:

# http://ecoengine.berkeley.edu/api/sensors/1629/aggregate/?interval=weeks