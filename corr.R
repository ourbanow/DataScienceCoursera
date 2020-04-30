# the corr function

corr <- function(directory, threshold = 0){
  listofmon <- complete(directory)
  listofmontothres <- listofmon[listofmon$nobs>=threshold,1] #the vector containing the indexes of the files we want to work with
  vec <- vector()
  for (i in listofmontothres){
    filepath <- paste(directory,"/", sprintf("%03d",i),".csv",sep="")
    monitordata <- read.csv(filepath)
    complete_data <- monitordata[complete.cases(monitordata),]
    nitrate <- complete_data["nitrate"]
    sulfate <- complete_data["sulfate"]
    vec <- c(vec, cor(sulfate,nitrate))
    
   #end of for loop 
  }
  vec  
  #end of function
}
