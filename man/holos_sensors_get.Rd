\name{holos_sensors_get}
\alias{holos_sensors_get}
\title{holos_sensors}
\usage{
  holos_sensors_get(page = NULL, remote_id = NULL,
    collection_code = NULL, source = NULL, min_date = NULL,
    max_date = NULL, foptions = list())
}
\arguments{
  \item{page}{page number}

  \item{remote_id}{Need to describe these parameters}

  \item{collection_code}{Type of collection. Can be
  \code{CalAcademy}, \code{Private}, \code{VTM},
  \code{CDFA}. \code{CalFlora} Others TBA}

  \item{source}{Need to describe these parameters}

  \item{min_date}{Need to describe these parameters}

  \item{max_date}{Need to describe these parameters}

  \item{foptions}{A list of additional arguments. Currently
  this function takes none.}
}
\description{
  Returns UC reserve system sensor data
}
\examples{
\dontrun{
holos_sensors_get()
holos_sensors_get(page = 40)
}
}

