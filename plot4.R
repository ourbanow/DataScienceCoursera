rm(list=ls())
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists("NEI_data.zip")){
  download.file(fileUrl, "NEI_data.zip")
  unzip(zipfile = "NEI_data.zip")
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question 4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
library(dplyr)

index <- grepl("^Fuel.*Coal$", SCC$EI.Sector) ## filtering Fuel Combustion source, from Coal
Coal_comb <- filter(SCC, index)
Coal_comb_sources <- Coal_comb$SCC
Coal_comb_data <- subset(NEI, NEI$SCC %in% Coal_comb_sources)
Coal_comb_trend <- with(Coal_comb_data, tapply(Emissions, year,sum))

png(filename="plot4.png")
plot(c(1999,2002,2005,2008), Coal_comb_trend, xlab = "Year", ylab= "Total PM2.5 emissions (tons)", main = "Pollution from coal combustion-related sources in the US")
segments(1999,Coal_comb_trend[1], 2002, Coal_comb_trend[2], col = "blue", lwd=2)
segments(2002, Coal_comb_trend[2], 2005, Coal_comb_trend[3], col = "blue", lwd=2)
segments(2005, Coal_comb_trend[3], 2008, Coal_comb_trend[4], col = "blue", lwd=2)
dev.off()
