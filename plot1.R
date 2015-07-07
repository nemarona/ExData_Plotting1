## Exploratory Data Analysis
## Course 4 in the Data Science Specialization at Coursera
## Course Project 1
## Plot 1

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

png(filename = "plot1.png")

## Make histogram

hist(hpc$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "red")

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
