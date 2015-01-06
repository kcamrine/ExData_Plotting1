library('lubridate')
setwd("~/Documents/classes/data_science_toolbox/course4/")
#download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="Fhousehold_power_consumption.zip",method="curl") # done once

household_power_consumption <- read.table("household_power_consumption.txt",
                                          sep=";",header=TRUE,
                                          colClasses=c("character",
                                                       "character",rep("numeric",7)),na.strings=c("?")) #load data
#determine dates
Date.Time <- strptime(paste(household_power_consumption$Date,household_power_consumption$Time),"%d/%m/%Y %H:%M:%S")
#assign interval
get.dates <- interval(strptime("2007-02-01 00:00:01","%Y-%m-%d %H:%M:%S"),strptime("2007-02-02 23:59:00","%Y-%m-%d %H:%M:%S"))
#keep data in interval
household_power_consumption <- household_power_consumption[Date.Time %within% get.dates,]

png("plot1.png")

dev.off()