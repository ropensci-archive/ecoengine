\name{ee_geojson}
\alias{ee_geojson}
\title{Created geojson from an ecoengine object of type observation}
\usage{
ee_geojson(ee_obj, location = NULL, file = NULL)
}
\arguments{
  \item{ee_obj}{object of class ecoengine}

  \item{location}{Location where geojson file should be
  saved}

  \item{file}{Name of file to be saved. Otherwise file will
  be named Species_map-(current_date)}
}
\description{
This function writes out a geojson file that can easily be
imported into many maps applications or directly rendered
on services like GitHub. Warning: Current behavior is to
overwrite existing files in the same folder that match the
filename
}
\examples{
\dontrun{
lynx_data <- ee_observations(genus = "Lynx", georeferenced = TRUE, quiet = TRUE, progress = FALSE)
ee_geojson(lynx_data, location = "~/Desktop", file = "foo")
# Now import this file into services like MapBox, or GitHub.
}
}

