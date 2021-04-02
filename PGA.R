file_inp<-read.csv2(file="household_power_consumption.txt",sep=";", header = TRUE)
start_pt<-"1/2/2007"
fin_pt<-"2/2/2007"
req_set1<-file_inp[file_inp$Date==start_pt,]
req_set2<-file_inp[file_inp$Date==fin_pt,]
req_set<-rbind(req_set1,req_set2)
req_set$Global_active_power<-as.numeric(req_set$Global_active_power)
req_set$Date<-as.Date(req_set$Date, format ="%d/%m/%Y")
print(head(req_set))
hist(as.numeric(req_set$Global_active_power),col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dt<-as.POSIXct(paste(req_set$Date, req_set$Time))
#print(head(dt))
#print(tail(dt))
plot(req_set$Global_active_power~dt, type="l", xlab="", ylab="Global Active Power")

req_set$Sub_metering_1<-as.numeric(req_set$Sub_metering_1)
req_set$Sub_metering_2<-as.numeric(req_set$Sub_metering_2)
req_set$Sub_metering_3<-as.numeric(req_set$Sub_metering_3)
with(req_set, {
  plot(req_set$Sub_metering_1~dt, type="l", ylab="Energy Sub-Metering", xlab="")
  lines(req_set$Sub_metering_2~dt, col="red")
  lines(req_set$Sub_metering_3~dt, col="blue")
})
legend("topright",pch=20, col=c("black","red","blue"), legend = c("Sub-metering-1","Sub-metering-2","Sub-metering-3"))
png(file="Plot3.png", height = 480, width = 480)
req_set$Voltage<-as.numeric(req_set$Voltage)
req_set$Global_reactive_power<-as.numeric(req_set$Global_reactive_power)

par(mfcol=c(2,2))
with(req_set,{
  plot(req_set$Global_active_power~dt, type="l", xlab="", ylab="Global Active Power")
  with(req_set, {
    plot(req_set$Sub_metering_1~dt, type="l", ylab="Energy Sub-Metering", xlab="")
    lines(req_set$Sub_metering_2~dt, col="red")
    lines(req_set$Sub_metering_3~dt, col="blue")
    })
    legend("topright",pch=20, col=c("black","red","blue"), legend = c("Sub-metering-1","Sub-metering-2","Sub-metering-3"))
    plot(req_set$Voltage~dt, type="l", ylab = "Voltage", xlab= "DateTime")
    plot(req_set$Global_reactive_power~dt, type="l", ylab = "Global_Reactive_Power", xlab="DateTime")
})
dev.off()
#C:/Users/heman/Desktop/Coursera/JHU data science/EDA/exdata_data_household_power_consumption/household_power_consumption.txt