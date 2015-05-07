##First we need to load the complete dataset.

file1 <- "./Documents/household_power_consumption.txt"
data <- read.csv(file1,
                 header=TRUE,
                 sep=";",
                 na.strings="?",
                 nrows=2075259,
                 check.names=FALSE,
                 comment.char="",
                 quote="\"")
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## We will be working with data from 2 days, so we need to subset that data.

data1 <- subset(data, subset=(Date == "1/2/2007" | Date == "2/2/2007"))

## We no longer need the complete dataset.
rm(data)

## We need to convert the dates.
datetime <- paste(as.Date(data1$Date), data1$Time)
data1$Datetime <- as.POSIXct(datetime)

## Making Plot 2
plot(data1$Global_active_power~data1$Datetime,
     type="l",
     ylab="Global Active Power(kilowatts)",
     xlab="")

## Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

