library(xml2)
url <- 'http://news.ltn.com.tw/search?keyword=食安&conditions=and&SYear=2016&SMonth=9&SDay=4&EYear=2016&EMonth=11&EDay=4'
doc   <- read_html(url)


#檢查 copy x path : //*[@id="newslistul"]/li[1]/a
#find link
href <- xml_attr(xml_find_all(doc,'//*[@id="newslistul"]//li/a'),"href")
#plus url
hrefs <- paste0('http://news.ltn.com.tw', href)

#found <- xml_find_all(doc,'//*[@id="newslistul"]//li/a')
#found
#href <-xml_attr(found,"href")
##link

#complete link
#hrefs <- paste0('http://news.ltn.com.tw', href)
#hrefs
#other function paste() sprintf()


#Crawl news bt each link-------------------------------------------------------
#read kink

alldata<-data.frame(  
  title=character(0),
  content=character(0),
  timestamp=character(0),
  journalist=character(0),
  link=character(0)
)
alldata
for (i in c(1:length(hrefs))){
  tdoc <- read_html(hrefs[i]) 
  title <- trimws(xml_text(xml_find_first(tdoc, '//*[@id="main"]//h1')))
  content <- trimws(xml_text(xml_find_all(tdoc, '//*[@id="newstext"]//p')))
  content <- paste(content, collapse = " ")
  timestamp <-  trimws(xml_text(xml_find_all(tdoc, '//*[@id="newstext"]/span')))
  journalist <-  sub(".*記者(.+)[／攝].*", "\\1", content)
  tempdf <- data.frame(title=title, content=content, journalist=journalist) 
  alldata <- rbind(alldata,tempdf)
}

write.csv(alldata, "text.csv", row.names=F, fileEncoding = "UTF-8")
save(tempdf, file="test.RData")     



tdoc <- read_html(hrefs[i]) 
#read title
title <- trimws(xml_text(xml_find_first(tdoc, '//*[@id="main"]//h1')))
#title
#read content
content <- trimws(xml_text(xml_find_all(tdoc, '//*[@id="newstext"]//p')))
#content
#合併段落function paste() ，用空白分隔
content <- paste(content, collapse = " ")
#content

#find time //*[@id="newstext"]/span
timestamp <-  trimws(xml_text(xml_find_all(tdoc, '//*[@id="newstext"]/span')))
timestamp
#find reporter (.+) .代表加後面的東西 +代表至少有一個字 []代表or \\有找到的話就把第一個抓出
journalist <-  sub(".*記者(.+)[／攝].*", "\\1", content)
journalist
tempdf <- data.frame(title=title, content=content, journalist=journalist)




lastpage.path <- '//*[@id="page"]/a[@class="p_last"]'
lastpage.url <- xml_attr(xml_find_first(doc, lastpage.path), "href")
lastpage.url
lastpage.num <-
  as.numeric(sub(".*page=([0-9]+).*", "\\1", lastpage.url))
lastpage.num

