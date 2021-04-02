file_inp<-read.csv2(file="household_power_consumption.txt",sep=";", header = TRUE)      #reading file from local machine
start_pt<-"1/2/2007"                                                                    #starting date to read from
fin_pt<-"2/2/2007"                                                                      #ending date to read to
req_set1<-file_inp[file_inp$Date==start_pt,]                                            #extracting 1st of Feb, 2007
req_set2<-file_inp[file_inp$Date==fin_pt,]                                              #extracting 2nd of Feb, 2007
req_set<-rbind(req_set1,req_set2)                                                       #row binding them both
req_set$Global_active_power<-as.numeric(req_set$Global_active_power)                    #type conversion to numeric
req_set$Date<-as.Date(req_set$Date, format ="%d/%m/%Y")                                 #changing dates to Date class
dt<-as.POSIXct(paste(req_set$Date, req_set$Time))                                       #creating the DateTime variable represented as dt
png(file="Plot2.png", width = 480, height = 480)                                        #creating png using file device
plot(req_set$Global_active_power~dt, type="l", xlab="", ylab="Global Active Power")     #plotting the graph
dev.off()                                                                               #closing graphic device
