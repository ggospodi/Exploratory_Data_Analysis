temp <- tempfile() # open a temporary file for the unzip
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",temp) # download the zipped file to the temporary
unzip(temp)
NEI <- readRDS("summarySCC_PM25.rds") # unzip and bring the NEI file up into memory
SCC <- readRDS("Source_Classification_Code.rds") # unzip and bring the SCC file up into memory
unlink(temp) # dispose of the temporary file
cdata <- grepl("comb",SCC$SCC.Level.One,ignore.case=TRUE) # add all combustion emissions for each year
rdata <- grepl("coal",SCC$SCC.Level.Four,ignore.case=TRUE) # add all coal emissions for each year
coaldata <- (cdata & rdata)
cSCC<-SCC[coaldata,]$SCC
cNEI<-NEI[NEI$SCC %in% cSCC,]
library(ggplot2)
png('plot4.png', width=600, height=480,units="px")
print(ggplot(cNEI,aes(factor(year),Emissions/10^5)) +
        geom_bar(stat="identity",fill="red") +
        theme_bw() +  
        guides(fill=FALSE) +
        xlab("Years")+
        ylab(expression("Nation-Wide PM"[2.5]*" Emission [in 10^5 Tons]")) + 
        ggtitle(expression("Nation-Wide Coal Combustion PM"[2.5]*" Emissions")))
dev.off()