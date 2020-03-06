plot2 <- function() {
  NEI <- readRDS("summarySCC_PM25.rds")
  
  baltimore <- subset(NEI, fips == "24510", select = c(year, Emissions))
    
  aggregatedTotalByYear <- aggregate(Emissions ~ year, data = baltimore, sum)
  
  png('plot2.png')
  barplot(height=aggregatedTotalByYear$Emissions, 
          names.arg=aggregatedTotalByYear$year, 
          xlab="years", 
          ylab=expression('total PM'[2.5]*' emission'),
          main=expression('Total PM'[2.5]*' emissions at various years'))
  dev.off()
}