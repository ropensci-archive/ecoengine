\name{holos_photos}
\alias{holos_photos}
\title{holos photos}
\usage{
  holos_photos(page = NULL, state_province = NULL,
    county = NULL, genus = NULL, scientific_name = NULL,
    authors = NULL, remote_id = NULL,
    collection_code = NULL, source = NULL, min_date = NULL,
    max_date = NULL, related_type = NULL, related = NULL,
    other_catalog_numbers = NULL, foptions = list())
}
\arguments{
  \item{page}{page number}

  \item{state_province}{Need to describe these parameters}

  \item{county}{See
  \href{http://en.wikipedia.org/wiki/List_of_counties_in_California}{full
  list of California counties}}

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

  \item{foptions}{= list() Other options to pass to curl}
}
\description{
  Search the photos methods in the Holos API.
}
\examples{
\dontrun{
holos_photos()
}
}

