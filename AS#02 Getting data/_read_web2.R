#���������s��data.frame
################################
install.packages("xmlview")
# read by xml2 ----
library(xml2)
library(rvest) # must require xml2
#library(xmlview)

#Ū�Ҥ~�ݭn ctrl+shift+c ���ѱ�
# setwd('..105-1\�s�D��Ƥ��R\�@�~\AS##02 Getting data')
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
#��t�@��r�ҥ�������@��
source("html_table_fixed.r")
url <- "http://www.lis.ntu.edu.tw/?page_id=148"
#Ū�ɮת�xml
doc <- read_html(url, encoding = "UTF-8"); class(doc)
tables <- html_nodes(doc, "table"); class(tables)
#���w����W��
tables <- html_nodes(doc, "table"); class(tables)
#����������ĴX�Ӫ���
table1 <- html_table(tables[1], fill = TRUE); class(table1)

# method 1: convert to dataframe
#�s��data.frame
table_df <- data.frame(table1)
View(table_df)
View(table_df(C[2:4,])


names(table_df) <- c('cname', 'bank', 'ibuyin', 'ibuyout', 'cbuyin', 'cbuyout')
rownames(table_df) <- table_df[,1]
#�R��
table_df <- table_df[-1,-1]
#���N���ŭȬ�NA��
table_df[table_df=='-']<-NA # �?'-'??��?�為NA
#matleave[is.na(matleave)] <- 0 =�W�ӨҤl

summary(table_df)
class(table_df$cbuyin)
#�ন�Ʀr
is.numeric(table_df$cbuyin)
tdf1$cbuyin <- as.numeric(table_df$cbuyin)
tdf1$cbuyout <- as.numeric(table_df$cbuyout)
summary(table_df)

# table_df[complete.cases(table_df),] # ??�出?��些�?�整??��??
#�R���Ŧ�
#table_df <- na.omit(table_df[c(1, 4, 5)]) # ??�出4, 5??��?��?�去?��不�?�整??��??
table_df <- table_df[c(1, 4, 5)]
table_df <- na.omit(table_df)

table_df <- table_df[table_df$cbuyin < table_df$cbuyout,]


# ??�出subset
#�Ǧ^true���@��
subset(tdf1, subset = cbuyin < cbuyout)
