\name{vtmveg_get}
\alias{vtmveg_get}
\title{Weislander vegetation data}
\usage{
vtmveg_get(page = NULL, page_size = 25, quiet = FALSE,
  foptions = list())
}
\arguments{
  \item{page}{Page number}

  \item{page_size}{The number of observations per page
  returned by the query. The package default is \code{25}
  observations. The API default, however, is \code{10}.
  Setting this number higher will require fewer calls (i.e.
  pages) but a large size may also fail or timeout.}

  \item{quiet}{Default is \code{FALSE}. Set to \code{TRUE}
  to suppress messages}

  \item{foptions}{A list of additional arguments for
  \code{httr}. There is no reason to use this argument
  except for debugging purposes.}
}
\value{
data.frame
}
\description{
Retrieves all vegetation records from the Weislander
surveys
}
\examples{
\dontrun{
some_veg_data <- vtmveg_get()
}
}

