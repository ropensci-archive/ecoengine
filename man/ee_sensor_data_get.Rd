\name{ee_sensor_data_get}
\alias{ee_sensor_data_get}
\title{Sensor data get}
\usage{
ee_sensor_data_get(sensor_id = NULL, page = NULL, page_size = 25,
  quiet = FALSE, foptions = list())
}
\arguments{
  \item{sensor_id}{The id of the sensor.}

  \item{page}{Page number}

  \item{page_size}{The number of observations per page
  returned by the query. The package default is \code{25}
  observations. The API default, however, is \code{10}.
  Setting this number higher will require fewer calls (i.e.
  pages) but a large size may also fail or timeout.}

  \item{quiet}{Default is \code{FALSE}. Set to \code{TRUE}
  to suppress output.}

  \item{foptions}{A list of additional arguments for
  \code{httr}. Used for diagnostic reasons.}
}
\description{
Retrieves data for any sensor returned by
\code{\link{ee_list_sensors}}.
}
\examples{
\dontrun{
full_sensor_list <- ee_sensors()
x <- ee_list_sensors()$record
z <- ee_sensor_data_get(x[1], page = 2)
z1 <- ee_sensor_data_get(x, page = 3)
}
}

