
library(dplyr)
library(data.table)
library(lubridate)

outputPlotFileName <- "../figure/plot3.png"
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
    colors <- c("black","red","blue")
    fieldNameBase <- "Sub_metering"
    fieldSeq <- 1:3
    rowCount <- nrow(dataset)
    xrange <-range(dataset$Timestamp)
    yrange <- range(dataset$Sub_metering_1)
    plot(x=xrange,y=yrange,xlab="",ylab="Energy sub metering",type="n")
    for(i in fieldSeq) {
        fieldName <- paste(fieldNameBase,i,sep="_")
        lines(x=dataset$Timestamp,y=dataset[,get(fieldName)],type="l",col=colors[i])
    }
    legendText <- paste(fieldNameBase,fieldSeq,sep="_")
    legend(x="topright",legendText,lty=1,col=colors)
}

# Main

png(outputPlotFileName,width=outputPlotWidth,height=outputPlotHeight,bg="transparent")
makeplot(readDataset())
dev.off()

# End
