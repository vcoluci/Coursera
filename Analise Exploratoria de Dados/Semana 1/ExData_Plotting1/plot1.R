plot1 <- function() {
  #se for usar o load_data, descomentar a linha abaixo.
  #source("load_data.R")
  
  #leitura - inicio
  #este trecho faz o mesmo que o load_data.R
  # download zip file containing data if it hasn't already been downloaded
  zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipFile <- "exdata_data_household_power_consumption.zip"
  
  if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode = "wb")
  }
  
  # unzip zip file containing data if data directory doesn't already exist
  fileName <- "household_power_consumption.txt"
  if (!file.exists(fileName)) {
    unzip(zipFile)
  }
  
  library(lubridate)
  data <- read.table(fileName, header = TRUE, sep = ";", dec = ".", stringsAsFactors = FALSE)
  sub_data <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
  rm(data)
  sub_data$DateTime <- paste(sub_data$Date, sub_data$Time, sep = " ")
  sub_data$DateTime <- dmy_hms(sub_data$DateTime)
  sub_data$Global_active_power <- as.numeric(sub_data$Global_active_power)
  sub_data$Sub_metering_1 <- as.numeric(sub_data$Sub_metering_1)
  sub_data$Sub_metering_2 <- as.character(sub_data$Sub_metering_2)
  sub_data$Sub_metering_3 <- as.character(sub_data$Sub_metering_3)
  
  #leitura - fim
  
  png(filename = "plot1.png",
      width = 480, height = 480, units = "px")
  with(sub_data, hist(Global_active_power,
                   main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
                   col = "red"))
  dev.off()
}