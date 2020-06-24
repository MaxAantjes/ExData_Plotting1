library(chron, dplyr)

## Load file into R
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
td = tempdir()
temp = tempfile(tmpdir=td, fileext=".zip")
download.file(url,temp)
unzip(temp, overwrite=TRUE)
dat0 <- read.csv("household_power_consumption.txt", sep = ";",
                   na.strings = "?")
unlink(temp)

## Convert variables to the right class. 
dat1 <- transform(dat0, Date = as.Date(Date, format = "%d/%m/%Y"))
dat2 <- transform(dat1, Time = times(Time))
dat2$Global_active_power <- as.numeric(dat2$Global_active_power)

## Select the rows of interest
dat3 <- subset(dat2, Date >= "2007-02-01" & Date <= "2007-02-02")

## Create plot
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(dat3$Global_active_power, ylab = "Frequency", xlab = 
             "Global Active Power (kilowatts)", main = "Global Active Power",
     freq = TRUE, xlim = c(0, 6), col = "red")
dev.off()
