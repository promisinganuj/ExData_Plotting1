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
png(file = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2, 2))

## Creating the plot
with(household, {
    plot(Date.Time, Global_active_power,type ='l', xlab = "", ylab = "Global Active Power")
    plot(Date.Time, Voltage,type ='l', xlab = "datetime", ylab = "Voltage")
    plot(Date.Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
    lines(Date.Time, Sub_metering_1,col = "black")
    lines(Date.Time, Sub_metering_2,col = "red")
    lines(Date.Time, Sub_metering_3,col = "blue")
    legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Date.Time, Global_reactive_power,type ='l', xlab = "datetime", ylab = "Global_reactive_power")
})

## Closing data frame
unlink(household)
dev.off() ## Close the PNG file device
