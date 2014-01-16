\name{ee_photos_get}
\alias{ee_photos_get}
\title{ee_photos_get}
\usage{
ee_photos_get(page = NULL, state_province = NULL, county = NULL,
  genus = NULL, scientific_name = NULL, authors = NULL,
  remote_id = NULL, collection_code = NULL, source = NULL,
  min_date = NULL, max_date = NULL, related_type = NULL, related = NULL,
  page_size = 25, quiet = FALSE, other_catalog_numbers = NULL,
  foptions = list())
}
\arguments{
  \item{page}{Page number}

  \item{page_size}{The number of observations per page
  returned by the query. The package default is \code{25}
  observations. The API default, however, is \code{10}.
  Setting this number higher will require fewer calls (i.e.
  pages) but a large size may also fail or timeout.}

  \item{state_province}{Need to describe these parameters}

  \item{county}{California counties. Package include a full
  list of counties. To load dataset
  \code{data(california_counties)}}

  \item{genus}{genus name}

  \item{scientific_name}{scientiifc name}

  \item{authors}{author name}

  \item{remote_id}{remote id}

  \item{collection_code}{Type of collection. Can be
  \code{CalAcademy}, \code{Private}, \code{VTM},
  \code{CDFA}. \code{CalFlora} Others TBA}

  \item{source}{data source. See \code{\link{ee_sources}}}

  \item{min_date}{Lower date bound. Most be in format Y-m-D
  h:m:s. This package uses lubridate's \code{ymd_hms}
  function to format dates.}

  \item{max_date}{upper date bound. Most be in format Y-m-D
  h:m:s. This package uses lubridate's \code{ymd_hms}
  function to format dates.}

  \item{related_type}{Need to describe these parameters}

  \item{related}{Need to describe these parameters}

  \item{other_catalog_numbers}{Need to describe these
  parameters}

  \item{quiet}{Default is \code{FALSE}. Set to \code{TRUE}
  to suppress messages.}

  \item{foptions}{A list of additional arguments for
  \code{httr}. There is no reason to use this argument
  except for debugging purposes.}
}
\description{
Search the photos methods in the Holos API.
}
\examples{
\dontrun{
# Request all photos. This request will paginate. Don't use ee_photos_get #' on such a large request
ee_photos_get()
# Search by collection code. See notes above on options
ee_photos_get(collection_code = "CalAcademy")
ee_photos_get(collection_code = "VTM")
ee_photos_get(collection_code = "CalFlora")
ee_photos_get(collection_code = "CDFA")
# Search by county.
ee_photos_get(county = "Santa Clara County")
ee_photos_get(county = "Merced County")
# The package also contains a full list of counties
data(california_counties)
alameda <- ee_photos_get(county = california_counties[1, 1])
alameda$data
# You can also get all the data for Alameda county with one request
alameda <- ee_photos(county = "Alameda county", page = "all")
# Spidering through the rest of the counties can easily be automated.
# Or by author
charles_results <- ee_photos_get(author = "Charles Webber")
# You can also request all pages in a single call by using ee_photos_get()
# In this example below, there are 6 pages of results (52 result items).
Function will return all at once.
racoons <- ee_photos_get(scientific_name = "Procyon lotor", quiet = TRUE)
}
}
\seealso{
related: \code{\link{ee_photos_get}}
\code{\link{california_counties}}
}

