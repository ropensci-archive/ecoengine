\name{ee_paginator}
\alias{ee_paginator}
\title{ecoengine paginator}
\usage{
ee_paginator(page, total_obs)
}
\arguments{
  \item{page}{requested page number or page range. Can also
  be "all"}

  \item{total_obs}{Total number of records available for
  any search query}
}
\description{
Takes a page range and total number of observations to
return the right sequence of pages that need to be crawled.
}
\examples{
\dontrun{
ee_paginator(1, 100)
ee_paginator("all", 100)
ee_paginator(1:2, 100)
ee_paginator(1:4, 100)
# This will return an error since there are only 4 pages per 100 observations
ee_paginator(1:5, 100)
}
}

