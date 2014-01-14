
![](https://travis-ci.org/ropensci/ecoengine.png?branch=master)


# R interface to the Berkeley Ecoinformatics Engine


**Providing access to UC Berkeley's Natural History Data**


This package provides a R wrapper for the newly available [ecoinformatics engine from UC Berkeley](http://ecoengine.berkeley.edu/). The API is very new and currently provides access to two types of data.

* Georeferenced data from the Wieslander project
* Data on > 2 million georeferenced Berkley museum specimens.

## Installing the package

Install the package with `devtools` until package is submitted to CRAN.

```coffee
# If you don't already have the devtools package installed, run
# install.packages("devtools")
# unlike most packages, devtools requires additional non-R dependencies depending on your OS. See → https://github.com/karthik/dlab-advanced-r/blob/master/installation.md#installation for more information. 
library(devtools)
install_github('ecoengine', 'ropensci')
```

## Resources

* [Ecoengine API documentation](http://ecoengine.berkeley.edu/developers/)
* [Berkeley Natural History Museums](http://bnhm.berkeley.edu/)

---

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)