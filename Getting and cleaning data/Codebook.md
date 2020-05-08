---
title: "Codebook"
author: "ourbanow"
date: "5/8/2020"
output: html_document
editor_options: 
  chunk_output_type: inline
---

## Object of this document

This codebook gives you additional information about the project, in particular:
- a description of the data set
- a description of the steps performed to clean the data set
- a preview of the result

## The initial data set
The raw data has been downloaded from the website 
[UCI Machine Learning repository] (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

#### Description of the origin of the data set:  
<font size = "2">
*Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.  
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.*
</font>   

Direct link to the raw data: [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

By unzipping the data, a folder called "UCI HAR Dataset" is automatically created.  
This folder contains the following documents:  
<font size = "2">
* 'README.txt'a description of the files to be found in the folder  
* 'features.txt': List of all measurements made during the study, in order.  
* 'features_info.txt': information about the variables used for each measured feature (see below).  
* 'activity_labels.txt': a table with the activities during which the measurements were made, including a coded index called "class_label".
</font>

Plus 2 folders, one for the data which was used to train the Human Activity Recognition (HAR) software, the other, to test it.  
In the train folder:  
<font size = "2">
* X_train.txt': Data from the training set  
* y_train.txt': Training labels, in other words: for each observation from the training set data file, what type of activity the observation is.  
* subject_train.txt': for each observation from the training set data file, the id of the subject who performed the activity
</font>

Plus additional files we did not use for this project - more info available in the 'README' file.   
In the test folder, the same type of files are available.  
For a detailed description of each feature, please read the associated file. 

## Steps performed to clean the data set
In the run_analysis.R file, you will find a script which downloads and re-organizes the data.  
**!** Because of privacy concerns, the script does not contain the working directory, which you should set before running the script

#### Phase one: "re-build" the data table
1. "Re-build" a data table for the data set used for testing by adding to the measurement file   
- the activity labels, activity names, subject id as additional columns  
- the names of the features measured as column names  
2. Perform the same to "re-build" a data table for the data set used for training  
3. Merge the two files into one data table

#### Phase two: extract interesting data
Of all the features measured, we are only interested in keeping the mean and the standard deviation, which we want to present in a table with the average of each variable for each activity for each subject.  
1. Select the relevant data from the file we created (ie. the relevant columns: activity name, subject id, as well as mean() and std() measurements)
2. Group data by activity name and by subject id
3. Summarize by the mean of the values  

#### Preview of the results
|activity_name|subject_id| tBodyAcc-mean()-X| tBodyAcc-mean()-Y| tBodyAcc-mean()-Z| 
|:------------|:--------:|-----------------:|-----------------:|-----------------:|
| 1 LAYING    |       20 |             0.268|           -0.0154|            -0.103| 
| 2 LAYING    |       24 |             0.277|           -0.0177|            -0.108| 
| 3 LAYING    |       27 |             0.278|           -0.0169|            -0.112| 
| 4 LAYING    |       28 |             0.278|           -0.0192|            -0.110| 
| 5 LAYING    |       29 |             0.279|           -0.0185|            -0.109| 
| 6 LAYING    |       30 |             0.276|           -0.0176|            -0.106| 
| 7 SITTING   |       12 |             0.276|           -0.0185|            -0.108| 
| 8 SITTING   |       13 |             0.276|           -0.0177|            -0.109| 
| 9 SITTING   |       17 |             0.273|           -0.0181|            -0.109|
|10 SITTING   |       18 |             0.278|           -0.0173|            -0.110|




