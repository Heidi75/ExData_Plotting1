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
