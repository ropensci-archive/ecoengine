\name{holos_observations}
\alias{holos_observations}
\title{Holos observations}
\usage{
holos_observations(..., page_size = NULL, page = NULL)
}
\arguments{
  \item{...}{all the arguments that get passed to
  \code{\link{holos_observations_get}}}

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
holos_observations(scientific_name_exact = "Pinus", page = 1)
holos_observations(scientific_name_exact = "Pinus", page = 1:2)
}
}
\seealso{
\code{\link{holos_observations_get}}
}

