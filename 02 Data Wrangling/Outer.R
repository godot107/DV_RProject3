#Data Frames Used:
POP <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from POP"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

BIRTH <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from BIRTH"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

#Outer Join
full <- full_join(BIRTH, POP, by = "COUNTRY") %>% tbl_df()

#Visualization of Outer Join
ggplot(full, aes(x=COUNTRY, y = BIRTHRATE, color = POPULATION)) + geom_point()
full %>% group_by(REGION.x, BIRTHRATE) %>% summarise(mean_br=mean(BIRTHRATE)) %>% ggplot(aes(x = REGION.x, y=mean_br)) + geom_point() + ggtitle('BIRTHRATES OF PER REGION') + theme(legend.title=element_text(colour="chocolate",size=16,face="bold")) + theme(axis.test.x=element_text(angle=50, size = 20, vjust=.5))