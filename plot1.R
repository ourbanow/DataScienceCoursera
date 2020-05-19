rm(list=ls())
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists("NEI_data.zip")){
  download.file(fileUrl, "NEI_data.zip")
  unzip(zipfile = "NEI_data.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission 
## from all sources for each of the years 1999, 2002, 2005, and 2008.

trend <- with(NEI, tapply(Emissions, year, sum))

png(filename = "plot1.png")
plot(c(1999,2002,2005,2008),trend, xlab = "Year", ylab= "Total PM2.5 emission (tons)", main = "PM2.5 pollution trend")
segments(1999,trend[1], 2002, trend[2], col = "red", lwd=1.2)
segments(2002, trend[2], 2005, trend[3], col = "red", lwd=1.2)
segments(2005, trend[3], 2008, trend[4], col = "red", lwd=1.2)
dev.off()

## The answer is yes