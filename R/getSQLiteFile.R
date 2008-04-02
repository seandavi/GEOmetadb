`getSQLiteFile` <-
function(destdir=getwd(),destfile='GEOmetadb.sqlite.gz') {
  localfile <- file.path(destdir,destfile)
  download.file('http://meltzerlab.nci.nih.gov/apps/geo/GEOmetadb.sqlite.gz',
                destfile=localfile,mode='wb')
  require(GEOquery) ### for gunzip
  print('Unzipping...')
  gunzip(localfile,overwrite=TRUE)
  unzippedlocalfile <- gsub('[.]gz$','',localfile)
  require(RSQLite)
  con <- dbConnect(SQLite(),unzippedlocalfile)
  dat <- dbGetQuery(con,'select * from metaInfo')
  dbDisconnect(con)
  print("Metadata associate with downloaded file")
  print(dat)
  return(unzippedlocalfile)
}

