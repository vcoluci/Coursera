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
  
  if (outcome == "heart attack") {
    estado_corrente$`heart attack` <- as.numeric(as.character(estado_corrente$`heart attack`))
  } else {
    if (outcome == "heart failure") {
      estado_corrente$`heart failure` <- as.numeric(as.character(estado_corrente$`heart failure`))
    } else {
      estado_corrente$pneumonia <- as.numeric(as.character(estado_corrente$pneumonia))
    }
  }
  
  estado_corrente <- estado_corrente[!is.na(estado_corrente[outcome]), ]
  if (is.numeric(num)) {
    if (nrow(estado_corrente) < num) {
      return(NA)
    } 
  } else {
    if (num == "best") {
      num <- 1
    } else {
      num <- nrow(estado_corrente)
    }
  }
  
  hospitais_ordenados <- estado_corrente[order(estado_corrente[outcome], estado_corrente$hospital ), ]
  output  <- hospitais_ordenados[num, "hospital"]
  return(output)
  
}