dataDir <- "D:/각종참여활동/공모전/제4회 Big Data Competition/제4회 Big Data Competition-스마트라이프큐레이터"
dataList <- list.files(dataDir)
library(data.table)
library(dplyr)
Coustomers <- fread(paste(dataDir,dataList[2],sep="/"))
BuyShoppings <- fread(paste(dataDir,dataList[3],sep="/"))
BuyOthers <- fread(paste(dataDir,dataList[4],sep="/"))
Category <- fread(paste(dataDir,dataList[5],sep="/"),encoding="UTF-8")
