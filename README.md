# GettingAndCleaningDataProject

This code "run_analysis.R" runs based on below pre-conditions

1) working directory exstis - ("C:/data/RProgramming/cert2/week4/project")
2) the zip file is downloaded and unzipped first time

setwd() code is commented out, and is only for your reference.

After the zip file is unzipped on the local folder. The code is do the following to get the final output mytidy.txt file

1.	Merges the training and the test sets 
    read in all datasets, and then
    stack below datasets up in rows with rbind()
    - X_test.txt and X_train.txt rowbinding into "datacombined"; 
    - Y_test.txt and Y_train.txt rowbinding into "activities";
    - subject_test.txt and subject_train.txt rowbinding into "subjects"
    
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
    - read in features.txt file into "features" data table
    - use below regular expression with grep() to include only mean() and std(). Inculded "-" and "()" in the regular expression to exclude functions with mean or std as their partial names.
          grep("-(mean|std)\\(\\)", features[, 2])
    - subset the data for only selected features into "dataSelected"
    - use names() function to add selected feature names as column names
  
3.	Uses descriptive activity names to name the activities in the data set
    - read in activity_labels.txt file for activity lables
    - assign lables to the previously created "activities" data table in step 1
    
4.	Appropriately labels the data set with descriptive variable names.
    - use names() function to give columns names for subject and activity columns.
    - use cbind() - column-binding to combine all columns into the final data set "finalData"
    
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    - use melt and dcast functions in reshape2 library for aggregating means for each actvity and subject on the dataset created in step 4
    - output the file to mytidy.txt using write.table() with row.name = false
    
