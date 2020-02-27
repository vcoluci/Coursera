quiz3 <- function(){
  GDP <- data.table::fread('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                               , skip=5
                               , nrows=190
                               , select = c(1, 2, 4, 5)
                               , col.names=c("CountryCode", "Rank", "Country", "GDP"))
  ED <- data.table::fread("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv")
  
  mergedDT <- merge(GDP, ED, by = 'CountryCode')
  mergedDT[grepl(pattern = "Fiscal year end: June 30;", mergedDT[, `Special Notes`]), .N]
}