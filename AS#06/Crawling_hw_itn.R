######## Crawling Chap.1 爬新聞網址，以民視新聞網站為例。 ##########

# HTML:主要是用來撰寫網頁用的語言，語言(標籤)都是全球統一的，您無法自定標籤，只能變
# 更其標籤屬性。
  
# XML:最主要的功能是用來「資料傳遞」，例如A網站可將要分享出來的資料(如最新訊息或產
# 品資訊…等)，轉成XML格式讓B網站可以直接讀取及引用，因此使用者可自行定義標籤(tags)
# 名稱及結構，以利引用者辦識結構及資料內容。

# 讀取網頁：html或是xml
# 常用function: read_html(), read_xml()
#-------------------起始設定----------------------------
library(xml2)
pre <- 'http://news.ltn.com.tw'

#設定關鍵字
q <- "酒駕"
i <- 1
url <- paste0('http://news.ltn.com.tw/search?page=', i, '&keyword=', q, '&conditions=and&SYear=2016&SMonth=9&SDay=2&EYear=2016&EMonth=10&EDay=1')

#把首頁讀進文本doc
doc <- read_html(url)

#設定最末頁
lastpage.path <- '//*[@id="page"]/a[@class="p_last"]' #最末頁的xpath
lastpage.url <- xml_attr(xml_find_first(doc, lastpage.path), "href") #找到對應xpath的網址
lastpage.num <- as.numeric(sub(".*page=([0-9]+).*", "\\1", lastpage.url)) #取得最末頁的頁數

#-------------------取得所有網址連結----------------------------
allhref <- c() #set a var "allhref" to save all the article links

for(i in c(1:lastpage.num)){
  pageurl <- paste0('http://news.ltn.com.tw/search?page=', i, '&keyword=', q, '&conditions=and&SYear=2016&SMonth=9&SDay=2&EYear=2016&EMonth=10&EDay=1')
  doc <- read_html(pageurl)
  href <- xml_attr(xml_find_all(doc, '//*[@id="newslistul"]//li/a'), "href")
  href <- paste0(pre,href)
  allhref <- c(allhref,href)
  }
allhref

#---Notes for Chap.1
# 爬網址流程：了解搜尋引擎的網址規則 -> 設定keyword & lastpage -> 寫for-loop讀取網址
# 利用xml_find_all()讀取目標xpath，並從中抓取href的value（也就是網址）
# 清理資料常用function：sub() , paste0()


######## Crawling Chap.2 爬新聞文章，以民視新聞網站為例。 ##########
# 承Chap.1，現在已存入所有新聞文章的網址（allhref）

textdf <- data.frame(
            cat = character(0),
            id = character(0),
            title = character(0),
            content = character(0),
            journalist = character(0))

for (i in c(1:length(allhref))){
  texturl <- allhref[i]
  doc <- read_html(texturl)
  title <- trimws(xml_text(xml_find_first(doc, '//*[@id="main"]//h1')))
  content <- trimws(xml_text(xml_find_all(doc, '//*[@id="newstext"]//p')))
  content
  content <- paste(content, collapse = " ")
  journalist <- sub(".*記者(.+)／.*", "\\1", content) #為何？
  tempdf <- data.frame(title=title, content=content, journalist=journalist)
  textdf <- rbind(textdf, tempdf)
}

save(textdf, file="Itn_news.RData")

######## Crawling Chap.？ Saving data ##########
