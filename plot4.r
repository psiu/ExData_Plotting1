library(lubridate)
library(dplyr)

#############################
## Constants and controls
rawDataFile <- "exdata-data-household_power_consumption.zip"
downloadURL <- "https://github.com/psiu/ExData_Plotting1/blob/master/exdata-data-household_power_consumption.zip"
outputFile <- "plot4.png"

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
##  Plot

data <- loadRawData()

png(outputFile, width=480, height=480)

## Multiple plots
par(mfcol = c(2, 2))

## Plot 2
plot(Global_active_power ~ Date, data, ylab="Global Active Power", type = 'l', xlab="")

## Plot 3
plot(Sub_metering_1  ~ Date, data, ylab="Energy sub metering", type = 'l', xlab ="")
lines(data$Sub_metering_2 ~ data$Date, col = "red")
lines(data$Sub_metering_3 ~ data$Date, col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, lty = 1, cex = .9, bty = "n")

## Voltage
plot(Voltage ~ Date, data, ylab="Voltage", type = 'l', xlab="datetime")

## Global reactive power
plot(Global_reactive_power ~ Date, data, ylab="Global_reactive_power", type = 'l', xlab="datetime")

dev.off()



