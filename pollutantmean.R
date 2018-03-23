# title:  Week 2 R Programming project part 1
# date:  22 March 2018
# author:  Bubba Lewis
# ____________________________________

# create a function named 'pollutantmean' that calculates the mean of a pollutant across a specified list of monitors.

pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  #create a vector containing a list of files from a specified directory
  files <- list.files(paste("~/tmp/", directory, sep = ""), full.names = TRUE)[id]
  
  #create a blank dataframe to store data
  df <- data.frame()
  
  #loop through identified files in the specified directory and combine all the data into one df
  for (i in seq_along(id)) {
    df <- rbind(df, read.csv(files[i]))
  }
  
  #calculate the mean of a specified column of the df from the function call
  mean(df[,pollutant], na.rm = TRUE)
}

#run the function
pollutantmean("specdata", "sulfate", 1:10)