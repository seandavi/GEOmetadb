\name{getSQLiteFile}
\alias{getSQLiteFile}
\title{Download and unzip the most recent GEOmetadb SQLite file}
\description{
  This function is the standard method for downloading and unzipping the
  most recent GEOmetadb SQLite file from the server.
}
\usage{
getSQLiteFile(destdir = getwd(), destfile = "GEOmetadb.sqlite.gz")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{destdir}{The destination directory of the downloaded file}
  \item{destfile}{The filename of the downloaded file. This filename
    should end in ".gz" as the unzipping assumes that is the case}
}
\value{
  Prints some diagnostic information to the screen.

  Returns the local filename for use later.
}
\references{http://meltzerlab.nci.nih.gov/apps/geo, http://gbnci.abcc.ncifcrf.gov/geo/}
\author{Sean Davis <sdavis2@mail.nih.gov>}
\examples{
\dontrun{geometadbfile <- getSQLiteFile()}
}
\keyword{ IO }
\keyword{ database }
