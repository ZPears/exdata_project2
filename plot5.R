#load data
pmData <- readRDS("summarySCC_PM25.rds")
classCode <- readRDS("Source_Classification_Code.rds")

#create main table
data <- merge(pmData, classCode, by="SCC")
vehicleData <- subset(data, grepl("Vehicle", data$EI.Sector))
vehicleData$EI.Sector <- factor(vehicleData$EI.Sector)
vehicleData <- vehicleData[which(vehicleData$fips=="24510"),]
sums <- as.numeric(rowsum(vehicleData$Emissions, vehicleData$year))
df <- cbind(c(1999, 2002, 2005, 2008), as.data.frame(sums))
names(df) <- c("x", "y")

#create plot
png("plot5.png")
with(df, plot(x, log(y), xaxt='n', col="blue", pch=19, main="On-Road Vehicle-Generated PM2.5 Emissions, Baltimore City", xlab="Year", ylab="Log of Total PM2.5 Emissions, On-Road Vehicles"))
model <- lm(log(y) ~ x, df)
abline(model, lwd=1.5, lty=3, col="red")
axis(side=1, at=df$x)
dev.off()