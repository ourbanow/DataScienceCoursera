# pollutantmean calculates the mean of the pollutant (either sulfate or nitrate) across all monitors. 
# arguments of pollutantmean: 
  #directory: path to the folder containing the csv files to read
  #pollutant: either sulfate of nitrate. contained in the names of the columns
  #id is by default a vector with the index of all the files to be read

#pollutantman will return the mean excluding NA values: hint na.rm=TRUE to be inserted in the mean function

pollutantmean <- function(directory, pollutant, id = 1:332) {
  vec <- vector()
  j <- id[1]
  while (j<=id[length(id)]){
    if (j<10) {
      monitorid <- paste("00",j,sep="")
      } 
    else {
      if (j<100){
        monitorid <- paste("0",j,sep="")
      }
      else {
      monitorid <- j
      }
    }
    filepath <- paste(directory,"/",monitorid,".csv",sep="")
    monitordata <- read.csv(filepath)
    vec <- c(vec,monitordata[,pollutant]) 
  j=j+1
  }
  mean(vec,na.rm=TRUE)
} 

