\name{ee_checklists}
\alias{ee_checklists}
\title{Ecoengine checklists}
\usage{
ee_checklists(subject = NULL, foptions = list())
}
\arguments{
  \item{subject}{Enter one of the following subjects:
  Mammals, Mosses, Beetles, Spiders, Amphibians, Ants,
  Fungi, Lichen, Plants.}

  \item{foptions}{= list() Additional arguments to httr}
}
\value{
data.frame
}
\description{
Retrieves exisitng checklists from the ecoengine database
}
\examples{
\dontrun{
all_lists  <- ee_checklists()
mammals_list  <- ee_checklists(subject = "Mammals")
spiders  <- ee_checklists(subject = "Spiders")
}
}

