# title:  Week 2 R Programming project part 3
# date:  23 March 2018
# author:  Bubba Lewis
# ____________________________________

# create a function named 'corr' that calculates the correlation between sulfate and nitrate for monitor locations where the 
# number of completely observed cases is greater than a threshold value.

corr <- function(directory, threshold = 0) {
  
      #create a charater vector containing a list of files from a specified directory
      files <- list.files(paste("~/tmp/", directory, sep = ""), full.names = TRUE)
      
      cor.vec <- vector("numeric")  # we need a vector of length zero here
      # (I initially incorrectly defined cor.vec as vector("numeric", length(files)) which created a vector of length 332)
      # (This caused my 5 number summary to return incorrect values)
      
      j <- 1 # an index to populate the cor.vec vector
      for(i in seq_along(files)) { #(I initially incorrectly used 'length(files)' as the arg to seq_along)
            df <- read.csv(files[i])
            
            if(sum(complete.cases(df)) > threshold) {
                #calculate correlation between sulfate and nitrate where both values exist
                cor.vec[j] <- cor(df[complete.cases(df),2], df[complete.cases(df),3])
                j <- j + 1
            }
      }
    cor.vec 
}


cr <- corr("specdata", 400)
head(cr)
summary(cr)
length(cr)



