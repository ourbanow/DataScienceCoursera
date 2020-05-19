rm(list=ls())
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists("NEI_data.zip")){
  download.file(fileUrl, "NEI_data.zip")
  unzip(zipfile = "NEI_data.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
library(dplyr)
library(ggplot2)

On_Road <- filter(NEI, NEI$type == "ON-ROAD") ## filtered per type "On-road" for the source of pollution
BaltOR <- filter(On_Road, On_Road$fips == "24510")
BaltOR <- group_by(BaltOR, year)
BaltOR <- summarize(BaltOR, sum(Emissions))
colnames(BaltOR) <- c("Year", "PM25_Emissions")

png(filename = "plot5.png", width = 700, height = 480)
q <- ggplot(BaltOR, aes(Year, PM25_Emissions))
q + geom_line() + ggtitle(label = "Baltimore PM 2.5 emissions - on-road motor vehicles", subtitle = "From ON-ROAD source type") + ylab("PM 2.5 Emissions (tons)")
dev.off()
