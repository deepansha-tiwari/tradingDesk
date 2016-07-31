#Trading Desk problem
#Deepansha Tiwari


#installing the required packages
install.packages("plyr")
library(plyr)

#set the working directory
setwd('~/Documents/Trading Desk')

#import data from given files
cab<-read.csv("CapitalAccountBalances.csv", header = TRUE)
tab<-read.csv("TradingAccountBalances.csv", header = TRUE)
dtt<-read.csv("DeskToTradingMap.csv", header = TRUE)
ctt<-read.csv("CapitalToTradingMap.csv", header = TRUE)

#mapping two tables using TradingAcoountId
map1<-merge(dtt, tab, by= "TradingAccountId")

#calculating the total trading account balance
total_t<-ddply(map1, .(Desk), summarise, TradingAccountBalance=sum(TradingAccountBalance))

#mapping multiple tables using CapitalAccountId and CapitalAccountId
map2<-merge(ctt,cab, by ="CapitalAccountId")
map3<-merge(dtt,map2, by ="CapitalAccountId")

#calculating the total capital account balance
total_c<-ddply(map3, .(Desk), summarise, CapitalAccountBalance=sum(CapitalAccountBalance))

#merging the total trading account balance and capital account balance according to the desk
do<-merge(total_t,total_c, by ="Desk")

#creating the final output file
write.csv(do, file = "DesiredOutput.csv")





