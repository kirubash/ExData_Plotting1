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

# Create a png graphics device in working directory
png(file="plot1.png",width=480,height=480)

# Add a histogram of Global Active Power to the png device 
hist(power$Global_active_power,xlab="Global Active Power (kilowatts)",
     col="red",main="Global Active Power",xaxp=c(0,6,3), 
     yaxp=c(0,1200,6))

# Close graphic device
dev.off()
