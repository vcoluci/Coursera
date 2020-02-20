corr <- function (directory, threshold = 0, logar = "FALSE") {
  
  result <- numeric()
  filelist <- list.files(path=directory, pattern = "*.csv", full.names = TRUE)
  universo <- complete(directory) #tirar 187:190
  
  id <- 1: dim(universo)[1]
  for(i in id){
   if (logar) {
      cat("Entrou no For:", i, "\n") 
   }
   current <- universo[i,]
   linhas_completas <- current[2]
   if (linhas_completas > threshold) {
     #le o arquivo
     if (logar) {
       cat("Lendo o arquivo:", current[1]$id, "\n")
     }
     data <- read.csv(filelist[current[1]$id])
     data_completo <- data[complete.cases(data),]
     correlacao <- cor(data_completo$sulfate, data_completo$nitrate)
     if (logar) {
       cat("Correlação do arquivo:", current[1]$id, " é de ", correlacao ,"\n")
     }
     result <- c(result, correlacao)
     }
  }
  return(result)
}