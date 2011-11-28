`getSQLiteFile` <-
function(destdir=getwd(),destfile='GEOmetadb.sqlite.gz') {
  localfile <- file.path(destdir,destfile)
  ERR <- try( download.file('http://gbnci.abcc.ncifcrf.gov/geo/GEOmetadb.sqlite.gz', destfile=localfile,mode='wb'), silent=T )
  ##alternative download site
  if( inherits(ERR, "try-error") ) {
    download.file('http://watson.nci.nih.gov/~zhujack/GEOmetadb.sqlite.gz', destfile=localfile,mode='wb')
  }
  require(GEOquery) ### for gunzip
  cat('Unzipping...\n')
  gunzip(localfile,overwrite=TRUE)
  unzippedlocalfile <- gsub('[.]gz$','',localfile)
  require(RSQLite)
  con <- dbConnect(SQLite(),unzippedlocalfile)
  dat <- dbGetQuery(con,'select * from metaInfo')
  dbDisconnect(con)
  cat("Metadata associate with downloaded file:\n")
  print(dat)
  return(unzippedlocalfile)
}

