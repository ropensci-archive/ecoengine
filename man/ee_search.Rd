\name{ee_search}
\alias{ee_search}
\title{ee search}
\usage{
ee_search(query = NULL, foptions = list())
}
\arguments{
  \item{query}{search term}

  \item{foptions}{A list of additional arguments for
  \code{httr}. Used for diagnostic reasons.}
}
\description{
Search the ecoengine
}
\examples{
\dontrun{
ee_search(query = "genus:Lynx")
}
}
\keyword{search}

