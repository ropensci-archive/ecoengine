\name{vtmveg_get}
\alias{vtmveg_get}
\title{Weislander vegetation data}
\usage{
vtmveg_get(page = NULL, page_size = 25, quiet = FALSE,
  foptions = list())
}
\arguments{
  \item{page}{Page number}

  \item{page_size}{Default is \code{25}. API default is
  \code{10}}

  \item{quiet}{= FALSE Set to \code{TRUE} to suppress
  messages}

  \item{foptions}{Additional arguments for httr}
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
veg_data <- vtmveg_get()
veg_data <- vtmveg_get(quiet = TRUE)
}
}
\seealso{
vtmveg
}

