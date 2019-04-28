library(dplyr)

# Download dataset and unzip

# Download if file exist
if (!file.exists("UCIdata.zip")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, "UCIdata.zip")
}  

# Unzip if directory exist
if (!file.exists("UCI HAR Dataset")) { 
  unzip("UCIdata.zip") 
}



# Read in data

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


# 1. Merges the training and the test sets to create one data set.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

Mean_Std <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the data set

Mean_Std$code <- activity_labels[Mean_Std$code, 2]

# 4. Appropriately labels the data set with descriptive variable names.

names(Mean_Std)[2] = "ActivityName"
names(Mean_Std)<-gsub("BodyBody", "Body", names(Mean_Std))
names(Mean_Std)<-gsub("^t", "Time", names(Mean_Std))
names(Mean_Std)<-gsub("^f", "Frequency", names(Mean_Std))
names(Mean_Std)<-gsub("angle", "Angle", names(Mean_Std))
names(Mean_Std)<-gsub("gravity", "Gravity", names(Mean_Std))
names(Mean_Std)<-gsub("tBody", "TimeBody", names(Mean_Std))
names(Mean_Std)<-gsub("std..", "Std", names(Mean_Std))
names(Mean_Std)<-gsub("mean..", "Mean", names(Mean_Std))
names(Mean_Std)<-gsub("Meaneq..", "Meaneq", names(Mean_Std))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

NewData <- Mean_Std %>%
  group_by(subject, ActivityName) %>%
  summarise_all(funs(mean))
write.table(NewData, "NewData.txt", row.name=FALSE)

str(NewData)
