R CMD CHECK passed on my local OS X install with R 3.1.1 and R Under development (unstable) (2014-07-20 r66218), Ubuntu running on Travis-CI, and Win builder.

Brian Ripley writes: "* checking examples ... [3s/22s] OK

Examples with CPU or elapsed time > 5s
               user system elapsed
ee_search_obs 1.542  0.007  14.331"

I have now commented out all examples. I have run check() a dozen times and have had two others run these from two different countries. No more >5 second warnings.

Thanks! Karthik Ram