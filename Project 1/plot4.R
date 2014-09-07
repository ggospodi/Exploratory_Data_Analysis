temp <- tempfile() # open a temporary file for the unzip
# download the zipped file to the temporary file:
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unzip(temp, "household_power_consumption.txt")) # unzip and bring file up into memory
unlink(temp) # dispose of the temporary file
data<-read.csv("household_power_consumption.txt",sep=";",na.strings="?",stringsAsFactors=FALSE) # read the file as a data.frame
first<-min(which(data$Date=="1/2/2007")) # find the upper bound of the range we want
last<-max(which(data$Date=="2/2/2007"))  # find the lower bound of the range we want
x1<-data[first:last,]  # extract the data range defined by the two bounds
x2 <- as.Date(x1$Date, format = "%d/%m/%Y") # convert the date class format to "Date"
x3 <- as.POSIXct(paste(x2, x1$Time)) # combine the Date and Time as a single POSIXct class
png("plot4.png")    # initiate a png plot
par(mfrow=c(2,2)) # tile the plot screen into four plot fields
plot(x3,x1$Global_active_power,type= "l",
     ylim=c(min(x1$Global_active_power),max(x1$Global_active_power)),
     xlab="",ylab="Global Active Power (kilowatts)") # this is just plot 2
plot(x3, x1$Voltage, type="l", xlab="datetime", ylab="Voltage")   # this is the second plot of the first row
# then we instert plot 3:
plot(x3, x1$Sub_metering_1, type="l", xlab="", ylab= "Energy sub metering") # this is the first plot on the second row
lines(x3, x1$Sub_metering_2, type="l", col="red")  # add line connections for different metering categories
lines(x3, x1$Sub_metering_3, type="l", col="blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, 
       col=c("black", "red", "blue")) # create legend in the upper right corner
plot(x3, x1$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")  # this is the fourth plot.
dev.off()