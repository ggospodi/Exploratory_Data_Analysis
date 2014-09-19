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
lvNEI<-vNEI[vNEI$fips=="06037",] # extract all LA vehicles emissions
together<-rbind(bvNEI,lvNEI)
bvNEI$city <- "Baltimore City"
lvNEI$city <- "Los Angeles County"
library(ggplot2)
png('plot6.png', width=600, height=480,units="px")
print(ggplot(together,aes(x=factor(year),y=Emissions,fill=city)) +
        geom_bar(aes(fill=year),stat="identity") +
        theme_bw() +  
        guides(fill=FALSE) +
        facet_grid(.~fips,scales="free", space="free") +
        xlab("Years")+
        ylab(expression("Baltimore and LA PM"[2.5]*" Emission [in 10^5 Tons]")) + 
        ggtitle(expression("Baltimore and LA Vehicle PM"[2.5]*" Emissions")))
dev.off()