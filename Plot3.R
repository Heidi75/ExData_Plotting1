library(dplyr)
library(ggplot2)

#Note file explains how I came to this way to make the datafile
File<- file("household_power_consumption.txt")
Data <- read.table(text = grep("^[1,2]/2/2007", readLines(File), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", na.strings = "?", header = TRUE, stringsAsFactors=FALSE )

#make column date time must be in posixct to use ggplot
Data$Date<-as.Date(Data$Date, format = "%d/%m/%Y")
Data$Datetime<-strptime(paste(Data$Date,Data$Time),"%F %T")
Data$Datetime<-as.POSIXct(Data$Datetime)

head(Data)
#plot Energy submetering over Datetime
#3 columns Sub_metering_1 ( color black ) Sub_metering_2 ( color red) Sub_metering_3 (color blue) 
#Generic

plot(Data$Datetime,Data$Sub_metering_1, ylab="Energy Submetering", xlab="", type="l")
lines(Data$Datetime,Data$Sub_metering_2, col = 'Red')
lines(Data$Datetime,Data$Sub_metering_3, col = 'Blue')
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)


#Same graph in ggplot
ggplot()+
  geom_line(data=Data, aes(x = Datetime, y= Sub_metering_1 ))+
  geom_line(data=Data, aes(x = Datetime, y= Sub_metering_2), color = "Red") +
  geom_line(data=Data, aes(x = Datetime, y= Sub_metering_3), color = "Blue") +
  ylab("Energy Submetering")
#unsucessful at making a legend 
 
 

