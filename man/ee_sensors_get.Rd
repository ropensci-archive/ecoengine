\name{ee_sensors_get}
\alias{ee_sensors_get}
\title{ee_sensors_get}
\usage{
ee_sensors_get(page = NULL, page_size = 25, remote_id = NULL,
  collection_code = NULL, source = NULL, min_date = NULL,
  max_date = NULL, foptions = list())
}
\arguments{
  \item{page}{Page number}

  \item{page_size}{The number of observations per page
  returned by the query. The package default is \code{25}
  observations. The API default, however, is \code{10}.
  Setting this number higher will require fewer calls (i.e.
  pages) but a large size may also fail or timeout.}

  \item{remote_id}{Need to describe these parameters}

  \item{collection_code}{Type of collection. Can be
  \code{CalAcademy}, \code{Private}, \code{VTM},
  \code{CDFA}. \code{CalFlora} Others TBA}

  \item{source}{Need to describe these parameters}

  \item{min_date}{Need to describe these parameters}

  \item{max_date}{Need to describe these parameters}

  \item{foptions}{A list of additional arguments for
  \code{httr}. Used for diagnostic reasons.}
}
\description{
Returns UC reserve system sensor data
}
\examples{
\dontrun{
Currently there are only 40 sensors, so request only needs to be pages 1 and 2.
ee_sensors_get()
s1 <- ee_sensors_get(page = 1)
s2 <- ee_sensors_get(page = 2)
}
}

