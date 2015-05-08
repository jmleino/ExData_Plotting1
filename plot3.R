# The script assumes that the data file is in the working directory

#Change locale setting for English weekday names
Sys.setlocale("LC_TIME", "C")


# Read the data
data <- read.csv("household_power_consumption.txt", sep=";")

# Convert the date column to date
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Select right rows
data2 <- data[ data$Date %in% as.Date( c('2007-02-01','2007-02-02') ),]

# Add datetime column
data2  <- cbind( strptime( paste( data2$Date, data2$Time ), 
                           "%Y-%m-%d %H:%M:%S" ), data2 )

# Name the new column
names(data2)[1] <- "DateTime"

# Convert factors to numerics
for ( i in 4:10 )
      data2[,i] <-as.numeric( as.character( data2[,i] ) )

png( file = "plot3.png")

plot(data2$DateTime, data2$Sub_metering_1, type = "n", 
     ylab = "Energy sub metering", xlab = "")
lines(data2$DateTime, data2$Sub_metering_1, col = "black")
lines(data2$DateTime, data2$Sub_metering_2, col = "red")
lines(data2$DateTime, data2$Sub_metering_3, col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1,1,1))

dev.off()
