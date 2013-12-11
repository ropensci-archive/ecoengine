\name{holos_photos}
\alias{holos_photos}
\title{holos_photos}
\usage{
holos_photos(..., page = NULL)
}
\arguments{
  \item{page}{Use \code{all} to request all pages for a
  particular query.}

  \item{...}{All the arguments that go into
  \code{holos_photos}}
}
\description{
This wrapper around holos_photos(). Allows a user to
retrive all data at once for a query rather than request a
page at a time.
}
\examples{
\dontrun{
all_cdfa <- holos_photos(collection_code = "CDFA", page = "all")
some_cdfa <- holos_photos(collection_code = "CDFA", page = 1:2)
some_other_cdfa <- holos_photos(collection_code = "CDFA", page = c(1:4,6))
}
}
\seealso{
\code{\link{holos_photos}}
}

