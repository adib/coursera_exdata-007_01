
library(data.table)
library(dplyr)
library(lubridate)

outputPlotFileName <- "../figure/plot1.png"
outputPlotWidth <- 480
outputPlotHeight <- 480

datasetFileName <- "../../household_power_consumption.txt"
datasetDateValues <- c("1/2/2007","2/2/2007")
datasetTimezone <- "CET"


readDataset <- function() {
  fread(datasetFileName)  %>%
    filter(Date == datasetDateValues) %>%
      mutate(
        Timestamp = dmy_hms(paste(Date,Time),tz=datasetTimezone),
        Global_active_power = as.numeric(Global_active_power),
        Global_reactive_power=as.numeric(Global_reactive_power),
        Voltage=as.numeric(Voltage),
        Sub_metering_1=as.numeric(Sub_metering_1),
        Sub_metering_2=as.numeric(Sub_metering_2),
        Sub_metering_3=as.numeric(Sub_metering_3))
}


makeplot <- function(dataset) {
  hist(dataset$Global_active_power,
       labels=c(0,1200,by=200),
       main="Global Active Power",
       xlab="Global Active Power (kilowatts)",
       col="red")
}

# Main

png(outputPlotFileName,width=outputPlotWidth,height=outputPlotHeight,bg="transparent")
makeplot(readDataset())
dev.off()

# End
