getSQLiteFile <-
function(destdir=getwd(),destfile='GEOmetadb.sqlite.gz') {
  localfile <- file.path(destdir,destfile)
  url_geo = "http://starbuck1.s3.amazonaws.com/sradb/GEOmetadb.sqlite.gz"

  download.file(url_geo, destfile=localfile,mode='wb')
  cat('Unzipping...\n')
  gunzip(localfile,overwrite=TRUE)
  unzippedlocalfile <- gsub('[.]gz$','',localfile)
  con <- dbConnect(SQLite(),unzippedlocalfile)
  dat <- dbGetQuery(con,'select * from metaInfo')
  dbDisconnect(con)
  cat("Metadata associate with downloaded file:\n")
  print(dat)
  return(unzippedlocalfile)
}

