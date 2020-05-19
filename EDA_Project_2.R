rm(list=ls())
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists("NEI_data.zip")){
  download.file(fileUrl, "NEI_data.zip")
  unzip(zipfile = "NEI_data.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
## This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. 
## For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year.
SCC <- readRDS("Source_Classification_Code.rds")
## This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source.

## Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission 
## from all sources for each of the years 1999, 2002, 2005, and 2008.

trend <- with(NEI, tapply(Emissions, year, sum))
plot(c(1999,2002,2005,2008),trend, xlab = "Year", ylab= "Total PM2.5 emission (tons)", main = "PM2.5 pollution trend")
segments(1999,trend[1], 2002, trend[2], col = "red", lwd=1.2)
segments(2002, trend[2], 2005, trend[3], col = "red", lwd=1.2)
segments(2005, trend[3], 2008, trend[4], col = "red", lwd=1.2)
## The answer is yes

## Question 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
trendbalt <- with(filter(NEI, NEI$fips == "24510"), tapply(Emissions, year, sum))
plot(c(1999,2002,2005,2008),trendbalt, pch=16, col = "blue", xlab = "Year", ylab= "Total PM2.5 emission in tons", main = "PM2.5 pollution trend in Baltimore City")
segments(1999,trendbalt[1], 2008, trendbalt[4], col = "blue", lwd=2)
## The answer is yes

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
g <- ggplot(Baltimore, aes(Year, PM25_Emissions))
g + geom_line(aes(color=Source_type)) + ggtitle(label = "Baltimore PM 2.5 emission trends", subtitle = "Per source type") + annotate("segment", x = 1999, y = 297, xend = 2008, yend = 345, color = "purple", linetype = "dashed", size = 1.2) + annotate("text", x= 2004, y= 450, color = "purple", label = "'POINT' trendline: emissions increased from 1999 to 2008")

## Question 4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
index <- grepl("^Fuel.*Coal$", SCC$EI.Sector) ## filtering Fuel Combustion source, from Coal
Coal_comb <- filter(SCC, index)
Coal_comb_sources <- Coal_comb$SCC
Coal_comb_data <- subset(NEI, NEI$SCC %in% Coal_comb_sources)
Coal_comb_trend <- with(Coal_comb_data, tapply(Emissions, year,sum))
plot(c(1999,2002,2005,2008), Coal_comb_trend, xlab = "Year", ylab= "Total PM2.5 emissions (tons)", main = "Pollution from coal combustion-related sources in the US")
segments(1999,Coal_comb_trend[1], 2002, Coal_comb_trend[2], col = "blue", lwd=2)
segments(2002, Coal_comb_trend[2], 2005, Coal_comb_trend[3], col = "blue", lwd=2)
segments(2005, Coal_comb_trend[3], 2008, Coal_comb_trend[4], col = "blue", lwd=2)

## Question 5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
On_Road <- filter(NEI, NEI$type == "ON-ROAD")
BaltOR <- filter(On_Road, On_Road$fips == "24510")
BaltOR <- group_by(BaltOR, year)
BaltOR <- summarize(BaltOR, sum(Emissions))
colnames(BaltOR) <- c("Year", "PM25_Emissions")

q <- ggplot(BaltOR, aes(Year, PM25_Emissions))
q + geom_line() + ggtitle(label = "Baltimore PM 2.5 emissions", subtitle = "From ON-ROAD source type")

## Question 6
## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

Balt_LA_OR <- filter(On_Road, On_Road$fips %in% c("24510","06037"))
Balt_LA_OR <- group_by(Balt_LA_OR, year, fips)
Balt_LA_OR <- summarize(Balt_LA_OR, sum(Emissions)) 
colnames(Balt_LA_OR) <- c("Year", "County", "PM25_Emissions_tons")
p <- ggplot(Balt_LA_OR, aes(Year, PM25_Emissions))
p + geom_line(aes(color=County)) + ggtitle(label= "Baltimore and LA PM 2.5 emissions", subtitle = "From ON-ROAD source type") + annotate("text", x= 2003, y = 4000, color = "red", label = "Los Angeles") + annotate("text", x= 2003, y = 500, color = "darkturquoise", label = "Baltimore")
