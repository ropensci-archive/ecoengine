# ecoengine

[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
![CRAN/GitHub 1.10.0_/1.10.99](https://img.shields.io/badge/CRAN/GitHub-1.10.0_/0.1.9999-blue.svg)

## R interface to the Berkeley Ecoinformatics Engine


**Providing access to UC Berkeley's Natural History Data**


This package provides a R wrapper for the newly available [ecoinformatics engine from UC Berkeley](http://ecoengine.berkeley.edu/). The API is very new and currently provides access to two types of data.

* Georeferenced data from the Wieslander project
* Data on > 2 million georeferenced Berkley museum specimens.

## Package Status and Installation

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ropensci/ecoengine?branch=master&svg=true)](https://ci.appveyor.com/project/ropensci/ecoengine)
[![Travis-CI Build Status](https://travis-ci.org/ropensci/ecoengine.svg?branch=master)](https://travis-ci.org/)
 [![codecov](https://codecov.io/gh/ropensci/ecoengine/branch/master/graph/badge.svg)](https://codecov.io/gh/ropensci/ecoengine)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/ecoengine?color=blue)](https://github.com/metacran/cranlogs.app)

__Installation instructions__

__Stable Version__

A stable version can be installed from the central CRAN repository

```coffee
install.packages("ecoengine", dependencies = TRUE)
```

__Development Version__
Install the package with `devtools` to obtain the latest development version.

```coffee
# If you don't already have the devtools package installed, run
# install.packages("devtools")
# unlike most packages, devtools requires additional non-R dependencies depending on your OS.
# See → https://github.com/karthik/dlab-advanced-r/blob/master/installation.md#installation
library(devtools)
install_github('ropensci/ecoengine')
```

## Usage 
### Documentation

A quick start guide is available both as [markdown](https://github.com/ropensci/ecoengine/blob/master/inst/Using_ecoengine.md) and a [nicely formatted PDF](https://github.com/ropensci/ecoengine/blob/master/inst/Using_ecoengine.pdf?raw=true) or you can go through a [set of slides](http://karthik.github.io/eeguide) from a recent talk.

## Citation

```coffee
To cite package ‘ecoengine’ in publications use:

  Karthik Ram (2014). ecoengine: Programmatic interface to the API
  serving UC Berkeley's Natural History Data. R package version 1.9.
  https://github.com/ropensci/ecoengine

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {ecoengine: Programmatic interface to the API serving UC Berkeley's Natural History
Data},
    author = {Karthik Ram},
    year = {2014},
    note = {R package version 1.9},
    url = {https://github.com/ropensci/ecoengine},
  }
```

## Resources

* [Ecoengine API documentation](http://ecoengine.berkeley.edu/developers/)
* [Berkeley Natural History Museums](http://bnhm.berkeley.edu/)
* [Guide to using the ecoengine (slides)](http://karthik.github.io/eeguide)
* [How to make large requests to the ecoengine](https://gist.github.com/9360037)


[Bug reports](https://github.com/ropensci/ecoengine/issues/new), feature requests and suggestions (especially as pull requests) are most welcome.


---
  
This package is part of a richer suite called [SPOCC Species Occurrence Data](https://github.com/ropensci/spocc), along with several other packages, that provide access to occurrence records from multiple databases. We recommend using SPOCC as the primary R interface to ecoengine unless your needs are limited to this single source.    


---

## Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md).
By participating in this project you agree to abide by its terms.



[![ropensci_footer](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
