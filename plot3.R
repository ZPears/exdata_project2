#dependencies
require(ggplot2)

#load data
pmData <- readRDS("summarySCC_PM25.rds")
classCode <- readRDS("Source_Classification_Code.rds")

#format data
pmData$year <- factor(pmData$year)
pmData$type <- factor(pmData$type)
pmData <- pmData[which(pmData$fips=="24510"),]

#create plot
qplot(year, Emissions, data = pmData, facets = . ~ type, stat = "summary", fun.y = "sum", xlab = "Year", ylab="Total PM2.5 Emissions, Tons", main = "Emissions by Type, 1999-2008: Baltimore City")
ggsave("plot3.png", height=6, width=8)