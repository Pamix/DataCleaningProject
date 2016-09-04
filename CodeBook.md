==================================================================
CodeBook  
Average by subject and activity of mean values and standard deviation for Human activity recognition using smartphones 
==================================================================

This CodeBook is divided in three parts, the first part includes the steps in R to merge the original dataset from the Human activity recognition using smartphones project. The second part includes all the transformations to prepare the dataset with the average by subject and activity of the mean values and standard deviation of all the estimations, and the third part, the description of the variables included in the final dataset. The README.md file inludes the link to the website of the project where you can download all the datasets. 

I. Merge the original datasets
First we read the original datasets in R with read.table. The datasets include information
of 30 volunteers divided in 2 groups, 70% in the training data and 30% in the test data. 

### Test Dataset 
# Test set, X-test = 2947 obs of 561 variables
dataXtest<-read.table("./UCI HAR Dataset/test/X_test.txt")

# labels, y-test = 2947 obs of 1 variable
dataYtest<-read.table("./UCI HAR Dataset/test/y_test.txt")

# subject, subject_test = 2947 obs of 1 variable
dataSubjecttest<-read.table("./UCI HAR Dataset/test/subject_test.txt")

### Training Dataset
# Train set, X-train = 7352 obs of 561 variables
dataXtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")

# labels, y-train = 7352 obs of 1 variable
dataYtrain<-read.table("./UCI HAR Dataset/train/y_train.txt")

# subject, subject_train = 7352 obs of 1 variable
dataSubjecttrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")

# variables names
namesvar<-read.table("./UCI HAR Dataset/features.txt")

Second, we merge the training and the test sets to create one dataset.
The file features contains the names of the variables, so we added the name to each data set, also we added a name for the activity and subject data, and we created a variable to differentiate the training and test data.

# dataXtest y dataXtrain naming
names(dataXtest)<-namesvar[,2]
names(dataXtrain)<-namesvar[,2]

# dataSubjecttest (subject data) y dataYtest (activity data) naming for test and training data set
names(dataSubjecttest)<-"subject"
names(dataYtest)<-"activity"

names(dataSubjecttrain)<-"subject"
names(dataYtrain)<-"activity"

## Dataset merge - rbind and cbind
# subject, dataYtest -new variable data-, dataXtest

dataSubjecttest$data<-"test"
datatest<-cbind(dataSubjecttest,dataYtest,dataXtest)

dataSubjecttrain$data<-"training"
datatrain<-cbind(dataSubjecttrain, dataYtrain, dataXtrain)

data<-rbind(datatest,datatrain)


II. Transformation to prepare the dataset

#### Extracts only the measurements on the mean and standard deviation for each measurement
## dim 10,299 obs and 69 variables (66 for mean and st, 1 for subject, 1 for activity and 1 for data)

datams<-select(data, 
               subject, 
               data, 
               activity, 
               contains("mean"), 
               contains("std"), 
               -contains("meanFreq"), 
               -contains("angle"))

### We add descriptive activity names to name the activities in the data set

datams$activity<-factor(datams$activity, 
                        levels = c(1,2,3,4,5,6), 
                        labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", 
                                   "SITTING", "STANDING", "LAYING" ))

### Appropriately labels the data set with descriptive variable names
# For the variables names I replaced the "-" and deleted the "()". 
# Because the variables are very specific estimations, it's important to keep all the necessary 
# information to be able to identify each variable. 

# replace the "()" by ""

names(datams)<-gsub("\\(\\)", "", names(datams))

# replace "-" by "_"

names(datams)<-gsub("-","_", names(datams))
names(datams)


### From the data set in step 4, we create a second independent tidy data set with
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



III. Description of the variables

Dataset: data_humanact_avg.txt

subject 		integer
	Volunteers for the experiment between 19-48 years 
	1	subject 1
	2	subject 2
	3	subject 3
	4 	subject 4
	5	subject 5
	6	subject 6
	7	subject 7
	8	subject 8
	9 	subject 9
	10	subject 10
	11	subject 11
	12	subject 12
	13	subject 13
	14 	subject 14
	15	subject 15
	16	subject 16
	17	subject 17
	18	subject 18
	19	subject 19
	20	subject 20
	21	subject 21
	22	subject 22
	23	subject 23
	24 	subject 24
	25	subject 25
	26	subject 26
	27	subject 27
	28	subject 28
	29	subject 29
	30	subject 30

