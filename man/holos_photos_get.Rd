\name{holos_photos_get}
\alias{holos_photos_get}
\title{holos_photos}
\usage{
holos_photos_get(page = NULL, state_province = NULL, county = NULL,
  genus = NULL, scientific_name = NULL, authors = NULL,
  remote_id = NULL, collection_code = NULL, source = NULL,
  min_date = NULL, max_date = NULL, related_type = NULL, related = NULL,
  quiet = FALSE, other_catalog_numbers = NULL, foptions = list())
}
\arguments{
  \item{page}{page number}

  \item{state_province}{Need to describe these parameters}

  \item{county}{California counties. Package include a full
  list of counties. To load dataset
  \code{data(california_counties)}}

  \item{genus}{Need to describe these parameters}

  \item{scientific_name}{Need to describe these parameters}

  \item{authors}{Need to describe these parameters}

  \item{remote_id}{Need to describe these parameters}

  \item{collection_code}{Type of collection. Can be
  \code{CalAcademy}, \code{Private}, \code{VTM},
  \code{CDFA}. \code{CalFlora} Others TBA}

  \item{source}{Need to describe these parameters}

  \item{min_date}{Need to describe these parameters}

  \item{max_date}{Need to describe these parameters}

  \item{related_type}{Need to describe these parameters}

  \item{related}{Need to describe these parameters}

  \item{other_catalog_numbers}{Need to describe these
  parameters}

  \item{quiet}{Default is \code{FALSE}. Set to \code{TRUE}
  to suppress output.}

  \item{foptions}{= list() Other options to pass to curl}
}
\description{
Search the photos methods in the Holos API.
}
\examples{
\dontrun{
# Request all photos. This request will paginate. Don't use holos_photos_get #' on such a large request
holos_photos_get()
# Search by collection code. See notes above on options
holos_photos_get(collection_code = "CalAcademy")
holos_photos_get(collection_code = "VTM")
holos_photos_get(collection_code = "CalFlora")
holos_photos_get(collection_code = "CDFA")
# Search by county.
holos_photos_get(county = "Santa Clara County")
holos_photos_get(county = "Merced County")
# The package also contains a full list of counties
data(california_counties)
alameda <- holos_photos_get(county = california_counties[1, 1])
alameda$data
# You can also get all the data for Alameda county with one request
alameda <- holos_photos_get_get(county = california_counties[1, 1], page = "all")
# Spidering through the rest of the counties can easily be automated.
# Or by author
charles_results <- holos_photos_get(author = "Charles Webber")
# You can also request all pages in a single call by using holos_photos_get()
# In this example below, there are 6 pages of results (52 result items). #' Function will return all at once.
all_cdfa <- holos_photos_get(collection_code = "CDFA", page = "all")
}
}
\seealso{
related: \code{\link{holos_photos_get}}
\code{\link{california_counties}}
}

