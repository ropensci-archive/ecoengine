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
<full description>
}
\examples{
\dontrun{
sensor_df <- ee_sensor_agg(sensor_id = 1625, weeks = 2)
sensor_df <- ee_sensor_agg(page = "all", sensor_id = 1625, weeks = 2)
}
}

