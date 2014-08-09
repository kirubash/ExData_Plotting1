# Download file from url to working directory
setwd("E:/Coursera/Data Science/Exploratory Data Analysis/Codes")
furl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(furl,"./PowerCons.zip")

# Unzip the downloaded file to working directory
unzip("PowerCons.zip")

# Read variable names from text file in to a character vector
varNam<-read.table("./household_power_consumption.txt",
                   sep=";",header = F, nrows=1)
varNames<-as.character(unname(unlist(varNam[1,])))

# Read data for days 1 & 2 of February 2014 in to a data frame 
# and add variable names
power<-read.table("./household_power_consumption.txt",sep=";",
                  header = F, col.names=varNames, na.strings="?",
                  nrows=2880,skip=66637)

# Add a new date/time variable in POSIXlt format to data frame
power$DaTime<-strptime(paste(power$Date,power$Time),
                       "%d/%m/%Y %H:%M:%S")

# Create a png graphics device in working directory
png(file="plot4.png",width=480,height=480)

# Create a panel of 2 rows and 2 columns in the graphic device
par(mfrow=c(2,2))

## Plot 1
# Add the time trend plot of Global Active Power on 1 & 2 February, 
# 2007 
plot(power$DaTime,power$Global_active_power,type="l",
     xlab="",ylab="Global Active Power")

## Plot 2
# Add the time trend plot of Voltage on 1 & 2 February, 2007 
plot(power$DaTime,power$Voltage,type="l",
     xlab="datetime",ylab="Voltage")

## Plot 3
# Add an empty plot area to the graphic device
plot(power$DaTime,power$Sub_metering_1,xlab="",
     ylab="Energy sub metering",type="n")
# Add time trend plot of submetering variables 1, 2 & 3 to plot area
points(power$DaTime,power$Sub_metering_1,col="black",type="l")
points(power$DaTime,power$Sub_metering_2,col="red",type="l")
points(power$DaTime,power$Sub_metering_3,col="blue",type="l")
# Add legend to the plot 
legend("topright",legend=c("Sub_metering_1","Sub_metering_2",
          "Sub_metering_3"), col=c("black","red","blue"),lty=1,bty="n")

## Plot 4
# Add the time trend plot of Global reactive power on 1 & 2 February, 
# 2007 
plot(power$DaTime,power$Global_reactive_power,type="l",
     xlab="datetime",ylab="Global_reactive_power")

# Close graphic device
dev.off()

