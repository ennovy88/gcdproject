## Getting and Cleaning Data Course Project
####################################################################

## Loading the dependent packages for this script
library(dplyr)
library(plyr)
library(data.table)
 
## STEP 0
## Reading and storing txt data files in data frames. Assumes that dataset is in
## working directory and has been unzipped, with no changes to the file name.
##
#####################################################################

## Reads data (in txt files) into tables in R and adds a column name for the
## activity and subject id tables for each train and test sets

train_set <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_actlabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
names(train_actlabel) <- "activity"
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(train_subject) <- "subject"

test_set <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_actlabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
names(test_actlabel) <- "activity"
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(test_subject) <- "subject"

## Reads features and activity type data into a table and converts 
## the features and activity types from factor to character for easier
## tidying later.

vartab <- read.table("./UCI HAR Dataset/features.txt")
vartab$V2 <- as.character(vartab$V2)

acttab <- read.table("./UCI HAR Dataset/activity_labels.txt")
acttab$V2 <- as.character(acttab$V2)

## STEP 1
## Merge the training and the test sets to create one data set.
##
#####################################################################

## Merges subject ids and activity labels to each data set (train, test) 
## and stores each a data frame 

train_ds <- cbind(train_subject, train_actlabel, train_set)
test_ds <- cbind(test_subject, test_actlabel, test_set)

## Merges training and test data frames and arranges merged data set by 
## subject id and then  activity

merged_ds <- arrange(merge(train_ds, test_ds, all=TRUE), subject, activity)

## STEP 2
## Extract only the measurements on the mean and standard deviation  
## for each measurement.
##
#####################################################################

## This part searches through the list of the features to find names with mean() 
## or std() in the name and stores the indices that match this criteria

keepm <- grep("mean()", vartab$V2)
keeps <- grep("std()", vartab$V2)

## Capturing the list of features indices in original order since the merged 
## data frame includes the activity and subject columns in the first two columns.

originalvindex <- sort(c(keepm, keeps))

## Updating the indices of the features to match the merged data frame.

keep <- c(keepm, keeps)  + 2

## Vector containing the extracted column indices which contain the desired 
## information. 1 and 2 are activity and subject, respectively.

selectedcols  <- sort(c(1,2,keep))

## Capturing the selected feature names from the table of features.
varnames <- vartab[originalvindex, 2]

## Subsetting merged data to get subset of the features with mean or standard
## deviation measurements
subset <- merged_ds [, selectedcols]

## STEP 3
## Use descriptive activity names to name the activities in the data set
##
#####################################################################

## Gsub replaces numbers in the activity column with corresponding 
## activity name based on the table of activities.
 
subset$activity <- gsub("1", acttab$V2[1], subset$activity)
subset$activity <- gsub("2", acttab$V2[2], subset$activity)
subset$activity <- gsub("3", acttab$V2[3], subset$activity)
subset$activity <- gsub("4", acttab$V2[4], subset$activity)
subset$activity <- gsub("5", acttab$V2[5], subset$activity)
subset$activity <- gsub("6", acttab$V2[6], subset$activity)	

## Tidying: Make activity labels lowercase and factor class.
subset$activity <- tolower(subset$activity) %>% as.factor

## STEP 4
## Label the data set with descriptive variable names.
##
#####################################################################

## Labeling the columns
names(subset) <- c("subject", "activity", varnames)

## Some tidying: 
## Removing parenthesis and dashes from variable names.
## Did not use tolower function on variable names in order to 
## keep it easier to read/parse the measurement names

names(subset) <- gsub("()","", names(subset), fixed=TRUE) 
names(subset) <- gsub("-","", names(subset), fixed=TRUE) 

## Storing final, tidied, extracted data set into a new variable 
tidydata <- subset

## STEP 5
## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
##
#####################################################################

## Splits the tidy data in step 4 by activity and subject pair.
## Result is a list of 180 data frames with the observed measurements for
## each feature under each activity-subject pairing (6 activities x 
## 30 subjects). Column names in each data frame remain the same as data in step 4 
## (subject, activity, features.)

by_as <- split(tidydata, list(tidydata$activity, tidydata$subject))

## Using the split data frames, calculates the averages of the values in 
## each set of feature columns and saves it to a new matrix. 
## In this resulting matrix, the first column contains the features, followed 
## by 180 activity and subject pairings (these columns are contain an activity
## a subject separated by a period, i.e. "sitting.25"). 

means_data <- sapply(by_as, function(x) {colMeans(x[,3:81])})

## Converts the matrix into a data table, while making sure that the row names
## (features) are kept.

means_data <- as.data.table(means_data, keep.rownames="variable")

## Tidying the new table which contains the averages of each feature 
## (by activity and by subject). 

## Separates the activity-subject column names by period. Each activity.subject
## column contains two parts (activity, subject) instead of one part ("activity.subject").
splitNames <- strsplit(names(means_data), "\\.")

## Initializing new vectors to store the activity, subject id, feature name
## and average value of the feature (by activity and subject id).

activity <- vector("character")
subjectid <- vector("integer")
feature <- vector ("character")
average <- vector ("numeric")

## Capturing how many rows and columns are in the table with average values
nr <- nrow(means_data)
nc <- ncol(means_data)

## Goes through each row and each column to extract the activity, subject id,
## feature and average value from the table.

for ( r in 1:nr)  {
	for ( c in 2:nc ) {
		splitIndex <- 1
		activity <- c(activity, splitNames[[c]] [splitIndex])
		splitIndex <- 2
		subjectid <- c(subjectid, splitNames [[c]] [splitIndex])
		feature <- c(feature, means_data$variable[r])
		average <- c(average, means_data [[r,c]])
		}
	}

## Column binds the separated data into a data frame, and arranges by
## activity and subject id.
tidymean <- cbind(activity, subjectid, feature, average) %>%		
 			as.data.frame %>%
 			arrange(activity, subjectid)

## Saves the tidy, table of averages to a txt file. 			
write.table(tidymean, file="tidymean.txt", row.names=FALSE)