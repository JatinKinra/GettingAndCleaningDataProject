## The data zip file has been downloaded and unzipped to
## C:/Users/Jatin/Desktop/Coursera/GettingAndCleaningData/UCI HAR Dataset
## This is the current working directory


## Step1 - Merging Training and Test data.

# 1.1 - Gathering Training data
setwd('C:/Users/Jatin/Desktop/Coursera/GettingAndCleaningData/UCI HAR Dataset/train')
train_measurements <- read.table("X_train.txt")
train_labels <- read.table("y_train.txt")
train_subjects <- read.table("subject_train.txt")

# 1.2 - Gathering Test data
setwd('C:/Users/Jatin/Desktop/Coursera/GettingAndCleaningData/UCI HAR Dataset/test')
test_measurements <- read.table("X_test.txt")
test_labels <- read.table("y_test.txt")
test_subjects <- read.table("subject_test.txt")

# 1.3 - Merging data
train_data <- cbind(train_labels, train_subjects, train_measurements)
test_data <- cbind(test_labels, test_subjects, test_measurements)
merged_data <- rbind(train_data, test_data)
colnames(merged_data)[1] <- "activity"
colnames(merged_data)[2] <- "subject"


## Step 2 - Extract only the measurements on the mean and standard deviation 
## for each measurement.
library(plyr)
final_data <- select(merged_data, activity, subject, V1:V6, V41:V46, V81:V86, V121:V126,
                     V161:V166, V201:V202, V214:V215, V227:V228, V240, V241,
                     V253, V254, V266:V271, V345:V350, V424:V429, V503, V504,
                     V516, V517, V529, V530, V542, V543)


## Step 3 - Use descriptive activity names to name the activities in 
## the data set
labels <- sub("1","WALKING", final_data$activity)
labels <- sub("2","WALKING_UPSTAIRS", labels)
labels <- sub("3","WALKING_DOWNSTAIRS", labels)
labels <- sub("4","SITTING", labels)
labels <- sub("5","STANDING", labels)
labels <- sub("6","LAYING", labels)
final_data <- mutate(final_data , activity = labels)


## Step 4 - Appropriately label the data set with descriptive variable names
colnames(final_data) <- c("Activity", "Subject", "tBodyAcc-mean()-X", "tBodyAcc-mean()-Y",
                          "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", 
                          "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", 
                          "tGravityAcc-mean()-X","tGravityAcc-mean()-Y",
                          "tGravityAcc-mean()-Z","tGravityAcc-std()-X",
                          "tGravityAcc-std()-Y","tGravityAcc-std()-Z",
                          "tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y",
                          "tBodyAccJerk-mean()-Z","tBodyAccJerk-std()-X",
                          "tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z",
                          "tBodyGyro-mean()-X","tBodyGyro-mean()-Y",
                          "tBodyGyro-mean()-Z","tBodyGyro-std()-X",
                          "tBodyGyro-std()-Y","tBodyGyro-std()-Z",
                          "tBodyGyroJerk-mean()-X","tBodyGyroJerk-mean()-Y",
                          "tBodyGyroJerk-mean()-Z","tBodyGyroJerk-std()-X",
                          "tBodyGyroJerk-std()-Y","tBodyGyroJerk-std()-Z",
                          "tBodyAccMag-mean()","tBodyAccMag-std()",
                          "tGravityAccMag-mean()","tGravityAccMag-std()",
                          "tBodyAccJerkMag-mean()","tBodyAccJerkMag-std()",
                          "tBodyGyroMag-mean()","tBodyGyroMag-std()",
                          "tBodyGyroJerkMag-mean()","tBodyGyroJerkMag-std()",
                          "fBodyAcc-mean()-X","fBodyAcc-mean()-Y",
                          "fBodyAcc-mean()-Z","fBodyAcc-std()-X",
                          "fBodyAcc-std()-Y","fBodyAcc-std()-Z",
                          "fBodyAccJerk-mean()-X","fBodyAccJerk-mean()-Y",
                          "fBodyAccJerk-mean()-Z","fBodyAccJerk-std()-X",
                          "fBodyAccJerk-std()-Y","fBodyAccJerk-std()-Z",
                          "fBodyGyro-mean()-X","fBodyGyro-mean()-Y",
                          "fBodyGyro-mean()-Z","fBodyGyro-std()-X",
                          "fBodyGyro-std()-Y","fBodyGyro-std()-Z",
                          "fBodyAccMag-mean()","fBodyAccMag-std()",
                          "fBodyBodyAccJerkMag-mean()","fBodyBodyAccJerkMag-std()",
                          "fBodyBodyGyroMag-mean()","fBodyBodyGyroMag-std()",
                          "fBodyBodyGyroJerkMag-mean()","fBodyBodyGyroJerkMag-std()")



## Step 5 - From the final_data, creates a second, independent tidy data 
## set with the average of each variable for each activity and each subject.
library(reshape2)
tidy_data <- aggregate(final_data[, 3:ncol(final_data)], list(final_data$Subject,final_data$Activity), mean)
colnames(tidy_data)[1] <- "Subject"
colnames(tidy_data)[2] <- "Activity"
write.table(tidy_data, "C:/Users/Jatin/Desktop/Coursera/GettingAndCleaningData/Final Project/tidy_data.txt", sep="\t")




















