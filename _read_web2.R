#§ìºô¸ôªí®æ¦s¦¨data.frame
################################
install.packages("xmlview")
# read by xml2 ----
library(xml2)
library(rvest) # must require xml2
#library(xmlview)

#ÅªÄÒ¤~»Ý­n ctrl+shift+c µù¸Ñ±¼
# setwd('..105-1\·s»D¸ê®Æ¤ÀªR\§@·~\AS##02 Getting data')
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
#§â¥t¤@­ÓrÄÒ¥þ³¡°õ¦æ¤@¦¸
source("html_table_fixed.r")
url <- "http://www.lis.ntu.edu.tw/?page_id=148"
#ÅªÀÉ®×ªºxml
doc <- read_html(url, encoding = "UTF-8"); class(doc)
tables <- html_nodes(doc, "table"); class(tables)
#«ü©wªí®æ¦WºÙ
tables <- html_nodes(doc, "table"); class(tables)
#¿ï¨úºô­¶¤¤²Ä´X­Óªí®æ
table1 <- html_table(tables[1], fill = TRUE); class(table1)

# method 1: convert to dataframe
#¦s¦¨data.frame
table_df <- data.frame(table1)
View(table_df)
View(table_df(C[2:4,])


names(table_df) <- c('cname', 'bank', 'ibuyin', 'ibuyout', 'cbuyin', 'cbuyout')
rownames(table_df) <- table_df[,1]
#§R°£
table_df <- table_df[-1,-1]
#¨ú¥N±¼ªÅ­È¬°NA­È
table_df[table_df=='-']<-NA # å°?'-'??‡å?šç‚ºNA
#matleave[is.na(matleave)] <- 0 =¤W­Ó¨Ò¤l

summary(table_df)
class(table_df$cbuyin)
#Âà¦¨¼Æ¦r
is.numeric(table_df$cbuyin)
tdf1$cbuyin <- as.numeric(table_df$cbuyin)
tdf1$cbuyout <- as.numeric(table_df$cbuyout)
summary(table_df)

# table_df[complete.cases(table_df),] # ??–å‡º?‚£äº›å?Œæ•´??„å??
#§R°£ªÅ¦æ
#table_df <- na.omit(table_df[c(1, 4, 5)]) # ??–å‡º4, 5??—ï?Œä?”åŽ»?™¤ä¸å?Œæ•´??„å??
table_df <- table_df[c(1, 4, 5)]
table_df <- na.omit(table_df)

table_df <- table_df[table_df$cbuyin < table_df$cbuyout,]


# ??–å‡ºsubset
#¶Ç¦^trueªº¤@¦æ
subset(tdf1, subset = cbuyin < cbuyout)

