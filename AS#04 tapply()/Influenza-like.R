## Influenza-like
library(httr)
csv_url <- 'http://nidss.cdc.gov.tw/Download/RODS_Influenza_like_illness.csv'
GET(csv_url, write_disk("test.csv", overwrite=TRUE))
data <- read.csv("test.csv", sep=',', fileEncoding = 'big5')

#向量元素命名 Assigning column names
#names(data)[1] <- "year"
#names(data)[2] <- "week"
#names(data)[3] <- "age"
#names(data)[4] <- "City"
#names(data)[5] <- "people"
names(data) <-  c("year","week","age","city","people")

# xxxAssign Median age
#data[data=='0-6']<-3
#data[data=='7-12'] <- 9
#data[data=='13-18'] <- 15
#data[data=='65+'] <- 65

#city's people
tapply(data$people, data$city, sum)
tapply(data$people, data$age, sum)
tapply(data$people, data$year, sum)

#######################################################

rm(list=ls())

library(httr)
library(jsonlite)
#example
url <- 'http://data.taipei/youbike'
GET(url, write_disk("youbikeTP", overwrite=TRUE))
ubike.data <- fromJSON("YoubikeTP")
ubike.char <- unlist(ubike.data[2])
ubike.m <- matrix(ubike.char, byrow = T, ncol = 14)
ubike.df <- data.frame(ubike.m, stringsAsFactors = F)
ubike.df <- ubike.df[,2:9]
colnames(ubike.df) <- c("sna","tot", "sbi", "sarea","mday","lat","lng", "loc")
ubike.df <- ubike.df[-nrow(ubike.df),]# delete the last row
# tail(ubike.df)


ubike.data <- fromJSON("data")
ubike.data$result$records
ubike.df <- data.frame(ubike.data$result$records)

rm(list=ls())

library(httr)
library(jsonlite)
url <- 'http://m.coa.gov.tw/OpenData/FarmTransData.aspx'
GET(url, write_disk("youbikeTP", overwrite=TRUE))
ubike.data <- fromJSON("YoubikeTP")
ubike.char <- unlist(ubike.data[2])
ubike.m <- matrix(ubike.char, byrow = T, ncol = 14)
ubike.df <- data.frame(ubike.m, stringsAsFactors = F)
ubike.df <- ubike.df[,2:9]
colnames(ubike.df) <- c("sna","tot", "sbi", "sarea","mday","lat","lng", "loc")
ubike.df <- ubike.df[-nrow(ubike.df),]# delete the last row
# tail(ubike.df)

rm(list=ls())
library(httr)
library(jsonlite)

url <- 'https://data.lacity.org/api/views/s9rj-h3s6/rows.json?accessType=DOWNLOAD'
GET(url, write_disk("food", overwrite=TRUE)) # youbikeTP為一個gzip檔
food_data <- fromJSON("food") # fromJSON()可以直接開啟gzip擋
food_df <- data.frame(food_data)

names(food_df) <-  c("city","time","num","unit")
food_df$num <- as.numeric( as.character( food_df$num ) )
food_df[food_df=='']<-NA

tapply(food_df$num, food_df$city, mean)



warnings()


food_m <- matrix(food_data, byrow = T, ncol = 5)


tapply(food_df$value, food_df$year, sum)












food.df <- data.frame(food_data) 






tapply(data$people, data$age, sum)
tapply(data$people, data$year, sum)
