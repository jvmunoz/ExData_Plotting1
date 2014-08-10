# establish the working area

Sys.setlocale("LC_TIME", "English")
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


# plot required

png("plot1.png", width = 480, height = 480)

hist(dataSubset$Global_active_power,
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency", col="Red")

dev.off()