rm(list=ls())
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists("NEI_data.zip")){
  download.file(fileUrl, "NEI_data.zip")
  unzip(zipfile = "NEI_data.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
trendbalt <- with(filter(NEI, NEI$fips == "24510"), tapply(Emissions, year, sum))

png(filename = "plot2.png")
plot(c(1999,2002,2005,2008),trendbalt, pch=16, col = "blue", xlab = "Year", ylab= "Total PM2.5 emission in tons", main = "PM2.5 pollution trend in Baltimore City")
segments(1999,trendbalt[1], 2002, trendbalt[2], col = "cornflowerblue", lwd=1.2)
segments(2002, trendbalt[2], 2005, trendbalt[3], col = "cornflowerblue", lwd=1.2)
segments(2005, trendbalt[3], 2008, trendbalt[4], col = "cornflowerblue", lwd=1.2)
arrows(1999,trendbalt[1], 2008, trendbalt[4], col = "blue", lwd=2)
dev.off()

## The answer is yes