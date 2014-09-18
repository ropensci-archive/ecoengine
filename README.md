
Linux: ![travis shield](https://travis-ci.org/ropensci/ecoengine.png?branch=master)   
Windows: [![Build status](https://ci.appveyor.com/api/projects/status/0unlb6h2lc3t5h60)](https://ci.appveyor.com/project/karthik/ecoengine)

# R interface to the Berkeley Ecoinformatics Engine


**Providing access to UC Berkeley's Natural History Data**


This package provides a R wrapper for the newly available [ecoinformatics engine from UC Berkeley](http://ecoengine.berkeley.edu/). The API is very new and currently provides access to two types of data.

* Georeferenced data from the Wieslander project
* Data on > 2 million georeferenced Berkley museum specimens.

## Installing the package

A stable version can be installed from the central CRAN repository

```coffee
install.packages("ecoengine", dependencies = TRUE)
```


Install the package with `devtools` to obtain the latest development version.

```coffee
# If you don't already have the devtools package installed, run
# install.packages("devtools")
# unlike most packages, devtools requires additional non-R dependencies depending on your OS.
# See → https://github.com/karthik/dlab-advanced-r/blob/master/installation.md#installation
library(devtools)
install_github('ecoengine', 'ropensci', ref = "dev")
```

## Documentation

A quick start guide is available both as [markdown](https://github.com/ropensci/ecoengine/blob/master/inst/Using_ecoengine.md) and a [nicely formatted PDF](https://github.com/ropensci/ecoengine/blob/master/inst/Using_ecoengine.pdf?raw=true) or you can go through a [set of slides](http://karthik.github.io/eeguide) from a recent talk.

## Citation

```coffee
To cite package ‘ecoengine’ in publications use:

  Karthik Ram (2014). ecoengine: Programmatic interface to the API
  serving UC Berkeley's Natural History Data. R package version 1.5.
  https://github.com/ropensci/ecoengine

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {ecoengine: Programmatic interface to the API serving UC Berkeley's Natural History
Data},
    author = {Karthik Ram},
    year = {2014},
    note = {R package version 1.5},
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


---

[![ropensci footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
