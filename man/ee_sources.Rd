\name{ee_sources}
\alias{ee_sources}
\title{Ecoengine data sources}
\usage{
ee_sources(foptions = list())
}
\arguments{
  \item{foptions}{A list of additional arguments for
  \code{httr}. Used for diagnostic reasons.}
}
\value{
\code{data.frame}
}
\description{
Returns a full list of data source supported by the
ecoengine
}
\examples{
\dontrun{
source_list <- ee_sources()
}
}

