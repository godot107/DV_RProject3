require("jsonlite")
library("RCurl")
require(dplyr)
require("ggplot2")
library(extrafont)


FULLGDP <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from FULLGDP"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_lar2478', PASS='orcl_lar2478',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

head(FULLGDP)

LIT <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from LIT"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_lar2478', PASS='orcl_lar2478',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

head(LIT)

#Combine join by country 
left<- left_join(LIT, FULLGDP, by = "COUNTRY") 

head(left) 

left%>% select(COUNTRY,REGION, LITERACY, GDP) %>% ggplot(aes(x=LITERACY, y=GDP, color=REGION)) + geom_point() + ggtitle('Literacy vs. GDP') + theme(legend.title=element_text(colour="chocolate",size=16,face="bold")) + ylim(c(0,10000)) 
 