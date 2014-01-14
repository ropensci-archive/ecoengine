\name{ee_sensor_data_get}
\alias{ee_sensor_data_get}
\title{Sensor data get}
\usage{
ee_sensor_data_get(data_url = NULL, page = NULL, page_size = 25,
  quiet = FALSE, foptions = list())
}
\arguments{
  \item{data_url}{The URL returned by
  \code{\link{ee_sensors}}}

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
\code{\link{ee_sensors}}.
}
\examples{
\dontrun{
full_sensor_list <- ee_sensors()
x <- full_sensor_list[1, ]$data_url
z <- ee_sensor_data_get(x, page = 2)
z1 <- ee_sensor_data_get(x, page = 3)
}
}

