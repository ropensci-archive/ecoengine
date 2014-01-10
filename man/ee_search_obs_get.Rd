\name{ee_search_obs_get}
\alias{ee_search_obs_get}
\title{Search observations}
\usage{
ee_search_obs_get(query = NULL, page = NULL, page_size = 25,
  quiet = FALSE, foptions = list())
}
\arguments{
  \item{query}{= The search term}

  \item{foptions}{= list() Additional arguments for httr}

  \item{quiet}{Default is FALSE. Set to TRUE to suppress
  messages.}

  \item{page}{page number}

  \item{page_size}{Number of results per page. Default in
  the package is 25. Default on the API is 10.}
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

