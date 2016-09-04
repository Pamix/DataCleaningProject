
## Getting and Cleaning Data Course Project 
## Johns Hopkins University - Coursera
## Assignment
## Pamela Escobar


## Set the working directory

setwd("set your working directory")
# load necessary libraries

## First we need to read the datasets in R
###### Test Dataset 
## Test set, X-test = 2947 obs of 561 variables

dataXtest<-read.table("./UCI HAR Dataset/test/X_test.txt")

## labels, y-test = 2947 obs of 1 variable

dataYtest<-read.table("./UCI HAR Dataset/test/y_test.txt")

## subject, subject_test = 2947 obs of 1 variable

dataSubjecttest<-read.table("./UCI HAR Dataset/test/subject_test.txt")

####### Training Dataset
## Train set, X-train = 7352 obs of 561 variables

dataXtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")

## labels, y-train = 7352 obs of 1 variable

dataYtrain<-read.table("./UCI HAR Dataset/train/y_train.txt")

## subject, subject_train = 7352 obs of 1 variable

dataSubjecttrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")

## variables names

namesvar<-read.table("./UCI HAR Dataset/features.txt")

#####################################################################
#### 1- Merge the training and the test sets to create one dataset.
# 1.1- dataXtest y dataXtrain naming

names(dataXtest)<-namesvar[,2]
names(dataXtrain)<-namesvar[,2]

# 1.2- dataSubjecttest (subject data) y dataYtest (activity data) naming for test and training data set
names(dataSubjecttest)<-"subject"
names(dataYtest)<-"activity"

names(dataSubjecttrain)<-"subject"
names(dataYtrain)<-"activity"

## 1.3- Dataset merge - rbind and cbind
# subject, dataYtest -new variable data-, dataXtest

dataSubjecttest$data<-"test"
datatest<-cbind(dataSubjecttest,dataYtest,dataXtest)

dataSubjecttrain$data<-"training"
datatrain<-cbind(dataSubjecttrain, dataYtrain, dataXtrain)

data<-rbind(datatest,datatrain)

#### 2- Extracts only the measurements on the mean and standard deviation for each measurement
## dim 10,299 obs and 69 variables (66 for mean and st, 1 for subject, 1 for activity and 1 for data)

datams<-select(data, 
               subject, 
               data, 
               activity, 
               contains("mean"), 
               contains("std"), 
               -contains("meanFreq"), 
               -contains("angle"))

### 3- Uses descriptive activity names to name the activities in the data set

datams$activity<-factor(datams$activity, 
                        levels = c(1,2,3,4,5,6), 
                        labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", 
                                   "SITTING", "STANDING", "LAYING" ))

### 4- Appropriately labels the data set with descriptive variable names
# For the variables names I replaced the "-" and deleted the "()". 
# Because the variables are very specific estimations, it's important to keep all the necessary 
# information to be able to identify each variable. 

# replace the "()" by ""

names(datams)<-gsub("\\(\\)", "", names(datams))

# replace "-" by "_"

names(datams)<-gsub("-","_", names(datams))
names(datams)


### 5- From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.
# I deleted the variable data, because is not possible to get the average of a factor variable

by_group<-group_by(datams, subject, activity)
datams_mean<-summarise_all(by_group, mean)
datams_mean<-select(datams_mean, -data)

# I added labels to each variable 

