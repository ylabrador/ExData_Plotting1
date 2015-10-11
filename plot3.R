plot3 <- function() { 
        # URL to download data
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        
        temp <- tempfile()
        
        #  Download the .zip data file
        download.file(fileUrl, destfile = temp, method = 'curl')
        # Read data from .zip
        dataRow <- read.csv2(unz(temp, "household_power_consumption.txt"))
        unlink(temp)
        
        # Transform Date with as.Data function
        dataRow$Date = as.Date(dataRow$Date, format="%d/%m/%Y")
        # We will only be using data from the dates 2007-02-01 and 2007-02-02.
        data <- dataRow[dataRow$Date == "2007-02-01" | dataRow$Date == "2007-02-02",]
        # Transform time to day + hour
        data$Date <- as.POSIXct(paste(data$Date, data$Time))
        # Transform Sub_metering_1, Sub_metering_2 and Sub_metering_3 to numeric for plot 
        data$Sub_metering_1 = as.numeric(as.character(data$Sub_metering_1))
        data$Sub_metering_2 = as.numeric(as.character(data$Sub_metering_2))
        data$Sub_metering_3 = as.numeric(as.character(data$Sub_metering_3))
        
        # Create plot
        png("plot3.png", width = 480, height=480, type="Xlib")
        plot(x = data$Date, y = data$Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering")
        points(x = data$Date, y=data$Sub_metering_2, type = "l", col = "red")
        points(x = data$Date, y=data$Sub_metering_3, type = "l", col = "blue")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch='_', col = c("black", "red", "blue"))
        
        ## Close device
        dev.off()        
}
