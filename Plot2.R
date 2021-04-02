file_inp<-read.csv2(file="household_power_consumption.txt",sep=";", header = TRUE)
start_pt<-"1/2/2007"
fin_pt<-"2/2/2007"
req_set1<-file_inp[file_inp$Date==start_pt,]
req_set2<-file_inp[file_inp$Date==fin_pt,]
req_set<-rbind(req_set1,req_set2)
req_set$Global_active_power<-as.numeric(req_set$Global_active_power)
req_set$Date<-as.Date(req_set$Date, format ="%d/%m/%Y")
png(file="Plot2.png", width = 480, height = 480)
plot(req_set$Global_active_power~dt, type="l", xlab="", ylab="Global Active Power")
dev.off()