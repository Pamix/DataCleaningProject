
==================================================================
Getting and Cleaning Data Course Project
Johns Hopkins University - Coursera
Assignment 
Pamela Escobar
==================================================================

This Dataset contains the average by subject and activity of the mean value and standard deviation of the Dataset Human Activity Recognition Using Smartphones (Version 1.0) [1]

The original dataset includes the following files:
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The original dataset contains 10,299 observations and 564 variables, (2,947 observations from the test set and 7,352 observations from the training set). 
Because in this dataset we are only including the average for each subject and each activity of the mean values and standard deviations of all the estimations, this dataset contains 180 observations and 68 variables:

- 33 variables of the mean values of the estimations 
- 33 variables of the standard deviation of the estimations 
- 1 variable to identify the subjects 
- 1 variable for the activities
- 180 observations = 30 subjects * 6 activities 

See CodeBook.md for more details of each variable and the repository Getting and Cleaning Data Course Project, for all the details of how to prepare the dataset.

For reading and viewing the dataset in R:

- Download the dataset and save it in the working directory
- Use the following instruction in R  to read and view the dataset

data<-read.table(“./data_humanact_avg.txt”, header=TRUE)
View(data)



[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.

Notes: 
- Features from the original dataset are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
- For a full description of the project see: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones