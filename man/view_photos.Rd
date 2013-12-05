\name{view_photos}
\alias{view_photos}
\title{Browse photo queries in your default browser.}
\usage{
  view_photos(input = NULL, output = NULL, browse = TRUE)
}
\arguments{
  \item{input}{Input, usually output from a call to
  \code{\link[ecoengine]{holos_photos}}}

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
view_photos(holos_photos())
}
}

