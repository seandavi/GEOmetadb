#################################################################################
## geoConvert function:
## Converts GEO accessions from one type to one or more other types
## geoConvert table is being queried for conversions
## geoConvert table schema: from_acc TEXT,to_acc TEXT,to_type TEXT

## Usage of geoConvert:
## arguments: geoConvert (in_list, out_type = c('gse','gpl','gsm','gds','sMatrix'),sqlite_db_name='GEOmetadb.sqlite')
## in_list: character vector of GEO accessions - only one type allowed
## valid input type: anyone of 'gse','gpl','gsm' and 'gds'
## valid output types: any of c('gse','gpl','gsm', 'gds', 'sMatrix')
## sqlite_db_name: the GEO SQLite database file name and default is 'GEOmetadb.sqlite'

## Conversion types:
## 'gse' -> any of c('gpl','gsm', 'gds', 'sMatrix')
## 'gpl' -> any of c('gse','gsm', 'gds', 'sMatrix')
## 'gsm' -> any of c('gse','gpl')
## 'gds' -> any of c('gse','gpl')

## Example of geoConvert:
# in_list <- c("GPL97","GPL96");
# out_type <- c('gse','gpl','gsm','gds', 'sMatrix')
# sqlite_db_name = 'geodb_030608.sqlite'
# output <- geoConvert (sqlite_db_name, in_list, out_type , )

## Updates:
# Update1: reorder function arguments
# Update2: added valid_in_type <- c('gse','gpl','gsm','gds')
# Update3: modified the validation messages
# Update4: added SeriesMatrix as output

################################################################################

geoConvert <-
function(in_list, out_type = c('gse','gpl','gsm','gds','sMatrix'),sqlite_db_name='GEOmetadb.sqlite') {
	out_type <- tolower(out_type)
	out_type <- match.arg(out_type, several.ok = T)	
	
	## validate in_list
	valid_in_type <- c('gse','gpl','gsm','gds')
	in_list <- toupper(in_list)
	## trim leading or tailing spaces
	in_list <- sub('^\\s+|\\s+$','', in_list,perl=T)
	## the first three characters should not special characters and the last should be numbers 
	if(any(grep('\\^W{3}|\\D+$', in_list, perl=T))) stop("invalid input GEO accession(s), right ones are like 'GSE1' or 'GPL1', or 'GSM1', or 'GDS1'")
	## extract the leading characters, which should be valid 
	in_list_type = sub('\\d+$', '', in_list, perl= T)
	##they should be same, only one type
	if(length(unique(in_list_type)) != 1 ) stop("Only one type of GEO accession(s) is allowed in a input vector, either GSE, or GSM, or GPL or GDS.")
	## they should be valid
	if(!(tolower(unique(in_list_type)) %in%  valid_in_type)) stop("Input type shuld be either GSE, or GSM, or GPL or GDS.")
	
	## Exclude the in_type in the out_type
	in_type <- tolower(unique(in_list_type));
	out_type <- out_type[out_type!=in_type];
	
	##Eliminate self converion
	if(length(out_type) == 0) stop("Not necessary to convert to input itself, are you out of mind?");
		
	library(RSQLite);	
	
	sqlite_con <- dbConnect(dbDriver("SQLite"), sqlite_db_name)

	geo_out_list = list();
	for (i in 1:length(out_type)) {
				
		in_list_sql = paste("'", paste(in_list, collapse = "','"),"'", sep="");
		sql = paste ("select distinct from_acc, to_acc from geoConvert where to_type ='", out_type[i],"' AND from_acc in (", in_list_sql, ")", sep = "");
			 
		rs <- dbGetQuery(sqlite_con, sql);

	 	geo_out_list[out_type[i]] = list(rs)				
	}
	
	return(geo_out_list);
	## return (list (geo_out_list = geo_out_list, sql = sql))
	dbDisconnect(sqlite_con);
}

