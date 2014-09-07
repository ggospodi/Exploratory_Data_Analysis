temp <- tempfile() # open a temporary file for the unzip
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp) #download the zipped file to the temporary
data <- read.table(unzip(temp, "household_power_consumption.txt")) #unzip and bring file up into memory
unlink(temp) # dispose of the temporary file
data<-read.csv("household_power_consumption.txt",sep=";",na.strings="?",stringsAsFactors=FALSE) # read the fiel as a data.frame
first<-min(which(data$Date=="1/2/2007")) # find the upper bound of the range we want
last<-max(which(data$Date=="2/2/2007"))  # find the lower bound of the range we want
x1<-data[first:last,]  # extract the data range defoned by the two bounds
png("plot1.png")    # initiate a png plot
plot(hist(x1$Global_active_power), # plot a 480x480 pixel plot, with appropriate labels
     xlim=c(0,max(x1$Global_active_power)),
     col="red",xlab="Global Active Power (kilowatts)",
     ylab="Frequency",main = "Global Active Power")
dev.off()