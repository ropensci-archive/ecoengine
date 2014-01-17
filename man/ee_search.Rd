\name{ee_search}
\alias{ee_search}
\title{Ecoengine search}
\usage{
ee_search(query = NULL, foptions = list())
}
\arguments{
  \item{query}{search term}

  \item{foptions}{A list of additional arguments for
  \code{httr}. There is no reason to use this argument
  except for debugging purposes.}
}
\description{
Search across the entire ecoengine database.
}
\examples{
\dontrun{
lynx_results <- ee_search(query = "genus:Lynx")
}
}
\keyword{search}

