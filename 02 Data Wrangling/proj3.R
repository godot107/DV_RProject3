require("jsonlite")
library("RCurl")
require(dplyr)
require("ggplot2")

GDP <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from GDP"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

EXCHANGE <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from EXCHANGE"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

GDP20 <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from GDP20"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

EXCHANGE20 <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from TOP20"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))


COUNTRIES <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from A"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))


colnames(GDP20) <- toupper(names(GDP20))
colnames(EXCHANGE20) <- toupper(names(EXCHANGE20))

colnames(GDP) <- toupper(names(GDP))
colnames(EXCHANGE) <- toupper(names(EXCHANGE))


# 10 
head(GDP)
head(EXCHANGE)

# 11
joined <- inner_join(EXCHANGE20, GDP20, by = "COUNTRY")

#outer attempt they don't work unfortunately.
inner_join(EXCHANGE, GDP, by = "COUNTRY")
left_join(EXCHANGE,GDP, by = "COUNTRY")
full_join(EXCHANGE,GDP, by = "COUNTRY")


#12 some interesting plots
ggplot(joined, aes(x=EXCHANGEPERDOLLAR, y = GDP, color = RANKING)) + geom_point()



#13

#histogram,
#Exchange Rate of curreny 
ggplot(joined, aes(x = GDP)) + geom_histogram(binwidth=100000) + labs(x="GDP of Countries ")

#categorical
categoricals <- eval(parse(text=substring(getURL(URLencode('http://129.152.144.84:5001/rest/native/?query="select * from A "'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDB1.usuniversi01134.oraclecloud.internal',  USER='C##cs329e_wkm285', PASS='orcl_wkm285', MODE='native_mode', MODEL='model', returnFor = 'R', returnDimensions = 'True'), verbose = TRUE), 1, 2^31-1)))


#png("/Users/pcannata/Mine/UT/GitRepositories/DataVisualization/RWorkshop/00 Doc/categoricals.png", width = 25, height = 10, units = "in", res = 72)

