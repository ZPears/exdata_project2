#load data
pmData <- readRDS("summarySCC_PM25.rds")
classCode <- readRDS("Source_Classification_Code.rds")

#format data
pmData$year <- factor(pmData$year)
pmData <- pmData[which(pmData$fips=="24510"),]
sums <- as.numeric(rowsum(pmData$Emissions, pmData$year))
df <- cbind(c(1999, 2002, 2005, 2008), as.data.frame(sums))
names(df) <- c("x", "y")

#create plot
png("plot2.png")
with(df, plot(x, log(y), xaxt='n', col="blue", pch=19, main="Total PM2.5 Emissions by Year: Baltimore City, Maryland", xlab="Year", ylab="Log of Total PM2.5 Emissions, All Sources"))
model <- lm(log(y) ~ x, df)
abline(model, lwd=1.5, lty=3, col="red")
axis(side=1, at=df$x)
dev.off()