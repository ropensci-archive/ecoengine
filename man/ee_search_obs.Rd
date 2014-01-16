\name{ee_search_obs}
\alias{ee_search_obs}
\title{ee_search_obs}
\usage{
ee_search_obs(..., page = NULL, page_size = 25, foptions = list())
}
\arguments{
  \item{...}{all the arguments that get passed to
  \code{\link{ee_search_obs}}}

  \item{page}{Page number}

  \item{page_size}{The number of observations per page
  returned by the query. The package default is \code{25}
  observations. The API default, however, is \code{10}.
  Setting this number higher will require fewer calls (i.e.
  pages) but a large size may also fail or timeout.}

  \item{foptions}{A list of additional arguments for
  \code{httr}. There is no reason to use this argument
  except for debugging purposes.}
}
\description{
Elastic search on observations. This wrapper for
\code{\link{ee_search_obs}}
}
\examples{
\dontrun{
all_lynx_data <- ee_search_obs(query  = "Lynx", page = "all")
}
}

