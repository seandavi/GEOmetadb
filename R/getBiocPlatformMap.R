#################################################################################
## getBiocPlatformMap function:
## query and get mappings betwen GPL accessions and bioc_package names

## Usage of getBiocPlatformMap:
## arguments: getBiocPlatformMap (con)

################################################################################

getBiocPlatformMap <-
function(con, bioc='all') {
	
	bioc=tolower(bioc)
	if(bioc == 'all') {
		biocmap = dbGetQuery(con,'select title,gpl,bioc_package,manufacturer,organism,data_row_count from gpl where bioc_package is not NULL ORDER by bioc_package')
	} else {
		biocmap = dbGetQuery(con, paste("select title,gpl,bioc_package,manufacturer,organism,data_row_count from gpl where bioc_package IN ('", paste(bioc, sep='', collapse="','"), "') AND bioc_package IS NOT NULL ORDER by bioc_package", sep=''))
	}
	
	return(biocmap);
}

