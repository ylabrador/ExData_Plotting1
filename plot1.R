plot1 <- function() { 
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
        # Transform Time with strptime function
        data$Time = strptime(data$Time, format = "%H:%M:%S")
        # Transform Global_active_power to numeric for plot 
        data$Global_active_power = as.numeric(as.character(data$Global_active_power))
        
        # Create histogram
        png("plot1.png", width = 480, height=480, type="Xlib")
        hist(data$Global_active_power, col = "red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")

        ## Close device
        dev.off()        
}