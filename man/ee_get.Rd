\name{ee_get}
\alias{ee_get}
\title{Ecoengine paginator}
\usage{
ee_get(..., input_fn = NULL, page = NULL, page_size = 25, dtype = NULL)
}
\arguments{
  \item{...}{Arguments that get passed to the input
  function.}

  \item{input_fn}{An input function that needs to be
  recursively called to retrieve all results.}

  \item{page}{A page number, page size,}

  \item{dtype}{data type can be \code{photos},
  \code{observations}, \code{checklists}.}

  \item{page_size}{Number of observations per page. Package
  default is \code{25}}
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

