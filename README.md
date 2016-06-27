> getwd()
[1] "D:/R/coursera/3 Getting and cleaning data/Week4"

##Loading necessary libraries-data.table and dplyr

> library(data.table)
data.table 1.9.6  For help type ?data.table or https://github.com/Rdatatable/data.table/wiki
The fastest way to learn (by data.table authors): https://www.datacamp.com/courses/data-analysis-the-data-table-way
Warning message:
package ‘data.table’ was built under R version 3.2.5 
> library(dplyr)

Attaching package: ‘dplyr’

The following objects are masked from ‘package:data.table’:

    between, last

The following objects are masked from ‘package:stats’:

    filter, lag

The following objects are masked from ‘package:base’:

    intersect, setdiff, setequal, union

Warning message:
package ‘dplyr’ was built under R version 3.2.5 

##Reading training and test tables using read.table function for fast loading

> featureNames <- read.table("UCI HAR Dataset/features.txt")
> activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
> subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
> activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
> featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
> subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
> activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
> featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

##Binding rows of test and train data

> subject <- rbind(subjectTrain, subjectTest)
> activity <- rbind(activityTrain, activityTest)
> features <- rbind(featuresTrain, featuresTest)

##adding column names

> colnames(features) <- t(featureNames[2])
> colnames(activity) <- "Activity"
> colnames(subject) <- "Subject"

##Combining columns to complete the dataset

> completeData <- cbind(features,activity,subject)

## Finding mean

> columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
> requiredColumns <- c(columnsWithMeanSTD, 562, 563)
> dim(completeData)
[1] 10299   563
> extractedData <- completeData[,requiredColumns]
> dim(extractedData)
[1] 10299    88
> extractedData <- completeData[,requiredColumns]
> dim(extractedData)
[1] 10299    88

## Adding more appropriate names which are descrptive

> names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
> names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
> names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
> names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
> names(extractedData)<-gsub("^t", "Time", names(extractedData))
> names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
> names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
> names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
> names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
> names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
> names(extractedData)<-gsub("angle", "Angle", names(extractedData))
> names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

> extractedData$Subject <- as.factor(extractedData$Subject)
> extractedData <- data.table(extractedData)

##Creating Tidy data

> tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
> tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]

##Writing to a text file to be pushed to repo
> write.table(tidyData, file = "Tidy.txt", row.names = FALSE)