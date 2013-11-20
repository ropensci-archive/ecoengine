\name{about_bee}
\alias{about_bee}
\title{About the Berkeley Ecoinformatics Engine}
\usage{
  about_bee(as.df = TRUE, type = NA)
}
\arguments{
  \item{as.df}{= FALSE Returns a list unless this set to
  \code{TRUE}}
}
\value{
  \code{list}
}
\description{
  Function returns the current status of fast-evolving API.
  Returns endpoints and category. Default return is a
  \code{list} but one can also request a nicely formatted
  \code{data.frame} by setting the \code{as.df} argument to
  \code{TRUE}.
}
\examples{
\dontrun{
about_bee()
# set \\code{as.df = FALSE} to return a \\code{list} rather than a \\code{data.frame}
about_bee(as.df = FALSE)
# You can also filter by methods by data, meta-data, and actions.
about_bee(type = "data")
about_bee(type = "meta-data")
about_bee(type = "actions")
}
}