activity 		factor
	Activity performed by each person
	WALKING			
	WALKING_UPSTAIRS		
	WALKING_DOWNSTAIRS	
	SITTING			
	STANDING			
	LAYING			

tBodyAcc_mean_X			numeric
	Average by subject and activity of the mean value for body acceleration time signals in X direction

tBodyAcc_mean_Y 		numeric
	Average by subject and activity of the mean value for body acceleration time signals in Y direction

tBodyAcc_mean_Z 		numeric
	Average by subject and activity  of the mean value for body acceleration time signals in Z direction

tGravityAcc_mean_X		numeric
	Average by subject and activity of the mean value for gravity acceleration time signals in X direction

tGravityAcc_mean_Y		numeric
	Average by subject and activity of the mean value for gravity acceleration time signals in Y direction

tGravityAcc_mean_Z		numeric
	Average by subject and activity of the mean value for gravity acceleration time signals in Z direction

tBodyAccJerk_mean_X		numeric
	Average by subject and activity of the mean value for acceleration Jerk time signals in X direction

tBodyAccJerk_mean_Y		numeric
	Average by subject and activity of the mean value for acceleration Jerk time signals in Y direction

tBodyAccJerk_mean_Z		numeric
	Average by subject and activity of the mean value for acceleration Jerk time signals in Z direction

tBodyGyro_mean_X		numeric
	Average by subject and activity of the mean value for body gyro time signals in X direction

tBodyGyro_mean_Y		numeric
	Average by subject and activity of the mean value for body gyro time signals 
	in Y direction

tBodyGyro_mean_Z		numeric
	Average by subject and activity of the mean value for body gyro time signals in Z direction

tBodyGyroJerk_mean_X		numeric
	Average by subject and activity of the mean value for body gyro jerk time signals  in X direction

tBodyGyroJerk_mean_Y		numeric
	Average by subject and activity of the mean value for body gyro jerk time signals in Y direction

tBodyGyroJerk_mean_Z		numeric
	Average by subject and activity of the mean value for body gyro jerk time signals in Z direction

tBodyAccMag_mean		numeric
	Average by subject and activity of the mean value for body acceleration and magnitude time signals

tGravityAccMag_mean		numeric
	Average by subject and activity of the mean value for gravity acceleration and magnitude time signals

tBodyAccJerkMag_mean		numeric
	Average by subject and activity of the mean value for body acceleration jerk and magnitude time signals

tBodyGyroMag_mean		numeric
	Average by subject and activity of the mean value for body gyro magnitude time signals

tBodyGyroJerkMag_mean		numeric
	Average by subject and activity of the mean value for body gyro jerk and magnitude time signals

fBodyAcc_mean_X			numeric
	Average by subject and activity of the mean value for body acceleration frequency signals in X direction
 
fBodyAcc_mean_Y			numeric
	Average by subject and activity of the mean value for body acceleration frequency signals in Y direction

fBodyAcc_mean_Z 		numeric
	Average by subject and activity of the mean value for body acceleration frequency signals in Z direction

fBodyAccJerk_mean_X		numeric
	Average by subject and activity of the mean value for body acceleration jerk frequency signals in X direction
	
fBodyAccJerk_mean_Y		numeric
	Average by subject and activity of the mean value for body acceleration jerk frequency signals in Y direction

fBodyAccJerk_mean_Z		numeric
	Average by subject and activity of the mean value for body acceleration jerk frequency signals in Z direction

fBodyGyro_mean_X		numeric
	Average by subject and activity of the mean value for body gyro frequency signals in X direction

fBodyGyro_mean_Y		numeric
	Average by subject and activity of the mean value for body gyro frequency signals in Y direction

fBodyGyro_mean_Z		numeric
	Average by subject and activity of the mean value for body gyro frequency signals in Z direction

fBodyAccMag_mean		numeric
	Average by subject and activity of the mean value for body acceleration and magnitude frequency signals

fBodyBodyAccJerkMag_mean	numeric
	Average by subject and activity of the mean value for body acceleration jerk magnitude for frequency signals

fBodyBodyGyroMag_mean		numeric
	Average by subject and activity of the mean value for body gyro and magnitude frequency signals

