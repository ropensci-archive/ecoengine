\name{ee_observations}
\alias{ee_observations}
\title{Ecoengine observations}
\usage{
ee_observations(..., page_size = 25, page = NULL)
}
\arguments{
  \item{...}{all the arguments that get passed to
  \code{\link{ee_observations_get}}}

  \item{page}{Page number or range. Use "all" to retrieve
  all pages. May time out for extremely large queries}

  \item{page_size}{The number of observations per page.
  Default is 10. Do not set this too high or the server
  will time out}
}
\description{
Retrieves observation records from BigCB
}
\examples{
\dontrun{
ee_observations(scientific_name_exact = "Pinus", page = 1)
ee_observations(scientific_name_exact = "Pinus", page = 1:2)
}
}
\seealso{
\code{\link{ee_observations_get}}
}

