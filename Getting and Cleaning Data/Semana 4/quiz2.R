quiz2 <- function(){
  GDPrank <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
                               , skip=5
                               , nrows=190
                               , select = c(1, 2, 4, 5)
                               , col.names=c("CountryCode", "Rank", "Country", "GDP"))
  GDPrank[, mean(as.integer(gsub(pattern = ',', replacement = '', x = GDP )))]
}