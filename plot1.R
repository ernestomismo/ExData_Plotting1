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
png(file="plot1.png")
par(mfrow=c(1,1))
hist(df$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.off()