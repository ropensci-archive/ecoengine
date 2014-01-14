\name{ee_get}
\alias{ee_get}
\title{Ecoengine paginator}
\usage{
ee_get(..., input_fn = NULL, page = NULL, page_size = 25, dtype = NULL)
}
\arguments{
  \item{...}{Arguments that get passed to the input
  function.}

  \item{page}{Page number}

  \item{page_size}{The number of observations per page
  returned by the query. The package default is \code{25}
  observations. The API default, however, is \code{10}.
  Setting this number higher will require fewer calls (i.e.
  pages) but a large size may also fail or timeout.}

  \item{input_fn}{An input function that needs to be
  recursively called to retrieve all results.}

  \item{dtype}{data type can be \code{photos},
  \code{observations}, \code{checklists}.}
}
\description{
This function allows for paginating through calls that
return more observations than the throttling limit.
Although the API itself defaults to 10 observations per
page, this package default to 25. This request requires an
input function (currently supports photos, observations and
checklists), a page range (can be a single page, page
range, or "all") and a data type for the purposes of
constructing a \code{ecoengine} class. The type can be
"photos", "observations", "checklists" (more to be added).
}
\examples{
\dontrun{
some_cdfa <- ee_get(collection_code = "CDFA", page = 1, input_fn = ee_photos_get, dtype = "photos")
}
}

