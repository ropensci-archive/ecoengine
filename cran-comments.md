R CMD CHECK passed on my local OS X install with R 3.1.1 and R Under development (unstable) (2014-07-20 r66218), Ubuntu running on Travis-CI, and Win builder.

Brian Ripley writes: "* checking examples … [4s/23s] OK
Examples with CPU or elapsed time > 5s
                user system elapsed
ee_search_obs 1.536  0.012  14.314 on a rather fast machine: the CRAN policies ask for a few seconds." The function in question requests data from a web API. Even the fastest machine cannot ensure a perfect connection every single time and also cannot control for concurrent users. To abide by the 5 second requriement, I have commented out nearly all examples now. Multiple checks in a row all pass under 5 seconds.

Thanks! Karthik Ram