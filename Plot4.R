library(dplyr)
library(ggplot2)

#Note file explains how I came to this way to make the datafile
File<- file("household_power_consumption.txt")
Data <- read.table(text = grep("^[1,2]/2/2007", readLines(File), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", na.strings = "?", header = TRUE, stringsAsFactors=FALSE )

#make column date time must be in posixct to use ggplot
Data$Date<-as.Date(Data$Date, format = "%d/%m/%Y")
Data$Datetime<-strptime(paste(Data$Date,Data$Time),"%F %T")
Data$Datetime<-as.POSIXct(Data$Datetime)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(Data, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file="Plot4.png", height=480, width=480)

dev.off()

