dataDir <- "D:/��������Ȱ��/������/��4ȸ Big Data Competition/��4ȸ Big Data Competition-����Ʈ������ť������"
dataList <- list.files(dataDir)
library(data.table)
library(dplyr)
Coustomers <- fread(paste(dataDir,dataList[2],sep="/"))
BuyShoppings <- fread(paste(dataDir,dataList[3],sep="/"))
BuyOthers <- fread(paste(dataDir,dataList[4],sep="/"))
Category <- fread(paste(dataDir,dataList[5],sep="/"),encoding="UTF-8")