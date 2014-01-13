\name{ee_observations_get}
\alias{ee_observations_get}
\title{Observations List}
\usage{
ee_observations_get(country = "United States", state_province = NULL,
  county = NULL, kingdom = NULL, phylum = NULL, order = NULL,
  clss = NULL, family = NULL, genus = NULL, scientific_name = NULL,
  kingdom_exact = NULL, phylum_exact = NULL, order_exact = NULL,
  clss_exact = NULL, family_exact = NULL, genus_exact = NULL,
  scientific_name_exact = NULL, remote_id = NULL, collection_code = NULL,
  source = NULL, min_date = NULL, max_date = NULL,
  georeferenced = FALSE, bbox = NULL, page = NULL, page_size = 10,
  quiet = FALSE, foptions = list())
}
\arguments{
  \item{country}{description needed.}

  \item{state_province}{description needed.}

  \item{county}{description needed.}

  \item{kingdom}{description needed.}

  \item{phylum}{description needed.}

  \item{order}{description needed.}

  \item{clss}{description needed.}

  \item{family}{description needed.}

  \item{genus}{description needed.}

  \item{scientific_name}{description needed.}

  \item{kingdom_exact}{description needed.}

  \item{phylum_exact}{description needed.}

  \item{order_exact}{description needed.}

  \item{clss_exact}{description needed.}

  \item{family_exact}{description needed.}

  \item{genus_exact}{description needed.}

  \item{scientific_name_exact}{description needed.}

  \item{remote_id}{description needed.}

  \item{collection_code}{description needed.}

  \item{source}{description needed.}

  \item{min_date}{description needed.}

  \item{max_date}{description needed.}

  \item{georeferenced}{Default is \code{FALSE}. Set to TRUE
  to return only georeferenced records.}

  \item{bbox}{Set a bounding box for your search. Use
  format \code{bbox=-124,32,-114,42}}

  \item{page}{Page page number.}

  \item{page_size}{Number of results per page. Default is
  10}

  \item{quiet}{Default is \code{FALSE}. Set to \code{TRUE}
  to supress messages.}

  \item{foptions}{description needed.}
}
\value{
\code{data.frame}
}
\description{
API endpoint that represents a list of observations.
Prameter options have not been fleshed out yet
}
\examples{
\dontrun{
ee_observations_get(country = "United States")
ee_observations_get(scientific_name_exact = "Pinus")
}
}

