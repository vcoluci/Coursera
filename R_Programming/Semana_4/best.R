best <- function(state, outcome) {
  
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  states <- data[ , 7] # a coluna 7 eh a do Estado
  
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  if ((state %in% states) == FALSE) {
    stop(print("invalid state"))
  }
  else if ((outcome %in% outcomes) == FALSE) {
    stop(print("invalid outcome"))
  }
  
  fd   <- as.data.frame(cbind(data[, 2],   # hospital
                              data[, 7],   # state
                              data[, 11],  # heart attack
                              data[, 17],  # heart failure
                              data[, 23]), # pneumonia
                        stringsAsFactors = FALSE)
  colnames(fd) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")

  estado_corrente <- fd[fd$state == state, ]
  hospitais_com_dados <- estado_corrente[estado_corrente[outcome] != "Not Available",]
  coluna_buscada <- as.numeric(hospitais_com_dados[, eval(outcome)])
  min_val <- min(coluna_buscada, na.rm = TRUE)
  result <- hospitais_com_dados[coluna_buscada == min_val, ]
  output  <- result[order(result$hospital), "hospital"]
  return(output)
  
}