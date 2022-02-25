library("data.table")

setwd("~/Desktop/NewR/Data/project-1/")

# Reads in data from data set, remove N/A's
power_data_table <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# print(power_data_table)

# Prevents histogram from printing in scientific notation
power_data_table[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type
power_data_table[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
power_data_table <- power_data_table[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# create png
png("plot1.png", width=480, height=480)

## Plot 1
hist(power_data_table[, Global_active_power], main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()