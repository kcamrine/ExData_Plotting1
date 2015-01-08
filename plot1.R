#### packages needed ###
library('lubridate')

#remove next 2 lines before final submission
# setwd("~/Documents/classes/data_science_toolbox/course4/ExData_Plotting1") 
#download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="Fhousehold_power_consumption.zip",method="curl") # done once

#### load and subset data ###
household_power_consumption <- read.table("household_power_consumption.txt",
                                          sep=";",header=TRUE,
                                          colClasses=c("character",
                                                       "character",rep("numeric",7)),
                                          na.strings=c("?")) #load data

Date.Time <- strptime(paste(household_power_consumption$Date,
                            household_power_consumption$Time),
                      "%d/%m/%Y %H:%M:%S") #determine dates

get.dates <- interval(strptime("2007-02-01 00:00:01","%Y-%m-%d %H:%M:%S"),
                      strptime("2007-02-02 23:59:00","%Y-%m-%d %H:%M:%S")) #define interval
household_power_consumption <- household_power_consumption[na.exclude(Date.Time
                                              %within% get.dates),] #keep data in interval

#### plot histogram ###
png("plot1.png",480,480,bg="transparent")
with(household_power_consumption,
     hist(Global_active_power,col="red",xlab="Global Active Power (kilowatts)",
          main="Global Active Power")
)
dev.off()