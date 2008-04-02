`columnDescriptions` <-
function(sqlite_db_name='GEOmetadb.sqlite') {
  con <- dbConnect(SQLite(),sqlite_db_name)
  dat <- dbGetQuery(con,'select * from geodb_column_desc')
  dbDisconnect(con)
  return(dat)
}

