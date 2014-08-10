# establish the working area

mainDir <- "C:/Users/JoseVicente/Desktop/Data Science/Johns Hopkins/Exploratory Data Analysis/Week1/ExData_Plotting1"
subDir <- "data"

if(getwd()!=mainDir)
{
        setwd(mainDir)
}

if (!file.exists(subDir)){
        dir.create("./data", showWarnings = FALSE)
}


# download and unzip data

url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url, "./data/PM25data.zip")
unzip("./data/PM25data.zip", exdir = "./data")


# read data

dataSet <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                    check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
dataSet$Date <- as.Date(dataSet$Date, format="%d/%m/%Y")


# subset data to consider

dataSubset <- subset(dataSet, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(dataSet)


# transform dates

datetime <- paste(as.Date(dataSubset$Date), dataSubset$Time)
dataSubset$Datetime <- as.POSIXct(datetime)


# Plot required

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(dataSubset, {
        
        plot(Global_active_power~Datetime,
             type="l",
             xlab="",
             ylab="Global Active Power (kilowatts)")
        
        plot(Voltage~Datetime,
             type="l",
             xlab="",
             ylab="Voltage (volt)")
        
        plot(Sub_metering_1~Datetime,
             type="l",
             xlab="",
             ylab="Global Active Power (kilowatts)")
        
        lines(Sub_metering_2~Datetime,
              col='Red')
        
        lines(Sub_metering_3~Datetime,
              col='Blue')
        
        legend("topright",
               col=c("black", "red", "blue"),
               lty=1,
               lwd=2,
               bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        plot(Global_reactive_power~Datetime,
             type="l", 
             xlab="",
             ylab="Global Rective Power (kilowatts)")
        }
)


# save to png file

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()