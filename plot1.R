## Loading required libraries
library(gsubfn)
library(proto)
library(RSQLite)
library(DBI)
library(tcltk)
library(sqldf)

# Create data frame by reading the input file and filtering out the content.
household <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date IN ('1/2/2007','2/2/2007')", header = TRUE, sep = ";")

## Open PNG device; create "plot1.png" in working directory
png(file = "plot1.png", width = 480, height = 480, units = "px")

## Creating histogram plot
hist(household$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

unlink(household) ## Closing the data frame
dev.off()         ## Close the PNG file device