getSQLiteFile <-
function(destdir=getwd(),destfile='GEOmetadb.sqlite.gz') {
  localfile <- file.path(destdir,destfile)
  url_geo_1 = 'https://gbnci-abcc.ncifcrf.gov/geo/GEOmetadb.sqlite.gz'
  url_geo_2 = 'https://dl.dropboxusercontent.com/u/51653511/GEOmetadb.sqlite.gz'
  url_geo_3 = 'http://watson.nci.nih.gov/~zhujack/GEOmetadb.sqlite.gz'
  if(! inherits(try(url(url_geo_1, open='rb'), silent = TRUE), "try-error") ) {
     url_geo = url_geo_1
  } else if(! inherits(try(url(url_geo_2, open='rb'), silent = TRUE), "try-error") ) {
     url_geo = url_geo_2
  } else {
     url_geo = url_geo_3
  }

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

