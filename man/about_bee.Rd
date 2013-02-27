\name{about_bee}
\alias{about_bee}
\title{About the Berkeley Ecoinformatics Engine}
\usage{
  about_bee(as.df = FALSE)
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
about_bee(as.df = TRUE)
}
}

