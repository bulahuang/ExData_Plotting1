# hasfile <- grepl("^exdata-data-household_power_consumption",dir())
filenames <- dir()
if (file.exists("exdata-data-household_power_consumption.zip") && !dir.exists("exdata-data-household_power_consumption")) {
  print("file already downloaded")
}else{
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "exdata-data-household_power_consumption.zip")
  unzip(zipfile = "exdata-data-household_power_consumption.zip" )
}



all_data <- read.table(filenames[grepl("household_power_consumption.txt",dir())],na.strings = "?",
                       header = TRUE,
                       check.names = FALSE,
                       sep = ";")
all_data$datetime <- dmy_hms(apply(all_data[,1:2], 1, paste, collapse=" "))
all_data <- subset(all_data,Date == "1/2/2007" | Date == "2/2/2007")

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(all_data, {
  plot(Global_active_power~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()
