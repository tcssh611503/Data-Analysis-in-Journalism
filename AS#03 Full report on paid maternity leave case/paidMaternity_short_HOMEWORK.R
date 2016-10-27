# loading your packages ----
#載入讀取xls所需要的套件readxl
library(readxl)
library(rworldmap)
###########################################################
#繪圖一 1995年
#create a map-shaped window
mapDevice()
#建立存取檔案的路徑path2
#path2 <- file.path("WORLD-MACHE_Gender_6.8.15.xls")

#方法1:讀取path2所指到的檔案的第一個試算表，並設定第一列為表格標題。
#ldata <- read_excel(path2, sheet = 1, col_names = T)
#方法2:直接讀取所指到的檔案的第一個試算表，並設定第一列為表格標題。
sdata <- read_excel("WORLD-MACHE_Gender_6.8.15.xls", "Sheet1", col_names=T)

# Mapping your data to map's data by ISO3 standard
myPDF95 <- joinCountryData2Map(sdata
                             , joinCode = "ISO3"
                             , nameJoinColumn = "iso3"
)

# Drawing the map according to some column
mapParams95 <- mapCountryData(myPDF95
                            , nameColumnToPlot="matleave_95"
                            , catMethod = "categorical"
                            , colourPalette = c("#FF8000", "#A9D0F5", "#58ACFA", "#0080FF", "#084B8A")
                            , addLegend='FALSE'
)

###########################################################
#繪圖二 2004年

myPDF04 <- joinCountryData2Map(sdata
                               , joinCode = "ISO3"
                               , nameJoinColumn = "iso3"
)

# Drawing the map according to some column
mapParams04 <- mapCountryData(myPDF04
                              , nameColumnToPlot="matleave_04"
                              , catMethod = "categorical"
                              , colourPalette = c("#FF8000", "#A9D0F5", "#58ACFA", "#0080FF", "#084B8A")
                              , addLegend='FALSE'
)

###########################################################
#繪圖二 2013年

myPDF13 <- joinCountryData2Map(sdata
                               , joinCode = "ISO3"
                               , nameJoinColumn = "iso3"
)

# Drawing the map according to some column
mapParams13 <- mapCountryData(myPDF13
                              , nameColumnToPlot="matleave_13"
                              , catMethod = "categorical"
                              , colourPalette = c("#FF8000", "#A9D0F5", "#58ACFA", "#0080FF", "#084B8A")
                              , addLegend='FALSE'
)


###########################################################
## barplot of each country's data ----

# Read the first sheet, and the first row as column name.
ldata <- read_excel("WORLD-MACHE_Gender_6.8.15.xls"
                    , sheet = 1
                    , col_names = T)

# Assign the 3rd, 6 to 24 columns to a new variable matleave//刪除不會用到得欄位
matleave <- ldata[c(3, 6:24)] # selecting columns
names(matleave)

# Assigning 0 to NA cells 指派NA值
matleave[is.na(matleave)] <- 0



m5 <- matleave[matleave$'matleave_13'==5,]
staySame <- apply(m5[,2:20], 1, function(x) length(unique(x[!is.na(x)]))) == 1
m55 <- m5[staySame, ]
m50 <- m5[!staySame, ]




m5 <- matleave[matleave$'matleave_13'==5,]
m55<- m5[m5$'matleave_95'==5,]
m50<- m5[m5$'matleave_95'<5,]
rownames(m50) <- m50[,1]
m50 <- m50[,-1]

par(mfrow=c(5,4), mai= c(0.2, 0.1, 0.1, 0.1))
for (x in c(1:nrow(m50))){
  barplot(unlist(m50[x, ]), border=NA, space=0,xaxt='n', yaxt='n')
  title(rownames(m50)[x], line = -4, cex.main=3)
}


rownames(m55) <- m55[,1]
m55 <- m55[,-1]
par(mfrow=c(5,5), mai= c(0.2, 0.1, 0.1, 0.1))
for (x in c(1:nrow(m55))){
  barplot(unlist(m55[x, ]), border=NA, space=0,xaxt='n', yaxt='n')
  title(rownames(m55)[x], line = -4, cex.main=3)
}


# Selecting rows with the '2013' column == 5
m5 <- matleave[matleave$'matleave_13'==2,]
staySame <- apply(m5[,2:20], 1, function(x) length(unique(x[!is.na(x)]))) == 1
m55 <- m5[staySame, ]
m50 <- m5[!staySame, ]

# Selecting rows with '1995' column is 5
m55<- m5[m5$'matleave_95'==4,]

# Selecting rows with '1995' column < 5
m50<- m5[m5$'matleave_95'!=4,]

# Assigning the 1st column as row names
rownames(m50) <- m50[,1]

# Deleting the 1st column
m50 <- m50[,-1]

# plotting consequent figure in 5*4 grids (5 rows 4 columns)
# mai parameters are used to control the space between each figure.
par(mfrow=c(5, 4), mai= c(0.2, 0.1, 0.1, 0.1))

for (x in c(1:nrow(m50))){
  barplot(unlist(m50[x, ]), border=NA, space=0,xaxt='n', yaxt='n', ylim = range(1:5))
  title(rownames(m50)[x], line = -4, cex.main=3)
}

rownames(m55) <- m55[,1]
m55 <- m55[,-1]
par(mfrow=c(5,5), mai= c(0.2, 0.1, 0.1, 0.1))
for (x in c(1:nrow(m55))){
  barplot(unlist(m55[x, ]), border=NA, space=0,xaxt='n', yaxt='n', ylim = range(0:5))
  title(rownames(m55)[x], line = -4, cex.main=3)
}


######################################################################

#3繪圖三



# pivot table by tapply ----
ldata <- read_excel("WORLD-MACHE_Gender_6.8.15.xls"
                    , sheet = 1
                    , col_names = T)

matleave <- ldata[c(3, 4, 6:24)]
matleave[is.na(matleave)] <- 0
ldata <- ldata[,c(1:24)]

#各州的國家筆數
#tapply(ldata$matleave_13, ldata$region, length)
#各州的國家育嬰假平均
#tapply(ldata$matleave_13, ldata$region, mean)
#各州的國家總數
#tapply(ldata$matleave_13, ldata$region, sum)
#各州的國家筆數
#tapply(ldata$matleave_13, ldata$region, sd)


res <- data.frame(num)
average <- tapply(ldata$matleave_13, ldata$region, mean)
# bind by columns, biding two data frames
byregion <- aggregate(matleave[,3:21],by=list(matleave$region), mean)
byregion

#繪圖
par(mfrow=c(3,2), mai= c(0.2, 0.1, 0.1, 0.1))

for (x in c(1:6)){
  plot(unlist(byregion[x,]), type="o")
  axis(1, at=2:20,labels=as.character(1995:2013), col.axis="red", las=2)
  title(byregion$Group.1[x], line = -2, cex.main=2)
}

