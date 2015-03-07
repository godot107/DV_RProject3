require("jsonlite")
library("RCurl")
require(dplyr)
require("ggplot2")
library(extrafont)

#Data Frames Used:
GDP20 <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from GDP20"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

head(GDP20)

EXCHANGE20 <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from TOP20"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

head(EXCHANGE20)

#Inner Join by Country
joined <- inner_join(EXCHANGE20, GDP20, by = "COUNTRY")

head(joined)


#Visualization of Inner Join
ggplot(joined, aes(x=EXCHANGEPERDOLLAR, y = GDP, color = RANKING)) + geom_point() + scale_color_gradient(low="darkkhaki",high="darkgreen") + ggtitle('Exchange per Dollar vs. GDP')  + theme(plot.title = element_text(size=20, face = "bold" , vjust=2)) + theme(axis.text.x=element_text(angle=50, size=20, vjust=0.5)) 
