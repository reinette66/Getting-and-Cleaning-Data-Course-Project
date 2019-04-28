Download dataset and unzip the attachment if it exists.

Read in the dataset and assign column names.
- features: 'features.txt', list of all features.
- activity_labels: 'activity_labels.txt', links the class labels with their activity name.
- subject_test: 'subject_test.txt', subject data
- subject_train: 'subject_train.txt', subject data
- x_test: 'test/X_test.txt', test set.
- y_test: 'test/y_test.txt', test labels.
- x_train: 'train/X_train.txt', training set.
- y_train: 'train/y_train.txt', training labels.

Steps:
1. Merges the training and the test sets to create one data set.

- X: Merged dataset of x_train and x_test
- Y: Merged dataset of y_train and y_test 
- Subject: Merged dataset of subject_train and subject_test 
- Merged_Data: Merged dataset of Subject, Y and X

2. Extracts only the measurements on the mean and standard deviation for each measurement.

Mean_Std: Subset dataset by selecting columns that contain mean and standard deviation

3. Uses descriptive activity names to name the activities in the data set

Mean_Std$code: Using activity_labels, renamed values with descriptive activity names 

4. Appropriately labels the data set with descriptive variable names.

Renamed the column names in Mean_Std such that they are more descriptive

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

NewData: Second data which takes the mean of each variable for each activity and each subject.
