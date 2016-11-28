#STEP 1 : Merge all of the data sets to create one combined training and testing dataset

#reading all of the relevant files to the memory
accessdir <- "UCI HAR Dataset"
activitylabels <- read.table(paste(accessdir,"activity_labels.txt",sep = "/"))
features <- read.table(paste(accessdir,"features.txt",sep = "/"))
testsubjects <- read.table(paste(accessdir,"test/subject_test.txt",sep = "/"))
testdata <- read.table(paste(accessdir,"test/X_test.txt",sep = "/"))
testactivities <- read.table(paste(accessdir,"test/y_test.txt",sep = "/"))
trainsubjects <- read.table(paste(accessdir,"train/subject_train.txt",sep = "/"))
traindata <- read.table(paste(accessdir,"train/X_train.txt",sep = "/"))
trainactivities <- read.table(paste(accessdir,"train/y_train.txt",sep = "/"))

#combine all the activity rows. be careful to have training first and test later to ensure correct combination later
allactivities <- rbind(trainactivities,testactivities)
#name the column
names(allactivities) <- "activity"

#combine all the subject rows
allsubjects <- rbind(trainsubjects,testsubjects)
#name the column
names(allsubjects) <- "subjectId"

#combine all the data
alldata <- rbind(traindata,testdata)
#name the data using the feature names in the features variable
names(alldata) <- features$V2

#STEP 2 : Extract all the mean and std variables to a new table from the combined data
alldatasubset <- alldata[grepl("-(mean|std)\\()",names(alldata))]

#compile subjects, activities and subset of mean and std variables to a new table
compiledtable <- cbind(allsubjects,allactivities,alldatasubset)

#STEP 3 : Use activity names instead of numbers to describe the activites in the compiled table
labels <- activitylabels$V2
compiledtable$activity <- labels[compiledtable$activity]

#STEP 4: Label the variables with appropriate and descriptive variable names 
names(compiledtable) <- gsub("^t","Time",names(compiledtable))
names(compiledtable) <- gsub("^f","Frequency",names(compiledtable))
names(compiledtable) <- gsub("-","",names(compiledtable))
names(compiledtable) <- gsub("\\()","",names(compiledtable))
names(compiledtable) <- gsub("mean","Mean",names(compiledtable))
names(compiledtable) <- gsub("std","Std",names(compiledtable))
names(compiledtable) <- gsub("BodyBody","Body",names(compiledtable))

#Step 5: Find the average of each variable grouped by subjectId and activity
library(dplyr)

#group data by subjectId and activity
avset <- group_by(compiledtable,subjectId,activity)
#find average for each subjectId and activity combination
avset <- summarise_each(avset,funs(mean))
#assign appropriate names to the variables 
names(avset)[-(1:2)]<- gsub("^","averageOf",names(avset)[-1:-2])

#write the final dataset to memory
write.table(avset,file="TidyDataAfterStep5.txt",row.names = FALSE)
