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

## Making Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data1, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="datetime")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Energy Sub Metering", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global_reactive_power",xlab="datetime")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
