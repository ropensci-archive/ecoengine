\name{holos_sensor_agg}
\alias{holos_sensor_agg}
\title{sensor aggregation}
\usage{
  holos_sensor_agg(page = NULL, min_date = NULL,
    max_date = NULL, foptions = list())
}
\arguments{
  \item{page}{page number}

  \item{min_date}{stuff}

  \item{max_date}{stuff}

  \item{foptions}{additional arguments for Curl}
}
\description{
  Aggregated sensor data
}
\examples{
\dontrun{
holos_sensor_agg(min = "1994-04-04", max="2001-01-01")
}
}

