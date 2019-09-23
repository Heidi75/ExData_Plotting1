library(dplyr)
library(ggplot2)

#Note file explains how I came to this way to make the datafile

getwd()
File<- file("household_power_consumption.txt")
Data <- read.table(text = grep("^[1,2]/2/2007", readLines(File), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", na.strings = "?", header = TRUE, stringsAsFactors=FALSE )

Data$Date<-as.Date(Data$Date, format = "%d/%m/%Y")
Data$Datetime<-strptime(paste(Data$Date,Data$Time),"%F %T")

head(Data$Datetime,n=10)
head(Data,n=10)

#Generic Global Activity power (kilo) over Datetime
?plot
plot(Data$Datetime,Data$Global_active_power, ylab="Global Active Power (kilowatts)", xlab="", type="l")
#ggplot2 Global Activity power (kilo) over Datetime
#convert date/time and must be stored as POSIXct, not POSIXlt.Datetime
Data$Datetime<-as.POSIXct(Data$Datetime)

ggplot(Data, aes(x = Datetime, y= Global_active_power))+
  ylab("Global Active Power (kilowatts)")+
  #type lines graph as given in "l" for lines above in ggplot is
  geom_line()
  


