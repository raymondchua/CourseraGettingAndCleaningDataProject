#Cleaning and Tidying of Human Activity Recognition Using Smartphones Data Set

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.


The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

My approach: 
=========================================
##Step 1
I begin by reading the datasets(X\_test, y_test, X\_train, y\_train, subject\_test, subject\_train) using read.table command. The X data table and the y data table are then merged using the rbind() and cbind() command. I called the merged table, "mydata". 

##Step 2
In order to extract the only data that we need(ie. mean and standard deviation columns), I first name all the variables using the names that I have got from "features.txt". The columns that have mean or std in their names are then selected using the grep command. Lastly, the names are tidied up to remove "-",  replacing "t" with "time", "f" with "frequency", "BodyBody" with "Body", "mean" with "Mean" and "std" with "Std." The gsub command is used to perform these tasks. 

##Step 3
Next, I have to replaced the "Activity" column that is represented using a numeric value to a descriptive value based on the information given in the activity_labels.txt. First column is the numeric representation followed by the descriptive value on the second column.

- 1 WALKING
- 2 WALKING_UPSTAIRS
- 3 WALKING_DOWNSTAIRS
- 4 SITTING
- 5 STANDING
- 6 LAYING

##Step 4
We are then required to labels the data set with descriptive variable names. I named the first column as "Subject" and the second column as "Activity".

##Step 5
Lastly, I wrote a new function to calculate colMeans of a given data table. This function is used in the ddply command with the Subject and Activity acting as ID. The export is done using a write.table command with the row.names set to false.
