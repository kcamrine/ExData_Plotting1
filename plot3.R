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
png("plot3.png",480,480,bg="transparent")
with(household_power_consumption, { 
  plot(Sub_metering_1,type="l",ylab="Energy sub metering",
       xaxt = "n",xlab = "")
  lines(Sub_metering_2,col="red")
  lines(Sub_metering_3,col="blue")
  axis(side=1,at=c(1,which(Date %in% names(table(Date))[2])[1],length(Date)),
       labels=c("Thu","Fri","Sat"))
  legend("topright",colnames(household_power_consumption)[7:9],col=c("black","red","blue"),
       lty=1)
})
dev.off()