rm(list=ls())
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists("NEI_data.zip")){
  download.file(fileUrl, "NEI_data.zip")
  unzip(zipfile = "NEI_data.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 3 - with ggplot2
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
## Which have seen increases in emissions from 1999–2008? 
library(dplyr)
library(ggplot2)

Baltimore <- filter(NEI, NEI$fips == "24510")
Baltimore <- dplyr::group_by(Baltimore, year, type)
Baltimore <- summarize(Baltimore, sum(Emissions))
colnames(Baltimore) <- c("Year", "Source_type", "PM25_Emissions")

png(filename = "plot3.png", width = 700, height = 480)
g <- ggplot(Baltimore, aes(Year, PM25_Emissions))
g + geom_line(aes(color=Source_type)) + ggtitle(label = "Baltimore PM 2.5 emission trends", subtitle = "Per source type") + annotate("segment", x = 1999, y = 297, xend = 2008, yend = 345, color = "purple", linetype = "dashed", size = 1.2) + annotate("text", x= 2004, y= 450, color = "purple", label = "'POINT' trendline: emissions increased from 1999 to 2008") + ylab("PM 2.5 Emissions (tons)")
dev.off()
