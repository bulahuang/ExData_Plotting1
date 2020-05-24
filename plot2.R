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

plot(all_data$Global_active_power~all_data$datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
