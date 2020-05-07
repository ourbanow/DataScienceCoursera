##This script is to be run as part of the "Getting and Cleaning Data" Course Project. 
## The script: 
## 1. Merges the training and the test sets to create one data set
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##------------------------- start here
## Please start by making sure you are in the right wd
rm(list = ls())
library(dplyr)
library(data.table)

## downloading the files
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("HAR Dataset.zip")) {
    download.file(fileUrl,"HAR Dataset.zip", mode="wb" )
}
unzip(zipfile = "HAR Dataset.zip")

## loading the info files
activity_labels <- fread("UCI HAR Dataset/activity_labels.txt", col.names = c("class_label","activity_name"))
features <- fread("UCI HAR Dataset/features.txt", col.names = c("feature_id","feature_name"))

## loading test files
test_set <- fread("UCI HAR Dataset/test/X_test.txt", col.names = features$feature_name)
test_labels <- fread("UCI HAR Dataset/test/y_test.txt", col.names = "class_label")
test_subject <- fread("UCI HAR Dataset/test/subject_test.txt", col.names = "subject_id")
## re-building the test data set
set <- rep("test", nrow(test_set)) ## adding a column which specifies these where test observations
test_labels <- merge(test_labels,activity_labels) ## adding descriptive activity names
test_data <- cbind(set, test_labels, test_subject, test_set)

## loading training files
train_set <- fread("UCI HAR Dataset/train/X_train.txt", col.names = features$feature_name)
train_labels <- fread("UCI HAR Dataset/train/y_train.txt", col.names = "class_label")
train_subject <- fread("UCI HAR Dataset/train/subject_train.txt", col.names = "subject_id")
## re-building the test data set
set <- rep("train", nrow(train_set)) ## adding a column which specifies these where training observations
train_labels <- merge(train_labels,activity_labels) ## adding descriptive activity names
train_data <- cbind(set, train_labels, train_subject, train_set)

## merging both sets
all_data <- rbind(test_data, train_data)
## ------------ all_data is the complete data set, containing both labeled test and train data, 
##              with labeled columns, subject id and explicit activity names

## extract the mean and std variables
index <- c("activity_name", "subject_id",grep("mean\\(\\)|std\\(\\)", names(all_data), value = TRUE))
filtered_data <- all_data[,..index]
grouped_data <- group_by(filtered_data, activity_name, subject_id)
tidy_data <- summarize_each(grouped_data, mean)

## ------------ here is the final tidy_data set
tidy_data