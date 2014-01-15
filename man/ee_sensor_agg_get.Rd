\name{ee_sensor_agg_get}
\alias{ee_sensor_agg_get}
\title{sensor aggregation}
\usage{
ee_sensor_agg_get(sensor_id = NULL, page = NULL, page_size = 25,
  hours = NULL, minutes = NULL, seconds = NULL, days = NULL,
  weeks = NULL, month = NULL, years = NULL, min_date = NULL,
  max_date = NULL, quiet = FALSE, foptions = list())
}
\arguments{
  \item{page}{Page number}

  \item{page_size}{The number of observations per page
  returned by the query. The package default is \code{25}
  observations. The API default, however, is \code{10}.
  Setting this number higher will require fewer calls (i.e.
  pages) but a large size may also fail or timeout.}

  \item{min_date}{Need to describe these parameters}

  \item{max_date}{Need to describe these parameters}

  \item{sensor_id}{The id of the sensor.}

  \item{hours}{Time interval in hours}

  \item{minutes}{Time interval in minutes}

  \item{seconds}{Time interval in seconds}

  \item{days}{Time interval in days}

  \item{weeks}{Time interval in weeks}

  \item{month}{Time interval in months}

  \item{years}{Time interval in years}

  \item{quiet}{Default is \code{FALSE}. Set to \code{TRUE}
  to suppress messages.}

  \item{foptions}{A list of additional arguments for
  \code{httr}. Used for diagnostic reasons.}
}
\description{
Aggregated sensor_id ID of desired sensor. See
\code{\link{ee_list_sensors}} for a list.
}
\examples{
\dontrun{
aggregated_data <-  ee_sensor_agg_get(sensor_id = 1625, weeks = 2)
}
}

