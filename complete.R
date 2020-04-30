# complete returns a dataframe which counts the number of complete cases in each csv file

complete <- function(directory, id = 1:332) {
  df <- data.frame(id=integer(0),nobs=integer(0))
  for (i in 1:length(id)) {
    j <- id[i]
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
    df[nrow(df) +1, ] = c(j, sum(complete.cases(monitordata)))
    #closing the loop
  }
    #result and end of fonction
  df
}
