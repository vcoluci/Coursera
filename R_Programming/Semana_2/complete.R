complete <- function (directory, id = 1:332) {
  
  filelist <- list.files(path=directory, pattern = "*.csv", full.names = TRUE)
  values <- numeric()
  
  for (i in id) {
    data1 <- read.csv(filelist[i])
    values <- c(values, sum(complete.cases(data1)))
  }
  data.frame(id, values)
}