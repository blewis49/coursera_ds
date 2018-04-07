# Getting and Cleaning Data (gacd): week 1 quiz
# load libraries
install.packages("XML")
install.packages("data.table")
library(dplyr)
library(readxl)
library(XML)
library(data.table)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "acs2006.csv", method = "curl")
acs_2006 <- read.csv("acs2006.csv")
head(acs_2006)

# Q1: How many properties are worth more than $1M?
nrow(filter(acs_2006, VAL == 24))

fileUrl2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl2, destfile = "nat_gas.xlsx", method = "curl")

# Q3: What is the sumproduct of the values in the range of input?
dat <- read_xlsx("nat_gas.xlsx", range = "G18:O23")
sum(dat$Zip*dat$Ext,na.rm=T)

# Q4: How many restaurants are in zipcode 21231?
# save the XML file directly to the wd from the link source
doc <- xmlTreeParse("restaurants.xml", useInternalNodes = T)
xpathSApply(doc, "//zipcode", xmlValue)
# count the number of occurrences of zipcode 21231
table(xpathSApply(doc, "//zipcode", xmlValue))

# Q5: Which code has the fastest user time below?
fileUrl3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl3, destfile = "idaho_acs2006.csv", method = "curl")
DT <- fread("idaho_acs2006.csv")
system.time(DT[,mean(pwgtp15), by = SEX])
#mean(DT$pwgtp15, by = DT$SEX)
#rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
#system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
#system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
#system.time(tapply(DT$pwgtp15,DT$SEX,mean))
