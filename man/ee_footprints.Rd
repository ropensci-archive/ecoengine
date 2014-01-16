\name{ee_footprints}
\alias{ee_footprints}
\title{ee_footprints}
\usage{
ee_footprints(foptions = list())
}
\arguments{
  \item{foptions}{A list of additional arguments for
  \code{httr}. There is no reason to use this argument
  except for debugging purposes.}
}
\value{
data.frame
}
\description{
List of ecoengine footprints
}
\examples{
\dontrun{
footprints <- ee_footprints()
}
}

