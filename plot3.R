## Loading required libraries
library(gsubfn)
library(proto)
library(RSQLite)
library(DBI)
library(tcltk)
library(sqldf)

## Create data frame by reading the input file and filtering out the content.
household <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date IN ('1/2/2007','2/2/2007')", header = TRUE, sep = ";")

## Adding a new column Date.Time to the data frame
household$Date.Time <- as.POSIXct(paste(household$Date, household$Time, sep =" "), format="%d/%m/%Y %H:%M:%S")

## Open PNG device; create "plot2.png" in working directory
png(file = "plot3.png", width = 480, height = 480, units = "px")

## Creating the plot
with(household, plot(Date.Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(household, lines(Date.Time, Sub_metering_1,col = "black"))
with(household, lines(Date.Time, Sub_metering_2,col = "red"))
with(household, lines(Date.Time, Sub_metering_3,col = "blue"))

legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Closing data frame
unlink(household)
dev.off() ## Close the PNG file device