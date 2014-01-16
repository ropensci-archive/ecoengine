\name{ee_observations}
\alias{ee_observations}
\title{Ecoengine observations}
\usage{
ee_observations(..., page_size = 25, page = NULL)
}
\arguments{
  \item{...}{all the arguments that get passed to
  \code{\link{ee_observations_get}}}

  \item{page}{Page number}

  \item{page_size}{The number of observations per page
  returned by the query. The package default is \code{25}
  observations. The API default, however, is \code{10}.
  Setting this number higher will require fewer calls (i.e.
  pages) but a large size may also fail or timeout.}
}
\description{
Retrieves observation records from BigCB
}
\examples{
\dontrun{
pinus_first_page <- ee_observations(scientific_name_exact = "Pinus", page = 1)
pinus_two_page <- ee_observations(scientific_name_exact = "Pinus", page = 1:2)
}
}
\seealso{
\code{\link{ee_observations_get}}
}

