library("data.table")

setwd("~/Desktop/NewR/Data/project-1/")

# Read in data from data set, remove N/A's
power_data_table <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
power_data_table[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
power_data_table[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
power_data_table <- power_data_table[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(power_data_table[, dateTime], power_data_table[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(power_data_table[, dateTime], power_data_table[, Sub_metering_2],col="red")
lines(power_data_table[, dateTime], power_data_table[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

dev.off()