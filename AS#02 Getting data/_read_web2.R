#抓網路表格存成data.frame
################################
install.packages("xmlview")
# read by xml2 ----
library(xml2)
library(rvest) # must require xml2
#library(xmlview)

#讀黨才需要 ctrl+shift+c 註解掉
# setwd('..105-1\新聞資料分析\作業\AS##02 Getting data')
setwd('../')
setwd('homework')
setwd('AS#02 Getting data')
getwd()

url   <- "http://www.lis.ntu.edu.tw/?page_id=148"
doc   <- read_html(url)

# xml_view(doc, add_filter = T)



#####################################
# read table by rvest -------
#####################################
#把另一個r黨全部執行一次
source("html_table_fixed.r")
url <- "http://www.lis.ntu.edu.tw/?page_id=148"
#讀檔案的xml
doc <- read_html(url, encoding = "UTF-8"); class(doc)
tables <- html_nodes(doc, "table"); class(tables)
#指定表格名稱
tables <- html_nodes(doc, "table"); class(tables)
#選取網頁中第幾個表格
table1 <- html_table(tables[1], fill = TRUE); class(table1)

# method 1: convert to dataframe
#存成data.frame
table_df <- data.frame(table1)
View(table_df)
View(table_df(C[2:4,])


names(table_df) <- c('cname', 'bank', 'ibuyin', 'ibuyout', 'cbuyin', 'cbuyout')
rownames(table_df) <- table_df[,1]
#刪除
table_df <- table_df[-1,-1]
#取代掉空值為NA值
table_df[table_df=='-']<-NA # 撠?'-'??��?���摸A
#matleave[is.na(matleave)] <- 0 =上個例子

summary(table_df)
class(table_df$cbuyin)
#轉成數字
is.numeric(table_df$cbuyin)
tdf1$cbuyin <- as.numeric(table_df$cbuyin)
tdf1$cbuyout <- as.numeric(table_df$cbuyout)
summary(table_df)

# table_df[complete.cases(table_df),] # ??����?��鈭��?����??��??
#刪除空行
#table_df <- na.omit(table_df[c(1, 4, 5)]) # ??����4, 5??��?��?����?�支���?����??��??
table_df <- table_df[c(1, 4, 5)]
table_df <- na.omit(table_df)

table_df <- table_df[table_df$cbuyin < table_df$cbuyout,]


# ??���漳ubset
#傳回true的一行
subset(tdf1, subset = cbuyin < cbuyout)

