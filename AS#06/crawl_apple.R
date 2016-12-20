#download httr
library(httr)
library(xml2)


allhref <- c()

url <- 'http://search.appledaily.com.tw/appledaily/search'
#用post 把後面的表單送出去 取得資料
res <- POST(url, body=list(searchMode='Adv',searchType='text',querystrA='酒駕',select='AND',source='',sdate='2003-05-02',edate='2016-11-04'))
req <- content(res)
#轉成xml
resString <- content(res, "text", encoding = "utf8")
res <- read_html(resString, encoding = "utf8")
href <- xml_attr(xml_find_all(res,'//*[@id="result"]/li[1]/div/h2/a'),"href")
allhref <- c(allhref, href)

alldata<-data.frame(  
  content=character(0)
)

tdoc <- read_html(href) 
content <- trimws(xml_text(xml_find_all(tdoc, '//*[@id="maincontent"]/div[2]/article/div[2]')))
tempdf <- data.frame(content=content) 
alldata <- rbind(alldata,tempdf)


for(i in c(1:10)){
url <- 'http://search.appledaily.com.tw/appledaily/search'
  #用post 把後面的表單送出去 取得資料
res <- POST(url, body=list(searchMode='Adv',searchType='text',querystrA='酒駕',select='AND',source='',sdate='2003-05-02',edate='2016-11-04'))
req <- content(res)
 #轉成xml
resString <- content(res, "text", encoding = "utf8")
res <- read_html(resString, encoding = "utf8")
href <- xml_attr(xml_find_all(res,'//*[@id="result"]/li[i]/div/h2/a'),"href")
allhref <- c(allhref, href)
}



alldata<-data.frame(  
  title=character(0),
  content=character(0),
  timestamp=character(0),
  author=character(0),
  link=character(0)
)

for (i in c(1:length(allhref))){
  tdoc <- read_html(allhref[i]) 
  author<-  trimws(xml_text(xml_find_all(tdoc, '//*[@id="main-content"]/div[1]')))
  title <- trimws(xml_text(xml_find_first(tdoc, '//*[@id="main-content"]/div[3]/span[2]')))
  content <- trimws(xml_text(xml_find_all(tdoc, '//*[@id="main-content"]')))
  timestamp <-  trimws(xml_text(xml_find_all(tdoc, '//*[@id="main-content"]/div[4]')))
  tempdf <- data.frame(author=author,title=title, content=content,timestamp=timestamp) 
  alldata <- rbind(alldata,tempdf)
}