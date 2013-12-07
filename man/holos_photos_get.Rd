\name{holos_photos_get}
\alias{holos_photos_get}
\title{holos_photos_get}
\usage{
  holos_photos_get(..., page = NULL)
}
\arguments{
  \item{page}{Use \code{all} to request all pages for a
  particular query.}

  \item{...}{All the arguments that go into
  \code{holos_photos}}
}
\description{
  This wrapper around holos_photos(). Allows a user to
  retrive all data at once for a query rather than request
  a page at a time.
}
\examples{
\dontrun{
all_cdfa <- holos_photos_get(collection_code = "CDFA", page = "all")
some_cdfa <- holos_photos_get(collection_code = "CDFA", page = 1:2)
some_other_cdfa <- holos_photos_get(collection_code = "CDFA", page = c(1:4,6)) # This example does not work.
}
}
\seealso{
  \code{\link{holos_photos}}
}

