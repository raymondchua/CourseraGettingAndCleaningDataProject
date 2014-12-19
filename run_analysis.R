#1. Merges the training and the test sets to create one data set.
testXdata = read.table("./UCI HAR Dataset/test/X_test.txt")
testYdata = read.table("./UCI HAR Dataset/test/y_test.txt")
testSubjectdata = read.table("./UCI HAR Dataset/test/subject_test.txt")

trainXdata = read.table("./UCI HAR Dataset/train/X_train.txt")
trainYdata = read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubjectdata = read.table("./UCI HAR Dataset/train/subject_train.txt")

#row merge the X data
mydataX <- rbind(testXdata, trainXdata)

#row merge the Y data
mydataY <- rbind(testYdata, trainYdata)

#row merge the subject data
mydataSubject <- rbind(testSubjectdata, trainSubjectdata)

#merge everything together
mydata <- cbind(mydataX, mydataY)


#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
featuresName = read.table("./UCI HAR Dataset/features.txt")
matches <- grep("mean|std", featuresName[,2])
names(mydata) <- featuresName[,2]
mydata <- mydata[, matches]
names(mydata) <- gsub("\\(\\)", "", names(mydata))
names(mydata) <- gsub("^t", "time", names(mydata))
names(mydata) <- gsub("^f", "frequency", names(mydata))
names(mydata) <- gsub("BodyBody", "Body", names(mydata))
names(mydata) <- gsub("-mean", "Mean", names(mydata))
names(mydata) <- gsub("-std", "Std", names(mydata))
names(mydata) <- gsub("-", "", names(mydata))

#3. Uses descriptive activity names to name the activities in the data set
activityNames <- c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
activities <- activityNames[mydataY[,1]]

#4. Appropriately labels the data set with descriptive variable names. 
dataCleaned <- cbind(Subject = mydataSubject, Activity = activities, mydata)
names(dataCleaned)[1] <- "Subject"
dataCleaned <- dataCleaned[order(dataCleaned$Subject),]

#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
library(reshape)
colMeanFunc <- function(data){
  colMeans(data[,-c(1,2)])
}

finalData <- ddply(dataCleaned, .(Subject, Activity), colMeanFunc)

write.table(finalData, "finalData.txt", sep="\t", row.names=FALSE, col.names=TRUE) 

#check the data exported
data <- read.table("finalData.txt", header = TRUE) #if they used some other way of saving the file than a default write.table, this step will be different
View(data)


