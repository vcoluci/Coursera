quiz4 <- function(){
  library("quantmod")
  amzn <- getSymbols("AMZN",auto.assign=FALSE)
  sampleTimes <- index(amzn) 
  timeDT <- data.table::data.table(timeCol = sampleTimes)
  
  # How many values were collected in 2012? 
  a <- timeDT[(timeCol >= "2012-01-01") & (timeCol) < "2013-01-01", .N ]
  # Answer: 
  print(a)
  # 20
   
  library(dplyr)
  mutate(timeDT, dia = weekdays(timeDT$timeCol)) ##adiciona a coluna dia com o nome do dia da semana
  ## o nome do dia da semana pode variar de acordo com o timeZone da maquina
  # How many values were collected on Mondays in 2012?
  b <- timeDT[((timeDT$timeCol >= "2012-01-01") & (timeDT$timeCol < "2013-01-01")) & (weekdays(timeDT$timeCol) == "segunda"), .N ]
  # Answer:
  print(b)
  # 47
}