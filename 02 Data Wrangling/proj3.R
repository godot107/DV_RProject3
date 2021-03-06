require("jsonlite")
library("RCurl")
require(dplyr)
require("ggplot2")
library(extrafont)

#9 Creating Data Frames 

GDP <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from GDP"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_lar2478', PASS='orcl_lar2478',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

CTR <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from COUNTRY"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_lar2478', PASS='orcl_lar2478',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

GDP20 <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from GDP20"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

EXCHANGE20 <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from TOP20"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))


COUNTRIES <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from A"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))


WORLD <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from WORLD"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

POP <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from POP"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

BIRTH <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from BIRTH"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

ARABLE <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from ARABLE"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

CLIMATE <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from CLIMATE"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

FULLGDP <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from FULLGDP"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_lar2478', PASS='orcl_lar2478',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

LIT <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from LIT"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_lar2478', PASS='orcl_lar2478',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))




colnames(GDP20) <- toupper(names(GDP20))
colnames(EXCHANGE20) <- toupper(names(EXCHANGE20))

# 10 subset of data frames
head(GDP)
head(EXCHANGE)
head(WORLD)

<<<<<<< HEAD
# 11
joined <- inner_join(EXCHANGE20, GDP20, by = "COUNTRY")
#outer attempt
=======
# 11 Inner-join by country 
joined <- inner_join(EXCHANGE20, GDP20, by = "COUNTRY")
inner_join(EXCHANGE20, GDP20, by = "COUNTRY")

#outer join by country
>>>>>>> 55eef9535e386d5ec7e0489574f6e43c90269477
full <- full_join(BIRTH, POP, by = "COUNTRY") %>% tbl_df()

# join from combine data sets column
left<- left_join(LIT, FULLGDP, by = "COUNTRY")

left%>% select(COUNTRY,REGION, LITERACY, GDP) %>% ggplot(aes(x=LITERACY, y=GDP, color=REGION)) + geom_point()


<<<<<<< HEAD

#12 some interesting plots
# we are curious if there's a relationship between the value of a country's currency compared to the US as a gold standard and the country's economy measured by GDP
g <- ggplot(joined, aes(x=EXCHANGEPERDOLLAR, y = GDP, color = RANKING))  + geom_point()
#g <- g + geom_jitter(alpha=1,aes(color=legend),position=position_jitter(width=.3)) 
g <-  g + ggtitle('GDP vs US Currency Exchange') + scale_color_gradient(low="darkkhaki",high="darkgreen") 
g <- g +  theme(plot.title = element_text(size=20, face = "bold" , vjust=2)) 
g <- g + theme(axis.text.x=element_text(angle=50, size=20, vjust=0.5)) 
g <- g +  theme(plot.title=element_text(size=20, face="bold", vjust=1, family="Bauhaus93")) 

g <- g + labs( x = "US Exchange rate") + ylim(c(0,10000000))



ggplot(joined, aes(x=EXCHANGEPERDOLLAR, y = GDP, color = RANKING)) + geom_point() + ggtitle('US EXCHANGE RATE VS GDP')


full %>% group_by(REGION.x, BIRTHRATE) %>% summarise(mean_br=mean(BIRTHRATE)) %>% ggplot(aes(x = REGION.x, y=mean_br)) + geom_point() 

ggplot(full, aes(x=COUNTRY, y = BIRTHRATE, color = POPULATION)) + ggtitle('BIRTHRATES OF PER REGION') + theme(legend.title=element_text(colour="chocolate",size=16,face="bold"))+ geom_point() + theme(axis.test.x=element_text(angle=50, size = 20, vjust=.5))
=======
#12 visualizations of wrangled data sets
# we are curious if there's a relationship between the value of a country's currency compared to the US as a gold standard and the country's economy measured by GDP. Visualization of Inner Join
ggplot(joined, aes(x=EXCHANGEPERDOLLAR, y = GDP, color = RANKING)) + geom_point() scale_color_gradient(low="darkkhaki",high="darkgreen") + theme(plot.title = element_text(size=20, face = "bold" , vjust=2)) + theme(axis.text.x=element_text(angle=50, size=20, vjust=0.5)) + theme(legend.title = element_text(colour = black, size = 16, face = "bold")) scale_color_discrete(name = "Ranking") + theme(legend.key=element_rect(fill='pink'))

#Visualization of Outer join
ggplot(full, aes(x=COUNTRY, y = BIRTHRATE, color = POPULATION)) + geom_point()
full %>% group_by(REGION.x, BIRTHRATE) %>% summarise(mean_br=mean(BIRTHRATE)) %>% ggplot(aes(x = REGION.x, y=mean_br)) + geom_point() + ggtitle('BIRTHRATES OF PER REGION') + theme(legend.title=element_text(colour="chocolate",size=16,face="bold")) + theme(axis.test.x=element_text(angle=50, size = 20, vjust=.5))
>>>>>>> 55eef9535e386d5ec7e0489574f6e43c90269477

#Visualization of Combined Data set join 

#13 PNG Image
#histogram,
#Exchange Rate of curreny 
ggplot(joined, aes(x = GDP)) + geom_histogram(binwidth=100000) + labs(x="GDP in Dollars ") + ggtitle('GDP of Countries')

#categorical # APPARENTLY not enough categorical variables; we only have one and that is region
cat <- eval(parse(text=substring(gsub(",)", ")", getURL(URLencode('http://129.152.144.84:5001/rest/native/?query="select * from WORLD"'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_my3852', PASS='orcl_my3852', MODE='native_mode', MODEL='model', returnFor = 'R', returnDimensions = 'True'), verbose = TRUE)), 1, 2^31-1)))


categoricals <- eval(parse(text=substring(gsub(",)", ")", getURL(URLencode('http://129.152.144.84:5001/rest/native/?query="select * from WORLD"'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_uteid', PASS='orcl_uteid', MODE='native_mode', MODEL='model', returnFor = 'R', returnDimensions = 'True'), verbose = TRUE)), 1, 2^31-1)))