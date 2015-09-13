library(lubridate)
library(dplyr)

#############################
## Constants and controls
rawDataFile <- "exdata-data-household_power_consumption.zip"
downloadURL <- "https://github.com/psiu/ExData_Plotting1/blob/master/exdata-data-household_power_consumption.zip"
outputFile <- "plot1.png"

#############################
## Helper functions

loadRawData <- function() {
    ## If raw data file does ont exist, download the data file
    if(!file.exists(rawDataFile)){
        download.file(downloadURL, rawDataFile)
    }
    data <- read.table(unz(rawDataFile, "household_power_consumption.txt"), sep = ";", header = TRUE, na.strings = "?")
    
    ## Merge date and time to follow tidy data principles
    data$Date <- dmy_hms(paste(data$Date, data$Time))
    data$Time <- NULL ## Clean up obsolete column
    
    ## Subset data according to requirements
    data <- data %>% filter(Date >= ymd("2007-02-01") & Date < ymd("2007-02-03"))
    
    return (data)
}

###########################
##  Plot 1

data <- loadRawData()

png(outputFile, width=480, height=480)
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", main ="Global Active Power", col = "Orangered")
dev.off()



