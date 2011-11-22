#!/usr/bin/env Rscript
library(svUnit)
library(GEOmetadb)
suite = svSuiteList('GEOmetadb')
runTest(suite)
print(Log())
