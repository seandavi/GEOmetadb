# This simple script downloads the most recent
# SQLite file for GEOmetadb, pulls the most recent
# data from it, and then writes out an RSS file
# with those data.  This file can be read from
# any RSS reader that supports RSS 2.0.
# Edit paths to make it work as you see fit for
# your environment.
makeGSERss <-
    function(fname,days) {
          require(GEOmetadb)
              b=getSQLiteFile(tempdir())
              con = dbConnect('SQLite',b)
              f = file(fname,'w')
              writeLines('<rss version="2.0">',f)
              writeLines("<channel>",f)
              writeLines('<title>NCBI Gene Expression Omnibus GSE Publications</title>',f)
              writeLines('<link>http://www.ncbi.nlm.nih.gov/geo</link>',f)
              writeLines('<description>This RSS feed tracks GSE publications on the NCBI GEO website</description>',f)
              writeLines(sprintf('<lastBuildDate>%s</lastBuildDate>',format.Date(Sys.Date(),"%a, %d %b %Y 08:00:00 EST")),f)
              writeLines("<language>en-us</language>",f)
              q = dbGetQuery(con,sprintf("select gse,title,submission_date,summary,web_link from gse where submission_date>'%s' order by submission_date desc",Sys.Date()-days))
              apply(q,1,function(x) {
                      writeLines(sprintf("<item><title><![CDATA[%s]]></title><link>http://www.ncbi.nlm.nih.gov/projects/geo/query/acc.cgi?acc=%s</link><guid>http://www.ncbi.nlm.nih.gov/projects/geo/query/acc.cgi?acc=%s</guid><pubDate>%s</pubDate><description><![CDATA[%s]]></description></item>",x[2],x[1],x[1],format.Date(as.Date(x[3]),"%a, %d %b %Y 08:00:00 EST"),x[4]),f)
                    })
              writeLines("</channel></rss>",f)
              close(f)
        }
makeGSERss('GSE.xml',30)
