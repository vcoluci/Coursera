rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  states <- data[ , 7] # a coluna 7 eh a do Estado
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  if ((state %in% states) == FALSE) {
    stop(print("invalid state"))
  }
  else if ((outcome %in% outcomes) == FALSE) {
    stop(print("invalid outcome"))
  }
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  fd   <- as.data.frame(cbind(data[, 2],   # hospital
                              data[, 7],   # state
                              data[, 11],  # heart attack
                              data[, 17],  # heart failure
                              data[, 23]), # pneumonia
                        stringsAsFactors = FALSE)
  colnames(fd) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  
  estado_corrente <- fd[fd$state == state, ]
  if (is.numeric(num)) {
    if (length(estado_corrente) < num) {
      return(NA)
    } 
  } else {
    if (num == "best") {
      num <- 1
    } else {
      num <- length(estado_corrente)
    }
  }
  
  hospitais_com_dados <- estado_corrente[estado_corrente[outcome] != "Not Available",]
  #aqui aqui: erro na ordenacao as.double
  hospitais_ordenados <- hospitais_com_dados[order(as.double(hospitais_com_dados[outcome])), ]
  hospitais_ordenados2 <- estado_corrente[order(as.double(estado_corrente[outcome]),na.last = TRUE), ]
  
  output  <- hospitais_ordenados[num, "hospital"]
  return(output)
  
}