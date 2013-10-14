\name{columnDescriptions}
\alias{columnDescriptions}
\title{Get column descriptions for the GEOmetadb database}
\description{
  Searching the GEOmetadb database requires a bit of knowledge about the
  structure of the database and column descriptions. This function
  returns those column descriptions for all columns in all tables in the
  database.
}
\usage{
columnDescriptions(sqlite_db_name='GEOmetadb.sqlite')
}
\arguments{
  \item{sqlite_db_name}{The filename of the GEOmetadb sqlite database
    file}
}
\value{
  A three-column data.frame including TableName, FieldName, and Description.
}
\references{http://meltzerlab.nci.nih.gov/apps/geo}
\author{Sean Davis <sdavis2@mail.nih.gov>}
\examples{
if(file.exists('GEOmetadb.sqlite')) {
  columnDescriptions()[1:5,]
} else {
  print("You will need to usethe getSQLiteFile() function to get a copy
of the SQLite database file before this example will work")
}
}
\keyword{ database }
