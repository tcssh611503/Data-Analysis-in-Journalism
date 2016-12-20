#read excel ---------------------------------------------------
library(readxl)
options(stringsAsFactors = F)
legis <- read_excel("2016_leg_spent.xls"
                    , sheet = 1
                    , col_names = T)


#Q3

two <- '是'
selector <- sapply(legis$是否現任, function(x){any(x %in% two)})
legis2 <- legis[selector,]
win <- '*'
selector2 <- sapply(legis2$當選註記, function(x){any(x %in% win)})
legis2 <- legis2[selector2,]
legis2 <- legis2[-c(3, 4,5)]
legis2 <- legis2[order(legis2[,5]),]
legis2

#Q4
# Defining party.
party <- c('人民民主陣線', '大愛憲改聯盟', '中國生產黨', '中國國民黨', '中華民國機車黨','中華統一促進黨', '台灣工黨', '台灣未來黨', '台灣第一民族黨', '台灣團結聯盟','台灣獨立黨', '正黨', '民主進步黨', '民國黨', '自由台灣黨','和平鴿聯盟黨', '泛盟黨', '社會福利黨', '信心希望聯盟', '軍公教聯盟黨', '時代力量', '健保免費連線', '勞工黨','無黨團結聯盟', '新黨', '綠黨社會民主黨聯盟', '樹黨', '親民黨')
selector3 <- sapply(legis$推薦政黨, function(x){any(x %in% party)})
legis3 <- legis[selector3,]
tapply(legis3$得票數, legis3$推薦政黨, sum)


#Q5
area.sum <- tapply(legis$得票數, list(legis$地區, legis$推薦政黨), sum)

area.sum2 <- tapply(legis$得票率, list(legis$地區, legis$推薦政黨), sum)
View(area.sum2)                



#Q6
load("ElectionNews_student.RData")
all.ElectionNews<- unique(unlist(strsplit(ElectNews$Person, '／')))
all.candidate <- legis$姓名
setdiff(all.ElectionNews,all.electioncandidate )



not.candidate <- data.frame(setdiff(all.ElectionNews,all.electioncandidate ))


