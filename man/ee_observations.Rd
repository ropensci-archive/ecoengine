\name{ee_observations}
\alias{ee_observations}
\title{Observations List}
\usage{
ee_observations(page = NULL, page_size = 25, country = "United States",
  state_province = NULL, county = NULL, kingdom = NULL, phylum = NULL,
  order = NULL, clss = NULL, family = NULL, genus = NULL,
  scientific_name = NULL, kingdom__exact = NULL, phylum__exact = NULL,
  order__exact = NULL, clss__exact = NULL, family__exact = NULL,
  genus__exact = NULL, scientific_name__exact = NULL, remote_id = NULL,
  collection_code = NULL, source = NULL, min_date = NULL,
  max_date = NULL, georeferenced = FALSE, bbox = NULL, quiet = FALSE,
  progress = TRUE, foptions = list())
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

  \item{scientific_name}{A full scientific name}

  \item{kingdom__exact}{exact kingdom name}

  \item{phylum__exact}{exact phylum name}

  \item{order__exact}{exact order name}

  \item{clss__exact}{class name}

  \item{family__exact}{exact family name}

  \item{genus__exact}{exact genus name}

  \item{scientific_name__exact}{exact scientific name}

  \item{remote_id}{remote ID}

  \item{collection_code}{collections code}

  \item{source}{data source. See \code{\link{ee_sources}}}

  \item{min_date}{Lower date bound. Most be in format Y-m-D
  h:m:s. This package uses lubridate's \code{ymd_hms}
  function to format dates.}

  \item{max_date}{upper date bound. Most be in format Y-m-D
  h:m:s. This package uses lubridate's \code{ymd_hms}
  function to format dates.}

  \item{georeferenced}{Default is \code{FALSE}. Set to
  \code{TRUE} to return only georeferenced records.}

  \item{bbox}{Set a bounding box for your search. Use
  format \code{bbox=-124,32,-114,42}}

  \item{quiet}{Default is \code{FALSE}. Set to \code{TRUE}
  to supress messages.}

  \item{foptions}{A list of additional arguments for
  \code{httr}. There is no reason to use this argument
  except for debugging purposes.}

  \item{progress}{Progress bar is set to \code{TRUE} by
  default. Use \code{FALSE} especially when calling
  functions inside documents.}
}
\value{
\code{data.frame}
}
\description{
API endpoint that represents a list of observations.
}
\examples{
us <- ee_observations(country = "United States")
pinus <- ee_observations(scientific_name = "Pinus")
lynx_data <- ee_observations(genus = "Lynx")
# Georeferenced data only
\dontrun{
lynx_data <- ee_observations(genus = "Lynx", georeferenced = TRUE)
animalia <- ee_observations(kingdom = "Animalia")
Artemisia <- ee_observations(scientific_name = "Artemisia douglasiana")
asteraceae <- ee_observationss(family = "asteraceae")
vulpes <- ee_observations(genus = "vulpes")
Anas <- ee_observations(scientific_name = "Anas cyanoptera", page = "all")
loons <- ee_observations(scientific_name = "Gavia immer", page = "all")
plantae <- ee_observations(kingdom = "plantae")
chordata <- ee_observations(phylum = "chordata")
# Class is clss since the former is a reserved keyword in SQL.
aves <- ee_observations(clss = "aves")
}
}

