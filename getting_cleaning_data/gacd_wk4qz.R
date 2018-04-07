install.packages("quantmod")
library(quantmod)
library(dplyr)

# Q1: Apply strsplit() to split all the names of the data frame on the characters "wgtp".
# What is the value of the 123 element of the resulting list? [answer: "" "15"]
# acs_2006 is the Idaho dataset downloaded in an earlier session still in my environ otherwise
# download.file(fileUrl, destfile = "acs2006.csv", method = "curl")
# acs_2006 <- read.csv("acs2006.csv")
strsplit(names(acs_2006), "wgtp")   # Returns a list of 188 elements

# Q2: Download the GDP file and calculate the mean of the dollar values
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", 
              destfile = "gdp190.csv", method = "curl")
gdp190 <- read.csv("gdp190.csv", skip = 4)
# select the appropriate subset of data and 
# remove the commas from the dollars in millions and average the variable
gdp190a <- gdp190[1:190, c(1,2,4:5)]
names(gdp190a) <- c("Country", "Ranking", "CountryName", "GDP_Dollars")
gdp190a$GDP_Dollars <- gsub(",", "", gdp190a$GDP_Dollars)
mean(as.numeric(as.character(gdp190a$GDP_Dollars)))

# Q3: How many Countries in the GDP file begin with "United"?
grep("^United", gdp190a$CountryName, value = T) #ans: 3

# Q4: Merge the GDP and Education Stats files on country short names 
# and count how many Fiscal Years end in June. [ans: 13]
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", 
              destfile = "edstats.csv", method = "curl")
edstats <- read.csv("edstats.csv")
merged_data <- merge(gdp190a, edstats, by.x = "Country", by.y = "CountryCode")
length(grep("Fiscal year end: June 30;", merged_data$Special.Notes))

# Q5: get historical stock prices for publicly traded companies on the NASDAQ and NYSE. 
# Use the following code to download data on Amazon's stock price and get the times the data was sampled.
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
# How many sample times were collected in the year 2012? [ans: 250]
length(sampleTimes[year(sampleTimes) == 2012])

# How many sample times were collected on Mondays in 2012? [ans: 47]
length(sampleTimes[year(sampleTimes) == 2012 & wday(sampleTimes, label = T) == "Mon"])











