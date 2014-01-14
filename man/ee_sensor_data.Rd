\name{ee_sensor_data}
\alias{ee_sensor_data}
\title{sensor data}
\usage{
ee_sensor_data(...)
}
\arguments{
  \item{...}{All argument that get passed to
  \code{\link{ee_sensor_data_get}} This function is a
  wrapper around \code{\link{ee_sensor_data_get}}. Allows a
  user to request several pages worth of data.}
}
\description{
sensor data
}
\examples{
\dontrun{
full_sensor_list <- ee_sensors()
x <- full_sensor_list[1, ]$data_url
sensor_data <- ee_sensor_data(data_url = x,  page = 1:2)
sensor_data_3 <- ee_sensor_data(data_url = x,  page = 1)
}
}
\seealso{
\code{\link{ee_sensors})}
}

