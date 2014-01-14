\name{ee_search_obs_get}
\alias{ee_search_obs_get}
\title{Search observations}
\usage{
ee_search_obs_get(query = NULL, page = NULL, page_size = 25,
  quiet = FALSE, foptions = list())
}
\arguments{
  \item{query}{= The search term}

  \item{foptions}{A list of additional arguments for
  \code{httr}. Used for diagnostic reasons.}

  \item{quiet}{Default is FALSE. Set to TRUE to suppress
  messages.}

  \item{page}{Page number}

  \item{page_size}{The number of observations per page
  returned by the query. The package default is \code{25}
  observations. The API default, however, is \code{10}.
  Setting this number higher will require fewer calls (i.e.
  pages) but a large size may also fail or timeout.}
}
\value{
data.frame
}
\description{
A powerful way to search through the observations.
}
\examples{
\dontrun{
ee_search_obs_get(query  = "Lynx")
ee_search_obs_get(query  = "genus:Lynx")
}
}
\seealso{
\code{\link{ee_search})}
}
\keyword{search}

