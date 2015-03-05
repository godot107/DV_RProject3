require("jsonlite")
library("RCurl")
require(dplyr)
require("ggplot2")
library(extrafont)

ARABLE <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from ARABLE"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE))) 

tbl_df(ARABLE)
CLIMATE <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from CLIMATE"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_wkm285', PASS='orcl_wkm285',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE))) 

tbl_df(CLIMATE)

head(bind_cols(ARABLE, CLIMATE))