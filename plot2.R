#### packages needed ###
library('lubridate')

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

#### plot data ###
png("plot2.png",480,480,bg="transparent")
#this all works given that the rows are in order based on date (which it is)
with(household_power_consumption, {
  plot(Global_active_power,type="l",ylab="Global active power (kilowatts)",xaxt = "n",xlab = "")
  axis(side=1,at=c(1,which(Date %in% names(table(Date))[2])[1],length(Date)),
       labels=c("Thu","Fri","Sat")) 
})
dev.off()