# title:  Week 2 R Programming project part 2
# date:  22 March 2018
# author:  Bubba Lewis
# ____________________________________

# create a function named 'complete' that reports the number of complete observed cases in each data file.

complete <- function(directory, id = 1:332) {
  
      #create a charater vector containing a list of files from a specified directory
      files <- list.files(paste("~/tmp/", directory, sep = ""), full.names = TRUE)[id]
      
      df <- data.frame()
      for(i in seq_along(id)) {
        #create a dataframe that sums the number of complete cases from each file read into the function
        dat <- data.frame(id = id[i], nobs = sum(complete.cases(read.csv(files[i]))))
        df <- rbind(df, dat)
      }
      df
}
 
complete("specdata", 3) 
complete("specdata", c(2,4,8,10,12))
complete("specdata", 30:25)

