\name{ee_search_obs}
\alias{ee_search_obs}
\title{Search observations}
\usage{
ee_search_obs(query = NULL, page = NULL, page_size = 25, quiet = FALSE,
  foptions = list())
}
\arguments{
  \item{query}{= The search term}

  \item{foptions}{A list of additional arguments for
  \code{httr}. There is no reason to use this argument
  except for debugging purposes.}

  \item{quiet}{Default is \code{FALSE}. Set to \code{TRUE}
  to suppress messages.}

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
general_lynx_query <- ee_search_obs(query  = "Lynx")
lynx_data <- ee_search_obs(query  = "genus:Lynx")
all_lynx_data <- ee_search_obs(query  = "Lynx", page = "all")
}
}
\seealso{
\code{\link{ee_search})}
}
\keyword{search}

