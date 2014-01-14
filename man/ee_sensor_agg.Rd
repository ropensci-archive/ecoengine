\name{ee_sensor_agg}
\alias{ee_sensor_agg}
\title{sensor aggregation}
\usage{
ee_sensor_agg(page = NULL, page_size = 25, min_date = NULL,
  max_date = NULL, foptions = list())
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

  \item{foptions}{A list of additional arguments for
  \code{httr}. Used for diagnostic reasons.}
}
\description{
Aggregated sensor data
}
\examples{
\dontrun{
ee_sensor_agg(min = "1994-04-04", max="2001-01-01")
}
}

