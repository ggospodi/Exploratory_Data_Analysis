temp <- tempfile() # open a temporary file for the unzip
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp) # download the zipped file to the temporary
data <- read.table(unzip(temp, "household_power_consumption.txt")) # unzip and bring file up into memory
unlink(temp) # dispose of the temporary file
data<-read.csv("household_power_consumption.txt",sep=";",na.strings="?",stringsAsFactors=FALSE) # read the fiel as a data.frame
first<-min(which(data$Date=="1/2/2007")) # find the upper bound of the range we want
last<-max(which(data$Date=="2/2/2007"))  # find the lower bound of the range we want
x1<-data[first:last,]  # extract the data range defined by the two bounds
x2 <- as.Date(x1$Date, format = "%d/%m/%Y") # convert the date class format to "Date"
x3 <- as.POSIXct(paste(x2, x1$Time)) # combine the Date and Time as a single POSIXct class
png("plot2.png")    # initiate a png plot
plot(x3,x1$Global_active_power,type= "l",
     ylim=c(min(x1$Global_active_power),max(x1$Global_active_power)),
xlab="",ylab="Global Active Power (kilowatts)") # create the main plot
dev.off()