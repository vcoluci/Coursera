plot3 <- function() {
  library(ggplot2)
  NEI <- readRDS("summarySCC_PM25.rds")
  
  baltimore <- subset(NEI, fips == "24510", select = c(year, Emissions, type))
  
  aggregatedTotalByYearType <- aggregate(Emissions ~ year + type, data = baltimore, sum)
  
  png('plot3.png', width=640, height=480)
  g <- ggplot(aggregatedTotalByYearType, aes(year, Emissions, color = type))
  g <- g + geom_line() +
    xlab("year") +
    ylab(expression('Total PM'[2.5]*" Emissions")) +
    ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')
  print(g)
  dev.off()
}