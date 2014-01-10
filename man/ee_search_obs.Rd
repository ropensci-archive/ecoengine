\name{ee_search_obs}
\alias{ee_search_obs}
\title{ee_search_obs}
\usage{
ee_search_obs(..., page = NULL, page_size = 25, foptions = list())
}
\arguments{
  \item{...}{<what param does>}

  \item{page}{page number}

  \item{page_size}{Number of results per page. Default in
  the package is 25. Default on the API is 10.}

  \item{foptions}{= list() additional options for httr.}
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

