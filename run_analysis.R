# Load required library
if (!require("dplyr")) {
  install.packages("dplyr")
}
library(dplyr)

# Download and unpack the dataset if it does not already exist
dataDir <- "./getcleandata"
if (!file.exists(dataDir)) {
  dir.create(dataDir)
}
datasetPath <- file.path(dataDir, "projectdataset.zip")
if (!file.exists(datasetPath)) {
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl, destfile = datasetPath)
  unzip(zipfile = datasetPath, exdir = dataDir)
}

# Define file paths
trainPath <- file.path(dataDir, "UCI HAR Dataset", "train")
testPath <- file.path(dataDir, "UCI HAR Dataset", "test")

# Load datasets
x_train <- read.table(file.path(trainPath, "X_train.txt"))
y_train <- read.table(file.path(trainPath, "y_train.txt"))
subject_train <- read.table(file.path(trainPath, "subject_train.txt"))

x_test <- read.table(file.path(testPath, "X_test.txt"))
y_test <- read.table(file.path(testPath, "y_test.txt"))
subject_test <- read.table(file.path(testPath, "subject_test.txt"))

features <- read.table(file.path(dataDir, "UCI HAR Dataset", "features.txt"))
activityLabels <- read.table(file.path(dataDir, "UCI HAR Dataset", "activity_labels.txt"))
colnames(activityLabels) <- c("activityID", "activityType")

# Label data
colnames(x_train) <- features[, 2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"
colnames(x_test) <- features[, 2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

# Merge datasets
alltrain <- cbind(subject_train, y_train, x_train)
alltest <- cbind(subject_test, y_test, x_test)
finaldataset <- rbind(alltrain, alltest)

# Extract measurements on the mean and standard deviation
selectedColumns <- grepl("activityID|subjectID|mean\\(\\)|std\\(\\)", names(finaldataset))
setforMeanandStd <- finaldataset[, selectedColumns]

# Use descriptive activity names
setWithActivityNames <- merge(setforMeanandStd, activityLabels, by = "activityID", all.x = TRUE)

# Label the dataset with descriptive variable names
names(setWithActivityNames) <- gsub("^t", "time", names(setWithActivityNames))
names(setWithActivityNames) <- gsub("^f", "frequency", names(setWithActivityNames))
names(setWithActivityNames) <- gsub("Acc", "Accelerometer", names(setWithActivityNames))
names(setWithActivityNames) <- gsub("Gyro", "Gyroscope", names(setWithActivityNames))
names(setWithActivityNames) <- gsub("Mag", "Magnitude", names(setWithActivityNames))
names(setWithActivityNames) <- gsub("BodyBody", "Body", names(setWithActivityNames))

# Create a tidy dataset with the average of each variable for each activity and subject
tidySet <- setWithActivityNames %>%
  group_by(subjectID, activityType) %>%
  summarise_all(mean, na.rm = TRUE)

# Write the tidy dataset to a file
write.table(tidySet, "tidySet.txt", row.names = FALSE)

# Print completion message
cat("Data processing complete, tidy dataset saved as 'tidySet.txt'.\n")
