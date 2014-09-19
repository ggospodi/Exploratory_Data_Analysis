temp <- tempfile() # open a temporary file for the unzip
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp) # download the zipped file to the temporary
unzip(temp)
NEI <- readRDS("summarySCC_PM25.rds") # unzip and bring the NEI file up into memory
SCC <- readRDS("Source_Classification_Code.rds") # unzip and bring the SCC file up into memory
unlink(temp) # dispose of the temporary file
vv <- grepl("vehicle",SCC$SCC.Level.Two,ignore.case=TRUE) # identify all vehicles for each year
vSCC <- SCC[vv,]$SCC # extract all vehicles for each year
vNEI<-NEI[NEI$SCC %in% vSCC,] # extract all vehicle emission data for each year
bvNEI<-vNEI[vNEI$fips=="24510",] # extract all Baltimore vehicles emissions
library(ggplot2)
png('plot5.png', width=600, height=480,units="px")
print(ggplot(bvNEI,aes(factor(year),Emissions)) +
        geom_bar(stat="identity",fill="red") +
        theme_bw() +  
        guides(fill=FALSE) +
        xlab("Years")+
        ylab(expression("Baltimore PM"[2.5]*" Emission [in 10^5 Tons]")) + 
        ggtitle(expression("Baltimore Vehicle Combustion PM"[2.5]*" Emissions")))
dev.off()