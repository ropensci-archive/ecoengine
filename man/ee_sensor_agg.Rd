\name{ee_sensor_agg}
\alias{ee_sensor_agg}
\title{Ecoengine sensor aggregations}
\usage{
ee_sensor_agg(...)
}
\arguments{
  \item{...}{all the arguments that get passed to
  \code{\link{ee_sensor_agg_get}}}
}
\description{
Retrieves sensor data. This functions serves as a wrapper
for \code{\link{ee_sensor_agg_get}} and takes the same
arguments along with page options. Page can be a integer, a
range, or "all"
}
\examples{
\dontrun{
sensor_df <- ee_sensor_agg(sensor_id = 1625, weeks = 2)
sensor_df <- ee_sensor_agg(page = "all", sensor_id = 1625, weeks = 2)
}
}

