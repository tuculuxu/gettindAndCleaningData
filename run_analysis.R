load.packages <- function(){
        library(dplyr)
}

## Reads train and test tables, merges both into one unique table, keeping 
## track of the "train" and "test" information and names appropriately
## the variables (taking care of duplicates at the same time)
## Note: this function uses the subfunction 
## (Questions 1 and 4)

getMergeData <- function(){
#we check that the zip file is in the current directory
        if(!"getdata_projectfiles_UCI HAR Dataset.zip" %in% list.files()){
                stop("The zip file is not in the current directory")
        }
        unzip(zipfile = "getdata_projectfiles_UCI HAR Dataset.zip")
        # loads features
        features <- read.table("UCI HAR Dataset/features.txt")
        # creates a dataTable for training
        X <- read.table("UCI HAR Dataset/train/X_train.txt")
        Y <- read.table("UCI HAR Dataset/train/y_train.txt")
        train <- mergeTwoTables(x =X, y = Y, 
                                headers = features, 
                                origin = "train")
        
        #creates a dataTable for testing
        X <- read.table("UCI HAR Dataset/test/X_test.txt")
        Y <- read.table("UCI HAR Dataset/test/y_test.txt")
        test <- mergeTwoTables(x = X, y = Y, 
                               headers = features, 
                               origin = "test")
        
        #merges the two dataTables into one
        rbind(train, test)
}

## Merges two data.frames, names the columns appropriately 
## and adds a column to keep track of the origin of the data

mergeTwoTables <- function(x, y, headers, origin){
        colnames(x) = make.names(headers[,2], unique = TRUE)
        names(y) <- c("activity")
        y <- mutate(y, origin = origin)
        cbind(x,y)

}

## Extracts columns that contain mean or std and origin and labels
## (Question 2)

extractMeanSD <- function(data){
        subData <- select(data, activity, origin)
        subMean <- select(data, contains("mean"))
        subStd <- select(data, contains("std"))
        cbind(subData, subMean, subStd)

}

## Changes labels to human readable labels 
## (Question 3)

nameActivities <- function(data){
        activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
        data$activity <- factor(x = data$activity, 
                             levels = activityLabels[,1], 
                             labels = activityLabels[,2])
        data
}

## The function that does the first four requirements

 tidyThisData <- function(){
        load.packages()
        mergedData <- getMergeData()
        meanSD <- extractMeanSD(mergedData)
        nameActivities(meanSD)
}

## Averages each subject for each activity in the dataset

averageDataSet <- function(data){
        groupActivity <- group_by(data, activity)
        summarise_each(groupActivity, funs(mean), -origin)
}

## The 5 questions at the same time

run_analysis <- function(){
        tidyData <- tidyThisData()
        averageDataSet(tidyData)
}