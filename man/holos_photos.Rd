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
  \code{holos_photos}

  \itemize{ \item{"page" } {Page Number}
  \item{"state_province" } {Need to describe these
  parameters} \item{"county" } {Package include a full list
  of counties. To load dataset (california_counties)}
  \item{"genus" } {Genus } \item{"scientific_name" }
  {Scientific Name } \item{"authors" } {List of authors }
  \item{"remote_id" } {Description }
  \item{"collection_code" } {Description } \item{"source" }
  {Description } \item{"min_date" } {Lower date bound}
  \item{"max_date" } {Upper date bound}
  \item{"related_type" } {Description } \item{"related " }
  {Description } \item{"other_catalog_numbers"}
  {Description } }}
}
\description{
  This wrapper around holos_photos(). Allows a user to
  retrive all data at once for a query rather than request
  a page at a time.
}
\examples{
\dontrun{
all_cdfa <- holos_photos(collection_code = "CDFA", page = "all")
some_cdfa <- holos_photos(collection_code = "CDFA", page = 1:2)
some_other_cdfa <- holos_photos(collection_code = "CDFA", page = c(1:4,6))
}
}
\seealso{
  \code{\link{holos_photos_get}}
}

