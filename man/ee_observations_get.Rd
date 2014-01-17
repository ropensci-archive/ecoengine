\name{ee_observations_get}
\alias{ee_observations_get}
\title{Observations List}
\usage{
ee_observations_get(page = NULL, page_size = 25,
  country = "United States", state_province = NULL, county = NULL,
  kingdom = NULL, phylum = NULL, order = NULL, clss = NULL,
  family = NULL, genus = NULL, scientific_name = NULL,
  kingdom_exact = NULL, phylum_exact = NULL, order_exact = NULL,
  clss_exact = NULL, family_exact = NULL, genus_exact = NULL,
  scientific_name_exact = NULL, remote_id = NULL, collection_code = NULL,
  source = NULL, min_date = NULL, max_date = NULL,
  georeferenced = FALSE, bbox = NULL, quiet = FALSE, foptions = list())
}
\arguments{
  \item{page}{Page number}

  \item{page_size}{The number of observations per page
  returned by the query. The package default is \code{25}
  observations. The API default, however, is \code{10}.
  Setting this number higher will require fewer calls (i.e.
  pages) but a large size may also fail or timeout.}

  \item{country}{country name}

  \item{state_province}{description needed.}

  \item{county}{California county. See
  \code{data(california_counties)}}

  \item{kingdom}{kingdom name}

  \item{phylum}{phylum name}

  \item{order}{order name}

  \item{clss}{class name}

  \item{family}{family name}

  \item{genus}{genus name.}

  \item{scientific_name}{description needed.}

  \item{kingdom_exact}{exact kingdom name}

  \item{phylum_exact}{exact phylum name}

  \item{order_exact}{exact order name}

  \item{clss_exact}{class name}

  \item{family_exact}{exact family name}

  \item{genus_exact}{exact genus name}

  \item{scientific_name_exact}{exact scientific name}

  \item{remote_id}{remote ID}

  \item{collection_code}{collections code}

  \item{source}{data source. See \code{\link{ee_sources}}}

  \item{min_date}{Lower date bound. Most be in format Y-m-D
  h:m:s. This package uses lubridate's \code{ymd_hms}
  function to format dates.}

  \item{max_date}{upper date bound. Most be in format Y-m-D
  h:m:s. This package uses lubridate's \code{ymd_hms}
  function to format dates.}

  \item{georeferenced}{Default is \code{FALSE}. Set to TRUE
  to return only georeferenced records.}

  \item{bbox}{Set a bounding box for your search. Use
  format \code{bbox=-124,32,-114,42}}

  \item{quiet}{Default is \code{FALSE}. Set to \code{TRUE}
  to supress messages.}

  \item{foptions}{A list of additional arguments for
  \code{httr}. There is no reason to use this argument
  except for debugging purposes.}
}
\value{
\code{data.frame}
}
\description{
API endpoint that represents a list of observations.
}
\examples{
\dontrun{
us <- ee_observations_get(country = "United States")
pinus <- ee_observations_get(scientific_name_exact = "Pinus")
lynx_data <- ee_observations_get(genus = "Lynx")
# Georeferenced data only
lynx_data <- ee_observations_get(genus = "Lynx", georeferenced = TRUE)
}
}

