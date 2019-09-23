library(dplyr)
library(ggplot2)

getwd()
File<- file("household_power_consumption.txt")
Data <- read.table(text = grep("^[1,2]/2/2007", readLines(File), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", na.strings = "?", header = TRUE, stringsAsFactors=FALSE )

datetime <- paste(as.Date(Data$Date), Data$Time)
Data$Datetime <- as.POSIXct(datetime)

str(Data)

hist(Data$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")

#2nd way to make it with ggplot2
ggplot(Data, aes(x = Global_active_power)) + 
  geom_histogram(fill = "red")+
  ggtitle("Global Active Power")+
  xlab("Global Active Power (kilowatts)")+
  ylab("Frequency")



