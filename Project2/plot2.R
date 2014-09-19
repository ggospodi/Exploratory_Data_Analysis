temp <- tempfile() # open a temporary file for the unzip
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp) # download the zipped file to the temporary
unzip(temp)
NEI <- readRDS("summarySCC_PM25.rds") # unzip and bring file up into memory
unlink(temp) # dispose of the temporary file
data <- aggregate(Emissions ~ year,NEI, sum) # add all emmissions for each year
dataB<- NEI[NEI$fips=="24510",] # Baltimore emissions with fips=24510
totalB <- aggregate(Emissions ~ year, dataB,sum) # add all Baltimore emissions
png('plot2.png')
barplot( # create a barplot
  (totalB$Emissions)/10^3, # scale the y-axis
  names.arg=totalB$year, # specify the x-axis
  col=adjustcolor(rgb(0,0,1,1/2)), #define the color
  xlab="Years", # specify the x-label
  ylab=expression('PM'[2.5]*' Emissions [in 10^3 Tons]'), # specify the y-label
  main=expression('Net Baltimore PM'[2.5]*' Emissions') # specify the plot title
)
dev.off()