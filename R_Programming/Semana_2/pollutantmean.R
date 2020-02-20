pollutantmean <- function (directory, pollutant = "sulfate", id = 1:332, logar = "FALSE") {
  
  filelist <- list.files(path=directory, pattern = "*.csv", full.names = TRUE)
  values <- numeric()
  
  for (i in id) {
    if(logar){
      cat("Lendo o arquivo", i, "\n")
    }
    data1 <- read.csv(filelist[i])
    if(logar){
      cat("Nro de linhas do arquivo ", i, "é igual a ", dim(data1)[1], "\n")
    }
    values <- c(values, data1[[pollutant]])
  }
  media <- mean(values, na.rm = TRUE)
  cat("A média é", media)

}