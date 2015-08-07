## data downloading and unzipped
if(!file.exists("exdata-data-household_power_consumption.zip")) {
    x <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", x)
    file <- unzip(x)
    unlink(x)
}

file <- "household_power_consumption.txt"

## data reading
data <- read.table(file, sep=";", header=TRUE, na.strings='?')

## convert date and time
data$dDatetime <- strptime(paste(data$Date, data$Time), "%d%m%y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%y")
## year(Date) == 2007 & month(Date) == 2 & (day(Date) == 1 | day(Date) == 2)
df <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
print(df$Date)
## cleaning data
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))


## plot4
plot4 <- function() {
	## make a 2 by 2 matrix
	par(mfrow=c(2,2))
	
	## upper left plot
	plot(data$Datetime, df$Global_active_power, type="1", xlab=" ", ylab="Global Active Power")
	
	## upper right plot
	plot(data$Datetime, df$Voltage, type="1", xlab="datetime", ylab="Voltage")
	
	## bottom left plot
	plot(data$Datetime, df$Sub-metering_1, type="1", xlab=" ", ylab="Energy sub metering")
	lines(data$Datetime, df$Sub_metering_2, type="1", xlab=" ", ylab="Energy sub metering", col="red")
	lines(data$Datetime, df$Sub_metering_3, type="1", xlab=" ", ylab="Energy sub metering", col="blue")
	## legend - bty removes the box, cex - shrinks the text
	legend("topright", c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1), lwd=c(1,1), bty="n", cex=5)
	## bottom right plot
	plot(data$Datetime, df$Global_reactive_power, type="1", xlab="datetime", ylab="Global_reactive_power", ylim="0, 0.5")
	
	## save
	dev.copy(png. file="plot4.png")
	dev.off()
}
plot4()
