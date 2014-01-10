\name{ee_search_obs}
\alias{ee_search_obs}
\title{Search observations}
\usage{
ee_search_obs(query = NULL, foptions = list())
}
\arguments{
  \item{query}{= The search term}

  \item{foptions}{= list() Additional arguments for httr}
}
\value{
data.frame
}
\description{
A powerful way to search through the observations.
}
\examples{
\dontrun{
ee_search_obs(query  = "Lynx")
ee_search_obs(query  = "genus:Lynx")
}
}
\seealso{
\code{\link{ee_search})}
}
\keyword{search}

