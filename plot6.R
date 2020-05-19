rm(list=ls())
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists("NEI_data.zip")){
  download.file(fileUrl, "NEI_data.zip")
  unzip(zipfile = "NEI_data.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 6
## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?
library(dplyr)
library(ggplot2)

On_Road <- filter(NEI, NEI$type == "ON-ROAD")
Balt_LA_OR <- filter(On_Road, On_Road$fips %in% c("24510","06037"))
Balt_LA_OR <- group_by(Balt_LA_OR, year, fips)
Balt_LA_OR <- summarize(Balt_LA_OR, sum(Emissions)) 
colnames(Balt_LA_OR) <- c("Year", "County", "PM25_Emissions")

png(filename = "plot6.png", width = 700, height = 480)
p <- ggplot(Balt_LA_OR, aes(Year, PM25_Emissions))
p + geom_line(aes(color=County)) + ggtitle(label= "Baltimore and L.A. - on-road motor vehicles PM 2.5 emissions", subtitle = "From ON-ROAD source type") + annotate("text", x= 2003, y = 4000, color = "red", label = "Los Angeles") + annotate("text", x= 2003, y = 500, color = "darkturquoise", label = "Baltimore") + ylab("PM 2.5 Emissions (tons)")
dev.off()
