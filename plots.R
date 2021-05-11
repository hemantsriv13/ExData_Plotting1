library(ggplot2)
plot1<-function()
{
  NEI<-readRDS("summarySCC_PM25.rds")
  agg<-aggregate(Emissions~year, NEI, sum)
  png(file="Plot1.png")
  with(agg, plot(year, Emissions, main="Total PM25 emissions by year", pch=20, cex=2.5, col="blue"))
  dev.off()
}
plot2<-function()
{
  NEI<-readRDS("summarySCC_PM25.rds")
  balt<-subset(NEI, fips=="24510")
  b<-aggregate(Emissions~year, balt, sum)
  png(file="Plot2.png")
  with(b, barplot(Emissions, names.arg=year, main="Total Emissions in Baltimore", ylab="SCC PM25", xlab="Year", col=year))
  dev.off()
}
plot3<-function()
{
  NEI<-readRDS("summarySCC_PM25.rds")
  balt<-subset(NEI, fips=="24510")
  png(file="Plot3.png")
  g<-ggplot(balt, aes(year, Emissions, fill=type))+geom_point(aes(color=type))+facet_grid(.~type)+coord_flip()+ylim(0, 400)
  plot(g)
  dev.off()
}
plot4<-function()
{
  NEI<-readRDS("summarySCC_PM25.rds")
  SCC<-readRDS("Source_Classification_Code.rds")
  mergedArr<-merge(NEI, SCC, by="SCC")
  coal_scc<-grepl("coal", mergedArr$Short.Name, ignore.case = TRUE)
  mer<-mergedArr[coal_scc,]
  ag<-aggregate(Emissions~year, mer, sum)
  png(file="Plot4.png")
  g<-ggplot(ag, aes(factor(year), Emissions, fill=year))+geom_bar(stat = "identity")+ylim(0,700000)+facet_grid()+xlab("Year")+labs(title='Coal Emissions')+labs(y="PM25 Emissions from Coal")
  plot(g)
  dev.off()
}
plot5<-function()
{
  NEI<-readRDS("summarySCC_PM25.rds")
  motor<-subset(NEI, fips=="24510")
  motor<-subset(motor, type=="ON-ROAD")
  agg<-aggregate(Emissions~year, motor, sum)
  png(file="Plot5.png")
  g<-ggplot(agg, aes(year, Emissions))+geom_point()+geom_smooth()+labs(x="Year")+labs(y="PM25 Emissions")+labs(title="PM25 Emissions from Motor Vehicles")
  plot(g)
  dev.off()
}
plot6<-function()
{
  NEI<-readRDS("summarySCC_PM25.rds")
  city<-NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",]
  png(file="Plot6.png", width = 1000, height=1000)
  g<-ggplot(city, aes(factor(year), Emissions))+geom_bar(stat="identity")+facet_grid(.~fips)+labs(title="PM25 Emissions from Mostor Vehicle comparison between LA (06037) and Baltimore (24510)")+labs(x="Year")
  plot(g)
  dev.off()
}
