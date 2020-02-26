rankall <- function(outcome, num = "best", logar = "FALSE") {
  ## validation outcome
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  if ((outcome %in% outcomes) == FALSE) {
    stop(print("invalid outcome"))
  }
  
  output <- vector()
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  ## Check that state and outcome are valid
  states <- levels(factor(data[, 7])) # a coluna 7 eh a do Estado
  
  
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  fd   <- as.data.frame(cbind(data[, 2],   # hospital
                              data[, 7],   # state
                              data[, 11],  # heart attack
                              data[, 17],  # heart failure
                              data[, 23]), # pneumonia
                        stringsAsFactors = FALSE)
  colnames(fd) <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  
  hospitais_ordenados <- c("hospital", "state", "heart attack", "heart failure", "pneumonia")
  
  #conversao dos dados para ordenacao
  if (outcome == "heart attack") {
    fd$`heart attack` <- suppressWarnings(as.numeric(as.character(fd$`heart attack`)))
  } else {
    if (outcome == "heart failure") {
      fd$`heart failure` <- suppressWarnings(as.numeric(as.character(fd$`heart failure`)))
    } else {
      fd$pneumonia <- suppressWarnings(as.numeric(as.character(fd$pneumonia)))
    }
  }
  i <- 1
  
  for(i in 1:length(states)) {
    
    estado_atual <- states[i]
    estado_corrente <- fd[fd$state == estado_atual, ]
    estado_corrente <- suppressWarnings(estado_corrente[!is.na(estado_corrente[outcome]), ])
    hospitais_ordenados <- estado_corrente[
            order(estado_corrente[outcome], estado_corrente$hospital ), ]
    
    if(num == "best") {
      numRank = 1
    } else {
          if(num == "worst") {
              numRank = nrow(hospitais_ordenados)
          }else {
                  numRank = num
                  }
    }
    
    HospitalsRanked <- hospitais_ordenados[numRank, 1]
    output <- append(output, c(HospitalsRanked, states[i]))
  }
  
  output <- as.data.frame(matrix(output, length(states), 2, byrow = TRUE))
  colnames(output) <- c("hospital", "state")
  rownames(output) <- states
  
  return(output)
  
}