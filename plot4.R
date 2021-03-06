dir <- paste(getwd(), "/", sep="")
# Get the files if not already here
if(!file.exists("./household_power_consumption.txt")){
    tmp <- paste(dir, "tmp.zip", sep="")
    # Download file, unzip and remove the temporary file
    urlFile <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(urlFile, destfile=tmp)
    unzip(tmp)
    file.remove(tmp)
}

#reading data
df <- read.table(file="./household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE,
                 na.strings="?")

# We only need data from two dates
df <- subset(df, df$Date=="1/2/2007" | df$Date=="2/2/2007")

# date and time in only one column
df$date_time <- paste(df$Date, df$Time, sep=" ")
df$date_time <- strptime(df$date_time, format="%d/%m/%Y %H:%M:%S")
df$Date <- NULL
df$Time <- NULL

#Creating the plot
png(file="plot4.png")
par(mfrow=c(2,2), mar=c(4,4,2,1))
plot(df$date_time, df$Global_active_power, type="l", ylab="Global Active Power", xlab="")
plot(df$date_time, df$Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(df$date_time, df$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(df$date_time, df$Sub_metering_2, type="l", col="red")
lines(df$date_time, df$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, col = c("black", "blue", "red"), bty="n", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
plot(df$date_time, df$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()