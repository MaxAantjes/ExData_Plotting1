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

## Select the rows of interest
dat3 <- subset(dat2, Date >= "2007-02-01" & Date <= "2007-02-02")

## Create plot
png(file = "plot3.png", width = 480, height = 480, units = "px")
par(mfrow = c(1,1))
dat3$date.and.time <- as.POSIXct(paste(dat3$Date, dat3$Time), 
                                 format = "%Y-%m-%d %H:%M:%S")
plot(dat3$date.and.time, dat3$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(dat3$date.and.time, dat3$Sub_metering_2, type = "l",
     xlab = "", ylab = "Energy sub metering", col = "red")
lines(dat3$date.and.time, dat3$Sub_metering_3, type = "l",
      xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1), col = c("black", "red", "blue"))
dev.off()