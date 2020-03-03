loadData <- function() {
  
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
  return (sub_data)
  #nao testei como usar este arquivo
  #nao verifiquei como posso ler o sub_data no arquivo chamador
}