fBodyBodyGyroJerkMag_mean	numeric
	Average by subject and activity of the mean value for body gyro jerk magnitude frequency signals

tBodyAcc_std_X			numeric
	Average by subject and activity of the standard deviation for body acceleration time signals in X direction

tBodyAcc_std_Y			numeric
	Average by subject and activity of the standard deviation for body acceleration time signals in X direction

tBodyAcc_std_Z			numeric
	Average by subject and activity of the standard deviation for body acceleration time signals in Z direction

tGravityAcc_std_X		numeric
	Average by subject and activity of the standard deviation for gravity acceleration time signals in X direction

tGravityAcc_std_Y		numeric
	Average by subject and activity of the standard deviation for gravity acceleration time signals in Y direction 

tGravityAcc_std_Z		numeric
	Average by subject and activity of the standard deviation for gravity acceleration time signals in Z direction

tBodyAccJerk_std_X		numeric
	Average by subject and activity of the standard deviation for body acceleration jerk time signals in X direction

tBodyAccJerk_std_Y		numeric
	Average by subject and activity of the standard deviation for body acceleration jerk time signals in Y direction

tBodyAccJerk_std_Z		numeric
	Average by subject and activity of the standard deviation for body acceleration jerk time signals in Z direction

tBodyGyro_std_X			numeric
	Average by subject and activity of the standard deviation for body gyro time signals in X direction

tBodyGyro_std_Y			numeric
	Average by subject and activity of the standard deviation for body gyro time signals in Y direction

tBodyGyro_std_Z			numeric
	Average by subject and activity of the standard deviation for body gyro time signals in Z direction

tBodyGyroJerk_std_X		numeric
	Average by subject and activity of the standard deviation for body gyro jerk signals in X direction

tBodyGyroJerk_std_Y		numeric
	Average by subject and activity of the standard deviation for body gyro jerk signals Y direction

tBodyGyroJerk_std_Z		numeric
	Average by subject and activity of the standard deviation for body gyro jerk signals in Z direction

tBodyAccMag_std			numeric
	Average by subject and activity of the standard deviation for body acceleration and magnitude time signals 

tGravityAccMag_std		numeric
	Average by subject and activity of the standard deviation for gravity acceleration and magnitude time signals

tBodyAccJerkMag_std		numeric
	Average by subject and activity of the standard deviation for body acceleration jerk and magnitude time signals

tBodyGyroMag_std		numeric
	Average by subject and activity of the standard deviation for body gyro and magnitude time signals
	
tBodyGyroJerkMag_std		numeric	
	Average by subject and activity of the standard deviation for body gyro jerk and magnitude time signals
	
fBodyAcc_std_X			numeric
	Average by subject and activity of the standard deviation for body acceleration frequency signals in X direction

fBodyAcc_std_Y			numeric
	Average by subject and activity of the standard deviation for body acceleration frequency signals in Y direction

fBodyAcc_std_Z			numeric
	Average by subject and activity of the standard deviation for body acceleration frequency signals in Z direction

fBodyAccJerk_std_X		numeric
	Average by subject and activity of the standard deviation for body acceleration jerk frequency signals in X direction

fBodyAccJerk_std_Y		numeric
	Average by subject and activity of the standard deviation for body acceleration jerk frequency signals Y direction

fBodyAccJerk_std_Z		numeric
	Average by subject and activity of the standard deviation for body acceleration jerk frequency signals in Z direction

fBodyGyro_std_X			numeric
	Average by subject and activity of the standard deviation for body gyro frequency signals in X direction

fBodyGyro_std_Y			numeric
	Average by subject and activity of the standard deviation for body gyro frequency signals in Y direction

fBodyGyro_std_Z			numeric
	Average by subject and activity of the standard deviation for body gyro frequency signals in Z direction

fBodyAccMag_std			numeric
	Average by subject and activity of the standard deviation for body acceleration and magnitude frequency signals

fBodyBodyAccJerkMag_std	numeric	
	Average by subject and activity of the standard deviation for body acceleration jerk and magnitude frequency signals

fBodyBodyGyroMag_std		numeric
	Average by subject and activity of the standard deviation for body gyro and magnitude frequency signals

fBodyBodyGyroJerkMag_std	numeric
	Average by subject and activity of the standard deviation for body gyro jerk and magnitude frequency signals

