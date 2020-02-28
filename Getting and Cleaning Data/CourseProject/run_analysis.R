##############################################################################
#
# FILE
#   run_analysis.R
#
# Steps
#   1. Merges the training and the test sets to create one data set.
#   2. Extracts only the measurements on the mean and standard deviation for each measurement.
#   3. Uses descriptive activity names to name the activities in the data set
#   4. Appropriately labels the data set with descriptive variable names.
#   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.Using data collected from the accelerometers from the Samsung Galaxy S 
#
run_analysis <- function() {
  
  library(dplyr)
  #Pre-req
  #Consider that the data files are unzip and in folder UCI_HAR_Dataset
  
  #reading test data
  x_test <- read.table("UCI_HAR_Dataset/test/X_test.txt")
  y_test <- read.table("UCI_HAR_Dataset/test/y_test.txt")
  subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt")

  #reading trainning data  
  x_train <- read.table("UCI_HAR_Dataset/train/X_train.txt")
  y_train <- read.table("UCI_HAR_Dataset/train/y_train.txt")
  subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
  
  features <- read.table("UCI_HAR_Dataset/features.txt", as.is = TRUE)
  
  # read activity labels
  activities <- read.table("UCI_HAR_Dataset/activity_labels.txt", 
                           col.names = c("activityId", "activityLabel"))
  
  #####################################
  # 1. Merges the training and the test sets to create one data set.
  #####################################
  
  humanActivity <- rbind(
    cbind(subject_train, x_train, y_train),
    cbind(subject_test, x_test, y_test)
  )

  # remove individual data tables to save memory
  rm(subject_train, x_train, y_train,
     subject_test, x_test, y_test)
  
  colnames(humanActivity) <- c("subject", features[, 2], "activity")
  
  #####################################
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  #####################################
  columnsToKeep <- grepl("subject|activity|mean|std", colnames(humanActivity))
  
  # ... and keep data in these columns only
  humanActivity <- humanActivity[, columnsToKeep]
  
  #####################################
  # 3. Uses descriptive activity names to name the activities in the data set
  #####################################
  humanActivity$activity <- factor(humanActivity$activity, 
                                   levels = activities[, 1], labels = activities[, 2])
 
  #####################################
  # 4. Appropriately labels the data set with descriptive variable names.
  ##################################### 
  
  # # get column names
  humanActivityCols <- colnames(humanActivity)
  humanActivityCols <- gsub("[\\(\\)-]", "", humanActivityCols)
  
  colnames(humanActivity) <- humanActivityCols
  
  #####################################
  # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.Using data collected from the accelerometers from the Samsung Galaxy S 
  ##################################### 
  humanActivityGrouped <- group_by(humanActivity, subject, activity)
  
  formulaCols <- humanActivityCols[-length(humanActivityCols)]
  formulaCols <- formulaCols[-1]
  humanActivityMeans <- summarise_at(humanActivityGrouped, formulaCols ,mean)
  
  #creating a tidy dataset file  
  write.table(humanActivityMeans, file = "tidydataset.txt", row.names = FALSE)
  
}