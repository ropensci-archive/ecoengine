\name{checklist_details}
\alias{checklist_details}
\title{Checklist details}
\usage{
  checklist_details(list_name, ...)
}
\arguments{
  \item{list_name}{URL of a checklist}

  \item{...}{Additional arguments (currently not
  implemented)}
}
\value{
  \code{data.frame}
}
\description{
  Will return details on any checklist
}
\examples{
\dontrun{
spiders  <- holos_checklists(subject = "Spiders")
# Now retrieve all the details for each species on the list
spider_details <- ldply(spiders$url, checklist_details)
}
}
\seealso{
  \code{\link{holos_checklists}}
}

