dbconn = NULL
require(RSQLite)

.setUp <- function() {
  fname = 'GEOmetadb.sqlite'
  if(!file.exists(fname)) {
    fname = getSQLiteFile()
  }
  dbconn <<- dbConnect('SQLite',fname)
}

.tearDown <- function() {
  dbDisconnect(dbconn)
}

testDb <- svTest(function() {
  gsegplCount = nrow(dbGetQuery(dbconn,'select distinct gpl from gse_gpl'))
  gplCount = dbGetQuery(dbconn,'select count(*) from gpl')[1,1]
  checkEqualsNumeric(gsegplCount,gplCount,msg='Counts of distinct GPL in gse_gpl and gpl tables not equal')
  gsegsmCount = nrow(dbGetQuery(dbconn,'select distinct gsm from gse_gsm'))
  gsmCount = dbGetQuery(dbconn,'select count(*) from gsm')[1,1]
  checkEqualsNumeric(gsegsmCount,gsmCount,msg='Counts of distinct GSM in gse_gsm and gsm tables not equal')
})
  
  
