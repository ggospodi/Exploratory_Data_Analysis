temp <- tempfile() # open a temporary file for the unzip
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp) # download the zipped file to the temporary
unzip(temp)
NEI <- readRDS("summarySCC_PM25.rds") # unzip and bring file up into memory
unlink(temp) # dispose of the temporary file
data <- aggregate(Emissions ~ year,NEI, sum) # add all emmissions for each year
dataB<- NEI[NEI$fips=="24510",] # Baltimore emissions with fips=24510
totalB <- aggregate(Emissions ~ year, dataB,sum) # add all Baltimore emissions
library(ggplot2) # using the ggplot2 library
png('plot3.png',width=580,height=480,units="px")
print(ggplot(dataB,aes(factor(year), Emissions, fill=type))+ # define the data and plot type
  geom_bar(stat="identity")+ # define the bars
  theme_bw()+ # define the boundaries of each subplot
  facet_grid(.~type,scales="free", space="free")+ # scaling parameters
  xlab("Years")+ # x-axis labels
  ylab(expression('Total PM'[2.5]*' Emissions [in Tons]')) + # y-axis labels
  ggtitle(expression('Baltimore City PM'[2.5]*' Emissions (1999-2008)'))) # title
dev.off()