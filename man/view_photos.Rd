\name{view_photos}
\alias{view_photos}
\title{Browse photo queries in your default browser.}
\usage{
view_photos(input = NULL, output = NULL, browse = TRUE)
}
\arguments{
  \item{input}{Input, usually output from a call to
  \code{\link[ecoengine]{ee_photos}}}

  \item{output}{Path and file name for output file. If
  NULL, a temp file is used.}

  \item{browse}{Browse file in your default browse
  immediately after file creation.  If FALSE, the file is
  written, but not opened.}
}
\description{
Browse photo queries in your default browser.
}
\examples{
\dontrun{
view_photos(ee_photos())
# Pictures of racoons
view_photos(ee_photos_get(scientific_name = "Procyon lotor", quiet = TRUE))
# or the California Condor
view_photos(ee_photos_get(scientific_name = "Gymnogyps californianus", quiet = TRUE))
}
}

