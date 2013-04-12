getSQLiteFile <-
function(destdir=getwd(),destfile='GEOmetadb.sqlite.gz') {
  localfile <- file.path(destdir,destfile)
  url_geo_1 = 'http://gbnci.abcc.ncifcrf.gov/geo/GEOmetadb.sqlite.gz'
  url_geo_2 = 'http://watson.nci.nih.gov/~zhujack/GEOmetadb.sqlite.gz'
  url_geo_3 = 'http://dl.dropbox.com/u/51653511/GEOmetadb.sqlite.gz'
  if(! inherits(try(url(url_geo_1, open='rb'), silent = TRUE), "try-error") ) {
     url_geo = url_geo_1
  } else if(! inherits(try(url(url_geo_2, open='rb'), silent = TRUE), "try-error") ) {
     url_geo = url_geo_2
  } else {
     url_geo = url_geo_3
  }

  download.file(url_geo, destfile=localfile,mode='wb')
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

