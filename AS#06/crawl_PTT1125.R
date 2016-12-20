library(xml2)
#批踢踢文章只會保存3個月

pre <- 'https://www.ptt.cc'
q <- "Boy-Girl"
#i <- 3210
url <- paste0('https://www.ptt.cc/bbs/', q, '/index',i,'.html')

allhref <- c()

for(i in c(3209:3210)){
  pageurl <- paste0('https://www.ptt.cc/bbs/', q, '/index',i,'.html')
  doc   <- read_html(pageurl)
  href <- xml_attr(xml_find_all(doc,'//*[@id="main-container"]/div[2]//div/div[3]/a'),"href")
  href <- paste0(pre, href)
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

alldata
write.csv(alldata, "ptt.csv", row.names=F, fileEncoding = "BIG5")
save(tempdf, file="test.RData")   

