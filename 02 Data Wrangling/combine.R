require("jsonlite")
library("RCurl")
require(dplyr)
require("ggplot2")
library(extrafont)


FULLGDP <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from FULLGDP"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_lar2478', PASS='orcl_lar2478',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))
LIT <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from LIT"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_lar2478', PASS='orcl_lar2478',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))
left<- left_join(LIT, FULLGDP, by = "COUNTRY")

left%>% select(COUNTRY,REGION, LITERACY, GDP) %>% ggplot(aes(x=LITERACY, y=GDP, color=REGION)) + geom_jitter(alpha=1,aes(color=REGION),position=position_jitter(width=.3)) + ggtitle('Literacy vs. GDP') + theme(plot.title = element_text(size=20, face = "bold" , vjust=2)) + theme(legend.title=element_text(colour="chocolate",size=16,face="bold")) + theme(axis.text.x=element_text(angle=50, size=20, vjust=0.5)) + ylim(c(0,10000)) 
