\name{ee_search}
\alias{ee_search}
\title{ee search}
\usage{
ee_search(query = NULL, foptions = list())
}
\arguments{
  \item{query}{search term}

  \item{foptions}{= list() Additional (optional) arguments
  to httr}
}
\description{
Search the ecoengine
}
\examples{
\dontrun{
ee_search(query = "genus:Lynx", facet.field = "Genus")
}
}
\keyword{search}

