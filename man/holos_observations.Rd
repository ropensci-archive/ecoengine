\name{holos_observations}
\alias{holos_observations}
\title{Observations List}
\usage{
holos_observations(country = "United States", state_province = NULL,
  county = NULL, kingdom = NULL, phylum = NULL, order = NULL,
  clss = NULL, family = NULL, genus = NULL, scientific_name = NULL,
  remote_id = NULL, collection_code = NULL, source = NULL,
  min_date = NULL, max_date = NULL, page = NULL, foptions = list())
}
\arguments{
  \item{country}{description needed.}

  \item{state_province}{description needed.}

  \item{county}{description needed.}

  \item{kingdom}{description needed.}

  \item{phylum}{description needed.}

  \item{order}{description needed.}

  \item{clss}{description needed.}

  \item{family}{description needed.}

  \item{genus}{description needed.}

  \item{scientific_name}{description needed.}

  \item{remote_id}{description needed.}

  \item{collection_code}{description needed.}

  \item{source}{description needed.}

  \item{min_date}{description needed.}

  \item{max_date}{description needed.}

  \item{page}{Page numberdescription needed.}

  \item{foptions}{description needed.}
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

