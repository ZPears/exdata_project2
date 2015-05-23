#dependencies
require(ggplot2)

#load data
pmData <- readRDS("summarySCC_PM25.rds")
classCode <- readRDS("Source_Classification_Code.rds")

#create main table
data <- merge(pmData, classCode, by="SCC")
vehicleData <- subset(data, grepl("Vehicle", data$EI.Sector))
vehicleData$EI.Sector <- factor(vehicleData$EI.Sector)
vehicleData <- subset(vehicleData, grepl("24510|06037", vehicleData$fips))
vehicleData$fips <- factor(vehicleData$fips)

#create plot
qplot(year, Emissions, data = vehicleData, facets = . ~ fips, stat = "summary", fun.y = "sum", xlab = "Year", ylab="Total PM2.5 Emissions, Tons", main = "Motor Vehicle Emissions, LA vs. Baltimore")
ggsave("plot6.png", height=6, width=8)