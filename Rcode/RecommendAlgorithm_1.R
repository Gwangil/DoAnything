####### Algorithm 1

## ID == 1 case, BuyShoppings
# Extract <- sqldf("select BuyShoppings.*, Categories.PD_S_NM, Categories.PD_M_NM, Categories.PD_H_NM, Categories.Division
#       from BuyShoppings
#       inner join Categories on BuyShoppings.BIZ_UNIT = Categories.BIZ_UNIT
#         and BuyShoppings.PD_S_C = Categories.PD_S_C
#       where ID=1")
Extract <- merge(BuyShoppings %>% filter(ID==1),Categories ,by=c("BIZ_UNIT","PD_S_C"))

## Merge BuyShoppings and BuyOthers for ID == 1 case
BuySO <- BuyOthers %>% filter(ID==1) %>% bind_rows(Extract) %>% arrange(BIZ_UNIT) %>% select(-Division)

## Main Trading Point 1,2
Main2 <- BuySO %>% select(BIZ_UNIT) %>% table() %>% sort(decreasing = T) %>% head(2) %>% names()

## Top3 Purchasied Item in Division A (no items in BuyOthers)
Top3 <- Extract %>% select(PD_S_NM) %>% table() %>% sort(decreasing = T) %>% head(3) %>% names()
Top3Code <- Extract %>% filter(PD_S_NM %in% Top3) %>% select(BIZ_UNIT,PD_S_C) %>% unique()

## Get Receipt Number including Top3
RctNoTop3 <- BuyShoppings %>% filter(BIZ_UNIT %in% Top3Code$BIZ_UNIT, PD_S_C %in% Top3Code$PD_S_C) %>% select(RCT_NO) %>% unique()

## Items other people bought when they bought the same thing ID==1's top3 items
ExtractOtherPeople <- BuyShoppings %>% filter(RCT_NO %in% RctNoTop3$RCT_NO ) %>% merge(Categories, by=c("BIZ_UNIT", "PD_S_C"))

## Recommendation
Top3OtherPeople <- ExtractOtherPeople %>% select(PD_S_NM) %>% filter(!PD_S_NM %in% Top3) %>% table() %>% sort(decreasing = T) %>% head(3) %>% names()
Top3CodeOtherPeople <-  ExtractOtherPeople %>% filter(PD_S_NM %in% Top3OtherPeople) %>% select(BIZ_UNIT,PD_S_C) %>% unique()
# Categories %>% filter(PD_S_NM %in% Top3OtherPeople)