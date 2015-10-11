plot2 <- function() { 
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
        # Transform Global_active_power to numeric for plot 
        data$Global_active_power = as.numeric(as.character(data$Global_active_power))
        
        # Create plot
        png("plot2.png", width = 480, height=480, type="Xlib")
        plot(x = data$Date, y = data$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
        
        ## Close device
        dev.off()        
}