#ReadMe

This is a project to clean the data from the Human Activity Recognition Using Smartphones Dataset.

The experiment had 30 volunteers perform various activities while wearing a Samsung Galaxy SII smartphone on the waist. 

The gyroscope and accelerometer data from the phones was recorded and various measurments for time and frequency domain signals were calculated. 

##After cleaning

After cleaning the data we have a table that contains the averages of the mean and standard deviation of various measurements grouped by the subject/volunteer Id and the activity they were performing.

The process used to clean the data is described in the comments of the r script

##List of files
run_analysis.r : The r script used to clean the data. Commented for clarity

TidyDataAfterStep5.txt : The final dataset

CodeBook.md : A description of the variables in the final dataset

UCI HAR Dataset: The original dataset. Please check for more details on the projects and contacts to the original authors.