label(datams_mean$subject)<-"Volunteers for the experiment between 19-48 years"
label(datams_mean$activity)<-"Activity performed"
label(datams_mean$tBodyAcc_mean_X)<-"Mean value for body acceleration time signals-X"
label(datams_mean$tBodyAcc_mean_Y)<-"Mean value for body acceleration time signals-Y"
label(datams_mean$tBodyAcc_mean_Z)<-"Mean value for body acceleration time signals-Z"
label(datams_mean$tGravityAcc_mean_X)<-"Mean value for gravity acceleration time signals-X"
label(datams_mean$tGravityAcc_mean_Y)<-"Mean value for gravity acceleration time signals-Y"
label(datams_mean$tGravityAcc_mean_Z)<-"Mean value for gravity acceleration time signals-Z"
label(datams_mean$tBodyAccJerk_mean_X)<-"Mean value for acceleration Jerk time signals-X"
label(datams_mean$tBodyAccJerk_mean_Y)<-"Mean value for acceleration Jerk time signals-Y"
label(datams_mean$tBodyAccJerk_mean_Z)<-"Mean value for acceleration Jerk time signals-Z"
label(datams_mean$tBodyGyro_mean_X)<-"Mean value for body gyro time signals-X"
label(datams_mean$tBodyGyro_mean_Y)<-"Mean value for body gyro time signals-Y"
label(datams_mean$tBodyGyro_mean_Z)<-"Mean value for body gyro time signals-Z"
label(datams_mean$tBodyGyroJerk_mean_X)<-"Mean value for body gyro jerk time signals-X"
label(datams_mean$tBodyGyroJerk_mean_Y)<-"Mean value for body gyro jerk time signals-Y"
label(datams_mean$tBodyGyroJerk_mean_Z)<-"Mean value for body gyro jerk time signals-Z"
label(datams_mean$tBodyAccMag_mean)<-"Mean value for body acceleration and magnitude time signals"
label(datams_mean$tGravityAccMag_mean)<-"Mean value for gravity acceleration and magnitude time signals"
label(datams_mean$tBodyAccJerkMag_mean)<-"Mean value for body acceleration jerk and magnitude time signals"
label(datams_mean$tBodyGyroMag_mean)<-"Mean value for body gyro magnitude time signals"
label(datams_mean$tBodyGyroJerkMag_mean)<-"Mean value for body gyro jerk and magnitude time signals"
label(datams_mean$fBodyAcc_mean_X)<-"Mean value for body acceleration frequency signals-X"
label(datams_mean$fBodyAcc_mean_Y)<-"Mean value for body acceleration frequency signals-Y"
label(datams_mean$fBodyAcc_mean_Z)<-"Mean value for body acceleration frequency signals-Z"
label(datams_mean$fBodyAccJerk_mean_X)<-"Mean value for body acceleration jerk frequency signals-X"
label(datams_mean$fBodyAccJerk_mean_Y)<-"Mean value for body acceleration jerk frequency signals-Y"
label(datams_mean$fBodyAccJerk_mean_Z)<-"Mean value for body acceleration jerk frequency signals-Z"
label(datams_mean$fBodyGyro_mean_X)<-"Mean value for body gyro frequency signals-X"
label(datams_mean$fBodyGyro_mean_Y)<-"Mean value for body gyro frequency signals-Y"
label(datams_mean$fBodyGyro_mean_Z)<-"Mean value for body gyro frequency signals-Z"
label(datams_mean$fBodyAccMag_mean)<-"Mean value for body acceleration and magnitude frequency signals"
label(datams_mean$fBodyBodyAccJerkMag_mean)<-"Mean value for body acceleration jerk magnitude for frequency signals"
label(datams_mean$fBodyBodyGyroMag_mean)<-"Mean value for body gyro and magnitude frequency signals"
label(datams_mean$fBodyBodyGyroJerkMag_mean)<-"Mean value for body gyro jerk magnitude frequency signals"
label(datams_mean$tBodyAcc_std_X)<-"Standard deviation for body acceleration time signals-X"
label(datams_mean$tBodyAcc_std_Y)<-"Standard deviation for body acceleration time signals-Y"
label(datams_mean$tBodyAcc_std_Z)<-"Standard deviation for body acceleration time signals-Z"
label(datams_mean$tGravityAcc_std_X)<-"Standard deviation for gravity acceleration time signals-X"
label(datams_mean$tGravityAcc_std_Y)<-"Standard deviation for gravity acceleration time signals-Y"
label(datams_mean$tGravityAcc_std_Z)<-"Standard deviation for gravity acceleration time signals-Z"
label(datams_mean$tBodyAccJerk_std_X)<-"Standard deviation for body acceleration jerk time signals-X"
label(datams_mean$tBodyAccJerk_std_Y)<-"Standard deviation for body acceleration jerk time signals-Y"
label(datams_mean$tBodyAccJerk_std_Z)<-"Standard deviation for body acceleration jerk time signals-Z"
label(datams_mean$tBodyGyro_std_X)<-"Standard deviation for body gyro time signals-X"
label(datams_mean$tBodyGyro_std_Y)<-"Standard deviation for body gyro time signals-Y"
label(datams_mean$tBodyGyro_std_Z)<-"Standard deviation for body gyro time signals-Z"
label(datams_mean$tBodyGyroJerk_std_X)<-"Standard deviation for body gyro jerk signals-X"
label(datams_mean$tBodyGyroJerk_std_Y)<-"Standard deviation for body gyro jerk signals-Y"
label(datams_mean$tBodyGyroJerk_std_Z)<-"Standard deviation for body gyro jerk signals-Z"
label(datams_mean$tBodyAccMag_std)<-"Standard deviation for body acceleration and magnitude time signals"
label(datams_mean$tGravityAccMag_std)<-"Standard deviation for gravity acceleration and magnitude time signals"
label(datams_mean$tBodyAccJerkMag_std)<-"Standard deviation for body acceleration jerk and magnitude time signals"
label(datams_mean$tBodyGyroMag_std)<-"Standard deviation for body gyro and magnitude time signals"
label(datams_mean$tBodyGyroJerkMag_std)<-"Standard deviation for body gyro jerk and magnitude time signals"
label(datams_mean$fBodyAcc_std_X)<-"Standard deviation for body acceleration frequency signals-X"
label(datams_mean$fBodyAcc_std_Y)<-"Standard deviation for body acceleration frequency signals-Y"
label(datams_mean$fBodyAcc_std_Z)<-"Standard deviation for body acceleration frequency signals-Z"
label(datams_mean$fBodyAccJerk_std_X)<-"Standard deviation for body acceleration jerk frequency signals-X"
label(datams_mean$fBodyAccJerk_std_Y)<-"Standard deviation for body acceleration jerk frequency signals-Y"
label(datams_mean$fBodyAccJerk_std_Z)<-"Standard deviation for body acceleration jerk frequency signals-Z"
label(datams_mean$fBodyGyro_std_X)<-"Standard deviation for body gyro frequency signals-X"
label(datams_mean$fBodyGyro_std_Y)<-"Standard deviation for body gyro frequency signals-Y"
label(datams_mean$fBodyGyro_std_Z)<-"Standard deviation for body gyro frequency signals-Z"
label(datams_mean$fBodyAccMag_std)<-"Standard deviation for body acceleration and magnitude frequency signals"
label(datams_mean$fBodyBodyAccJerkMag_std)<-"Standard deviation for body acceleration jerk and magnitude frequency signals"
label(datams_mean$fBodyBodyGyroMag_std)<-"Standard deviation for body gyro and magnitude frequency signals"
label(datams_mean$fBodyBodyGyroJerkMag_std)<-"Standard deviation for body gyro jerk and magnitude frequency signals"

## Save the dataset in the working directory.

write.table(datams_mean, "./data_humanact_avg.txt", col.names = TRUE, row.names = FALSE)


