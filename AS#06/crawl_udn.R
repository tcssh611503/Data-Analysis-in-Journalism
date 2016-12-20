library(xml2)
#批踢踢文章只會保存3個月


url <- 'http://udndata.com/ndapp/Searchdec2007?page=1&udndbid=udnfree&SearchString=%B0%73%BE%72%2B%A4%E9%B4%C1%3E%3D20061222%2B%A4%E9%B4%C1%3C%3D20161209%2B%B3%F8%A7%4F%3D%C1%70%A6%58%B3%F8%7C%B8%67%C0%D9%A4%E9%B3%F8%7C%C1%70%A6%58%B1%DF%B3%F8%7CUpaper&sharepage=10&select=1&kind=2&showUserSearch=+%3Cstrong%3E%3Cfont+color%3D%23333333+class%3Dtitle03%3E%B1%7A%A5%48%3C%2Ffont%3E+%3Cfont+color%3D%23FF6600+class%3Dtitle04%3E%B0%73%BE%72%2B%A4%E9%B4%C1%3E%3D20061222%2B%A4%E9%B4%C1%3C%3D20161209%2B%B3%F8%A7%4F%3D%C1%70%A6%58%B3%F8%7C%B8%67%C0%D9%A4%E9%B3%F8%7C%C1%70%A6%58%B1%DF%B3%F8%7CUpaper%3C%2Ffont%3E+%3Cfont+color%3D%23333333+class%3Dtitle03%3E%A6%40%B7%6A%B4%4D%A8%EC%3C%2Ffont%3E+%3Cfont+color%3D%23FF6600+class%3Dtitle04%3E7795%3C%2Ffont%3E+%3Cfont+color%3D%23333333+class%3Dtitle03%3E%B5%A7%B8%EA%AE%C6%3C%2Ffont%3E%3C%2Fstrong%3E'

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

