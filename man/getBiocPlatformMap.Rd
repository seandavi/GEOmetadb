\name{getBiocPlatformMap}
\alias{getBiocPlatformMap}
\title{Get mappings between GPL and Bioconductor microarry annotation packages}
\description{
  Query the gpl table and get mappings between GPL and all or specific Biocondoctor microarry annotation packages.
}
\usage{
getBiocPlatformMap(con, bioc='all')
}
\arguments{
  \item{con}{Connection to the GEOmetadb.sqlite database}
  \item{bioc}{Character vector of Biocondoctor microarry annotation packages, e.g. c('hgu133plus2','hgu95av2').  'all' returns all mappings. 
}
}
\value{
  A six-column data.frame including GPL title, GPL accession, bioc_package, manufacturer, organism, data_row_count.
}
\references{http://meltzerlab.nci.nih.gov/apps/geo}
\author{Jack Zhu <zhujack@mail.nih.gov>, Sean Davis <sdavis2@mail.nih.gov>}
\examples{
if(file.exists('GEOmetadb.sqlite')) {
    con <- dbConnect(SQLite(), "GEOmetadb.sqlite")
	getBiocPlatformMap(con)[1:5,]
	dbDisconnect(con)
} else {
  print("You will need to usethe getSQLiteFile() function to get a copy
of the SQLite database file before this example will work")
}
}
\keyword{ database }
