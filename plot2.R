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
png(file = "plot2.png", width = 480, height = 480, units = "px")

## Creating the plot
with(household, plot(Date.Time, Global_active_power,type ='l', xlab = "", ylab = "Global Active Power (kilowatts)"))

unlink(household) ## Closing data frame
dev.off() ## Close the PNG file device