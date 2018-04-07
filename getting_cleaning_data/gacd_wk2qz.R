install.packages("sqldf")
library(sqldf)

# Working with SQL using the SQLDF package --------------------------

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "acs.csv", method = "curl")
acs <- read.csv("acs.csv")

sqldf("select pwgtp1 from acs where AGEP < 50")

# The sqldf statement equivalent to unique(acs$AGEP) is:
sqldf("select distinct AGEP from acs")

# To count the number of distinct values, use count:
sqldf("select count(distinct AGEP) from acs")

# Working with a HTML file from the internet ------------------------

# Create a connection to the url, then readLines from and close the connection
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(con)
close(con)

# The result of readLines() is a character vector where each line is an element
# count the number of characters in specified lines of the code
nchar(htmlCode[c(10, 20, 30, 100)])

# Working with Fixed Width Format files -----------------------------

# Read in the fortran file with read.fwf(), you must know start and stop width for columns
# There are 4 lines of header to skip before the first row of data begins
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile = "fortran.for", method = "curl")
fort <- read.fwf("fortran.for", widths = c(10,9,4,9,4,9,4,9,4), skip = 4)
dim(fort)
sum(fort$V4)


