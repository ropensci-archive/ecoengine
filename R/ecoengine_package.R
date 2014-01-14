

#' @title ecoengine
#' @name ecoengine
#' @docType package
NULL



#' california_counties
#'
#' A data.frame containing list of California counties. Useful for most functions since the data is primarily state based.
#' @docType data
#' @keywords datasets
#' @name california_counties
#' @usage data(california_counties)
#' @format A data table with 58 rows and 3 variables. Contains county name, FIPS state code (06 in this case) and FIPS county code. See \href{http://en.wikipedia.org/wiki/FIPS_county_code}{Wikipedia} for more information.
NULL

#' full_sensor_list
#'
#' A data.frame containing all the sensors currently available through the engine. This list can be updated anytime by calling the ee_sensors() function. 
#' @docType data
#' @keywords datasets
#' @name full_sensor_list
#' @usage data(full_sensor_list)
#' @format A data table with 40 rows and 13 variables. Contains units, variable, data_url, source, record, site_code,   method_name, begin_date, end_date, station_name, geojson.type, geojson.coordinates1, geojson.coordinates2
NULL

