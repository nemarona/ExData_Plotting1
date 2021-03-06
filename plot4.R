## Exploratory Data Analysis
## Course 4 in the Data Science Specialization at Coursera
## Course Project 1
## Plot 4

## Set the working directory

setwd("/home/eduardo/Dropbox/datascience/coursera/4-exdata/project1/")

## Get data
## If file hpc.zip does not exist, download it:

zipfile <- "hpc.zip"
if (!file.exists(zipfile)) {
    zipurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url = zipurl, destfile = zipfile, method = "curl")
}

## Extract files from the zip archive
## If files already exist, do not overwrite them

datafile <- "household_power_consumption.txt"
if (!file.exists(datafile)) {
    unzip(zipfile, overwrite = FALSE)
}

## Rough estimate of the memory requirements for loading the full dataset.
## There are 2,075,259 rows and 9 columns, all of which hold numerical data.
## With 8 bytes per number, this boils down to 143 MB of memory required for the full dataset.

## Load dplyr and lubridate packages

library("lubridate")
library("dplyr")

## Load the data into R
## First measurement at 16/12/2006 17:24:00
## With 1440 min in a day, we need to load at least 72,000 rows
## to reach the target dates of 01/02/2007 and 02/02/2007.

hpc <- read.table(datafile, header = TRUE, sep = ";", na.strings = "?",
                  nrows = 72000, stringsAsFactors = FALSE)

## Use dplyr to filter only rows in the desired dates
## Create new column pasting together date and time
## Parse this new column as a POSIXct object with lubridate

hpc <- hpc %>%
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
    mutate(Date_Time = paste(Date, Time))

hpc$Date_Time <- dmy_hms(hpc$Date_Time)

## Ready to plot!

## Open png device
## Default width and height are 480 px each, as required, so no need to specify them
## Please note that "jue", "vie" and "sáb" are Spanish short day names.

png(filename = "plot4.png")

## 2x2 matrix of plots, to be filled row-wise.

par(mfrow = c(2, 2))

## Plot at position (1, 1)

plot(hpc$Date_Time, hpc$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

## Plot at position (1, 2)

plot(hpc$Date_Time, hpc$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

## Plot at position (2, 1)

## First, create plot with Sub_metering_1 data

plot(hpc$Date_Time, hpc$Sub_metering_1,
     type = "l",
     col = "black",
     xlab = "",
     ylab = "Energy sub metering")

## Then, add data for Sub_metering_2 and Sub_metering_3

lines(hpc$Date_Time, hpc$Sub_metering_2, col = "red")
lines(hpc$Date_Time, hpc$Sub_metering_3, col = "blue")

## Finally, add a legend

legend("topright",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = paste("Sub metering", c(1, 2, 3)))

## Plot at position (2, 2)

plot(hpc$Date_Time, hpc$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global reactive power")

## Close png device

dev.off()

##
##
##
##
##
##
##
##
##
##
##
