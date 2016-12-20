library(rjson)
#install.packages('RCurl')
library(RCurl)
#install.packages('plyr')
library(plyr)
options(fileEncoding = 'utf-8')
options(stringsAsFactors = F)

url <- 'https://www.googleapis.com/customsearch/v1element?key=AIzaSyCVAXiUzRYsML1Pv6RwSG1gunmMikTzQqY&rsz=1&num=20&hl=zh_TW&prettyPrint=false&source=gcsc&gss=.com&sig=0c3990ce7a056ed50667fe0c3873c9b6&cx=013510920051559618976:klsxyhsnf7g&q=%E9%85%92%E9%A7%95&lr=&filter=1&sort=&googlehost=www.google.com&callback=google.search.Search.apiary7677&nocache=1481218832065'
# num=文章顯示的數量

text <- content(GET(url), 'text')
text <- substr(text, 49, nchar(text)-1)

data <- fromJSON(text)
test <- data['results']

test <- test$results

alldata<-data.frame(  
  title=character(0),
  content=character(0),
  time=character(0)
)



for (i in c(1:20)){
  title <- test[[i]]$richSnippet$metatags$twitterTitle
  content <- test[[i]]$contentNoFormatting
  time <- test[[i]]$richSnippet$metatags$lastmod
  tempdf <- data.frame(title=title, content=content, time=time) 
  alldata <- rbind(alldata,tempdf)
}

save(tempdf, file="ct.RData") 

  