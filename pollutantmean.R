# pollutantmean calculates the mean of the pollutant (either sulfate or nitrate) across all monitors. 
# arguments of pollutantmean: 
  #directory: path to the folder containing the csv files to read
  #pollutant: either sulfate of nitrate. contained in the names of the columns
  #id is by default a vector with the index of all the files to be read /!\ we may not want to read all the files in order...

#pollutantman will return the mean excluding NA values: hint na.rm=TRUE to be inserted in the mean function

pollutantmean <- function(directory, pollutant, id = 1:332) {
  vec <- vector()
  for (i in 1:length(id)) {
  j <- id[i]
      if (j<10) {
      monitorid <- paste("00",j,sep="")
      } #end of first statement
    else {
      if (j<100){
        monitorid <- paste("0",j,sep="")
      } #end of first of second statement
      else {
      monitorid <- j
      } # end of second of second statement
    } # end of second statement
    filepath <- paste(directory,"/",monitorid,".csv",sep="")
    monitordata <- read.csv(filepath)
    vec <- c(vec,monitordata[,pollutant]) 
  } #end of for loop
  mean(vec,na.rm=TRUE)
} #end of function
