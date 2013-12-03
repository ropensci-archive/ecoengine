\name{holos_observations}
\alias{holos_observations}
\title{Observations List}
\usage{
  holos_observations(country = "United States",
    state_province = NULL, county = NULL, kingdom = NULL,
    phylum = NULL, order = NULL, clss = NULL,
    family = NULL, genus = NULL, scientific_name = NULL,
    remote_id = NULL, collection_code = NULL,
    source = NULL, min_date = NULL, max_date = NULL,
    page = 1, foptions = list())
}
\arguments{
  \item{type}{= NULL filter by type}
}
\value{
  \code{data.frame}
}
\description{
  API endpoint that represents a list of observations.
  Prameter options have not been fleshed out yet
}
\examples{
\dontrun{
holos_observations(country = "United States")
}
}

