#load data
pmData <- readRDS("summarySCC_PM25.rds")
classCode <- readRDS("Source_Classification_Code.rds")

#create main table
data <- merge(pmData, classCode, by="SCC")
coalCombData <- subset(data, grepl("Coal", data$EI.Sector))
coalCombData$EI.Sector <- factor(coalCombData$EI.Sector)
sums <- as.numeric(rowsum(coalCombData$Emissions, coalCombData$year))
df <- cbind(c(1999, 2002, 2005, 2008), as.data.frame(sums))
names(df) <- c("x", "y")

#create plot
png("plot4.png")
with(df, plot(x, log(y), xaxt='n', col="blue", pch=19, main="Coal Combustion-Related PM2.5 Emissions, Nationwide ", xlab="Year", ylab="Log of Total PM2.5 Emissions, Coal"))
model <- lm(log(y) ~ x, df)
abline(model, lwd=1.5, lty=3, col="red")
axis(side=1, at=df$x)
dev.off()