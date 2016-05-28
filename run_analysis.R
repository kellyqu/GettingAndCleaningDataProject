##########################################################################
## 0. pre-steps to set working directory and download file			##
##########################################################################

## switch to my working dir "C:\data\RProgramming\cert2\week4\project" (windows 7 as OS)

## setwd("C:/data/RProgramming/cert2/week4/project")

## assuming this file is downloaded for the first time
## download the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="./Cert2Week4Project.zip")

## unzip the file and keep it in the same working directory
## as a result, this folder "UCI HAR Dataset" is created under the current dir
unzip("Cert2Week4Project.zip") 

##########################################################################
## 1. read data in and merge test and train datasets 				##
##########################################################################
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_act <- read.table("./UCI HAR Dataset/test/Y_test.txt")
test_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")

train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_act <- read.table("./UCI HAR Dataset/train/Y_train.txt")
train_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#stack test_data and train_data up in rows
datacombined <- rbind(test_data, train_data)

#stack test and train activities up in rows
activties <- rbind(test_act, train_act)

#stack test and train subjects up in rows
subjects <- rbind(test_sub, train_sub)

##########################################################################
## 2. extract only the measurements of -mean() and -std()			##			
##########################################################################

features <- read.table("./UCI HAR Dataset/features.txt")

## this reg expression will prevent in case functions like meantest(), or testmean()
featuresSelected <- grep("-(mean|std)\\(\\)", features[, 2])

##subset combined data with only interested mean and std functions
dataSelected <- datacombined[, featuresSelected]

## give column names with matached selected features 
names(dataSelected) <- features[featuresSelected, 2]

##########################################################################
## 3. Uses descriptive activity names  in the data set			##
##########################################################################

actLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## create data frame with activity lables
activties[, 1] <- actLabels[activties[, 1], 2]



##########################################################################
## 4.	Appropriately labels the data set with descriptive variable names.##				
##########################################################################

#give names to both columns

names(activties) <- "activity"
names(subjects) <- "subject"

#bind all columns togehter

finalData <- cbind(dataSelected, activties, subjects)


##########################################################################
## 5. From step 4 data set, creates a second, independent tidy data 	##
## set with the average of each variable for each activity and subject. ##
##########################################################################

library(reshape2)
finalData.melted <- melt(finalData, id = c("subject", "activity"))
finalData.mean <- dcast(finalData.melted, subject + activity ~ variable, mean)

write.table(finalData.mean, "mytidy.txt", row.name=FALSE)



