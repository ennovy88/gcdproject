Getting and Cleaning Data Course Project

This course project includes the following files:
=============================================
- 'README.md'

- 'run_analysis.R': Script that tidies the Human Activity Recognition Using Smartphones 
Data set input. The script merges the training and test sets into one data set, then 
extracts only the measurements on the mean and standard deviation for each measurement. 
Then the script tidies the merged data. Finally, an output, an independent tidy data set, 
"tidymean.txt", is created to show the average of each variable for each activity and 
each subject. For more detail, see comments in the script.

- 'CodeBook.md': Describes variables in data set, the experimental study design and 
transformation of the data.

Notes:
======
- The run_analysis.R script will require the following data set input saved in the working
directory.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support 
Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012
