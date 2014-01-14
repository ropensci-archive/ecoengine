\name{ee_sensors}
\alias{ee_sensors}
\title{ee sensors}
\usage{
ee_sensors(..., page_size = 25)
}
\arguments{
  \item{...}{same arguments as \code{\link{ee_sensors}}.
  Use this function over ee_sensors_get.}

  \item{page_size}{Number of observations per page}
}
\value{
data.frame
}
\description{
Returns a full list of sensors with available data
}
\examples{
\dontrun{
# This call will return a full set of available sensors.
full_sensor_list <- ee_sensors()
}
}

