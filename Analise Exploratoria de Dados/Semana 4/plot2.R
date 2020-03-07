plot2 <- function() {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  NEISCC <- merge(NEI, SCC, by="SCC")
  
  aggregatedTotalByYear <- aggregate(Emissions ~ year, data = baltimore, sum)
  
  png('plot2.png')
  barplot(height=aggregatedTotalByYear$Emissions, 
          names.arg=aggregatedTotalByYear$year, 
          xlab="years", 
          ylab=expression('total PM'[2.5]*' emission'),
          main=expression('Total PM'[2.5]*' emissions at various years'))
  dev.off()
}