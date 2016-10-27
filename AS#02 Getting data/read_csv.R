# loading your packages ----
install.packages("readxl")
library(readxl)  

# (Option) Changing your working directory temporary
# setwd('R105/')


################################################
# Reading data ----
# Assigning a character string as a path Ë∑ØÂ?ë‰?çÂ?Ä
path_82 <- file.path("82-4.xlsx")
df <- read_excel(path_82, sheet = 1)
cookdata2 <- read_excel(path_82, "82", col_names = TRUE)
View(df)
head(df)
tail(df)


