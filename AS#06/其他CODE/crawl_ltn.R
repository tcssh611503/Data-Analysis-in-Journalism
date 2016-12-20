library(xml2)
url <- 'http://news.ltn.com.tw/search?keyword=食安&conditions=and&SYear=2016&SMonth=9&SDay=4&EYear=2016&EMonth=11&EDay=4'

doc   <- read_html(url)
href <- xml_attr(xml_find_all(doc,'//*[@id="newslistul"]//li/a'),"href")
hrefs <- paste0('http://news.ltn.com.tw', href)

tdoc <- read_html(hrefs[2]) 
title <- trimws(xml_text(xml_find_first(tdoc, '//*[@id="main"]//h1')))
content <- trimws(xml_text(xml_find_all(tdoc, '//*[@id="newstext"]//p')))
content
content <- paste(content, collapse = " ")
content
journalist <-  sub(".*記者(.+)[／攝].*", "\\1", content)
tempdf <- data.frame(title=title, content=content, journalist=journalist)

write.csv(tempdf, "text.csv", row.names=F, fileEncoding = "UTF-8")
save(tempdf, file="test.RData")


lastpage.path <- '//*[@id="page"]/a[@class="p_last"]'
lastpage.url <- xml_attr(xml_find_first(doc, lastpage.path), "href")
lastpage.url
lastpage.num <-
  as.numeric(sub(".*page=([0-9]+).*", "\\1", lastpage.url))
lastpage.num

