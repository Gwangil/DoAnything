dataDir <- "D:/각종참여활동/공모전/제4회 Big Data Competition/제4회 Big Data Competition-스마트라이프큐레이터"
dataList <- list.files(dataDir)

library(data.table)
library(dplyr)
library(stringr)
library(chron)

############  Variable Type ##########################################

Customers <- fread(paste(dataDir,dataList[2],sep="/"))
BuyShoppings <- fread(paste(dataDir,dataList[3],sep="/"))
BuyOthers <- fread(paste(dataDir,dataList[4],sep="/"))
Categories <- fread(paste(dataDir,dataList[5],sep="/"),encoding="UTF-8")

str(Customers)
Customers$ID <- factor(Customers$ID)
Customers$GENDER <- factor(Customers$GENDER, labels=c("M","F"))
Customers$AGE_PRD <- factor(Customers$AGE_PRD)
Customers$HOM_PST_NO[!is.na(Customers$HOM_PST_NO)] <- sprintf("%03d", Customers$HOM_PST_NO[!is.na(Customers$HOM_PST_NO)])
Customers$HOM_PST_NO <- factor(Customers$HOM_PST_NO)

str(Categories)
Categories$BIZ_UNIT <- factor(Categories$BIZ_UNIT)
Categories$PD_S_C <- as.character(Categories$PD_S_C)
Categories$PD_M_NM <- factor(Categories$PD_M_NM)
Categories$PD_H_NM <- factor(Categories$PD_H_NM)
Categories$Division <- factor(str_sub(Categories$BIZ_UNIT,1,1))

str(BuyOthers)
BuyOthers$ID <- factor(BuyOthers$ID)
BuyOthers$BIZ_UNIT <- factor(BuyOthers$BIZ_UNIT)
BuyOthers$CRYM <- as.Date(paste0(BuyOthers$CRYM,01),"%Y%m%d")		#YYYY/MM 형식의 DATE데이터를 취급하기 위해 임의로 01(DD) 추가
BuyOthers$Division <- factor(str_sub(BuyOthers$BIZ_UNIT,1,1))
colnames(BuyOthers)[3:5] <- c("DE_DT", "BUY_AM", "BUY_CT")


str(BuyShoppings)
BuyShoppings$ID <- factor(BuyShoppings$ID)
BuyShoppings$RCT_NO <- factor(BuyShoppings$RCT_NO)
BuyShoppings$BIZ_UNIT <- factor(BuyShoppings$BIZ_UNIT)
BuyShoppings$PD_S_C <- as.character(BuyShoppings$PD_S_C)
BuyShoppings$BR_C <- factor(BuyShoppings$BR_C)
BuyShoppings$DE_DT <- as.Date(as.character(BuyShoppings$DE_DT),"%Y%m%d")
BuyShoppings$DE_HR <- times(BuyShoppings$DE_HR)

##############  Univariate - Customers  ###################################

table(Customers$GENDER)
table(Customers$GENDER)/20000       # M:F 4:6

table(Customers$AGE_PRD)
table(Customers$AGE_PRD)/20000      # 20~60's about 1:2:2:2:1

plot(Customers$AGE_PRD)
plot(Customers$HOM_PST_NO)

aggregate(GENDER~AGE_PRD,data=Customers,summary)
plot(GENDER~AGE_PRD,data=Customers)