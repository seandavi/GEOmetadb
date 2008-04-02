\name{geoConvert}
\alias{geoConvert}
\title{Cross-reference between GEO data types}
\description{
  A common task is to find all the GEO entities of one type associated
  with another GEO entity (eg., find all GEO samples associated with GEO
  platform 'GPL96'). This function provides a very fast mapping between
  entity types to facilitate queries of this type.
}
\usage{
geoConvert(in_list, out_type = c("gse", "gpl", "gsm", "gds", "sMatrix"), sqlite_db_name = "GEOmetadb.sqlite")
}
\arguments{
  \item{in_list}{Character vector of GEO entities to convert from.}
  \item{out_type}{Character vector of GEO entity types to which to convert.}
  \item{sqlite_db_name}{The filename of the GEOmetadb sqlite database file}
}
\value{
  A list of data.frames.
  
}
\references{http://meltzerlab.nci.nih.gov/apps/geo}
\author{Jack Zhu <zhujack@mail.nih.gov>}
\examples{
if(file.exists("GEOmetadb.sqlite")) {
  geoConvert('GPL96',out_type='GSM')
} else {
  print("Run getSQLiteFile() to get a copy of the GEOmetadb SQLite file
and then rerun the example")
}
}
\keyword{IO}
\keyword{database}
