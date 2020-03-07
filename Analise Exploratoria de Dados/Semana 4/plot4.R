plot4 <- function() {
  
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  NEISCC <- merge(NEI, SCC, by="SCC")
  
  rm(SCC)
  rm(NEI)
  
  coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
  subsetNEISCC <- NEISCC[coalMatches, ]
  
  aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)
  
  library(ggplot2)
  
  png('plot4.png', width=640, height=480)
  g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
  g <- g + geom_bar(stat="identity") +
    xlab("year") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle('Total Emissions from coal sources from 1999 to 2008')
  print(g)
  dev.off()
  
}