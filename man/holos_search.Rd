\name{holos_search}
\alias{holos_search}
\title{Holos search}
\usage{
holos_search(query = NULL, facet = NULL, foptions = list())
}
\arguments{
  \item{query}{search term}

  \item{facet}{Field to facet on. Possibilities include:
  kingdom, genus, family, clss, phylum}

  \item{foptions}{= list() Additional (optional) arguments
  to httr}
}
\description{
Search the ecoengine
}
\examples{
\dontrun{
holos_search(query = "Pinus", facet = "Genus")
}
}

