Brian Ripley writes:

You have

     > ### Name: ee_about
     > ### Title: About the Berkeley Ecoinformatics Engine
     > ### Aliases: ee_about
     >
     > ### ** Examples
     >
     >
     > ee_about()
     Warning in ee_about() : Internal Server Error (HTTP 500).
     No encoding supplied: defaulting to UTF-8.
     Error in format.default(unlist(xx), ...) :
      Found no format() method for class "externalptr"
     Calls: <Anonymous> ... format -> format.default -> lapply -> FUN ->
format.default

which does not comply with the CRAN policy on Internet access.  You need
to analyse the status of your query, not warn and blindly continue.


This has been fixed now. All of these calls return a user friendly message ("Internet resources should fail gracefully with an informative message if the resource is not available ")