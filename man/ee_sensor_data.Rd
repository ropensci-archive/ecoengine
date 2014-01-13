\name{ee_sensor_data}
\alias{ee_sensor_data}
\title{sensor data}
\usage{
ee_sensor_data(data_url = NULL, page = NULL, page_size = 25,
  foptions = list())
}
\arguments{
  \item{data_url}{The URL returned by
  \code{\link{ee_sensors}}}

  \item{page}{Requested page. Can specify a single page
  (e.g. \code{1}), a range (\code{1:2}), or "all"}

  \item{page_size}{Default number of observations per page
  is 25.}

  \item{foptions}{Additional arugments to httr}
}
\description{
Request data from any of the sensors binned at various
intervals
}
\examples{
\dontrun{
full_sensor_list <- ee_sensors()
x <- full_sensor_list[1, ]$data_url
sensor_data <- ee_sensor_data(data_url = x, page = 1:2)
}
}
\seealso{
\code{\link{ee_sensors})}
}

