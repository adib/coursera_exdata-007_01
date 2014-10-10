
library(dplyr)
library(data.table)
library(lubridate)

outputPlotFileName <- "../figure/plot2.png"
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
  plot(x=dataset$Timestamp, y=dataset$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
}

# Main

png(outputPlotFileName,width=outputPlotWidth,height=outputPlotHeight,bg="transparent")
makeplot(readDataset())
dev.off()

# End

