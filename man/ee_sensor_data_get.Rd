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
  \code{httr}. There is no reason to use this argument
  except for debugging purposes.}
}
\description{
Retrieves data for any sensor returned by
\code{\link{ee_list_sensors}}.
}
\examples{
\dontrun{
full_sensor_list <- ee_sensors()
station <- ee_list_sensors()$record
page_1_data <- ee_sensor_data_get(station[1], page = 2)
page_2_data <- ee_sensor_data_get(station[1], page = 3)
}
}

