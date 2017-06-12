The Code Book for Getting and Cleaning Data Course Project's run_analysis.R

This codebook describes variables in data set, the experimental study design and 
transformation of the data.
========================================================================================

1. Experimental study design 

The run_analysis.R script tidies Version 1 of the Human Activity Recognition Using 
Smart Phones Dataset (UCI HAR Dataset). This data was collected by Jorge L. Reyes-Ortiz, 
Davide Anguita, Alessandro Ghio, Luca Oneto from Smartlab, Non-Linear Complex Systems
Laboratory DITEN at the University degli Studi di Genova in Genoa, Italy.

A group of 30 volunteers (within ages 19-48) participated in this experiment. Each person 
performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, 
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its 
embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial 
angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to 
label the data manually. The obtained dataset has been randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the 
test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise 
filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap 
(128 readings/window). The sensor acceleration signal, which has gravitational and body 
motion components, was separated using a Butterworth low-pass filter into body 
acceleration and gravity. The gravitational force is assumed to have only low frequency 
components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, 
a vector of features was obtained by calculating variables from the time and frequency 
domain.
========================================================================================

2. Variables and units

activity
=======
    Activity performed by the volunteer to collect this data.
    1 WALKING
    2 WALKING_UPSTAIRS
    3 WALKING_DOWNSTAIRS
    4 SITTING
    5 STANDING
    6 LAYING
NOTE:
run.analysis.R will transform these activity names into lower case for easier access.
The underscore is not removed to keep readability of the walking upstairs and walking
downstairs.
    
subjectid
=======
    Unique identifier assigned to each volunteer (number ranges between 1-30).
    
feature
========
Each feature name contains three components, a prefix, signal, and variable.

1. Prefix 't' denotes time domain signals, while prefix 'f' denotes frequency domain signals.

2. Signals
The acceleration signal is separated into body and gravity acceleration signals 
(tBodyAcc-XYZ and tGravityAcc-XYZ). 

Subsequently, the body linear acceleration and angular velocity were derived in time to 
obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 

Also the magnitude of these three-dimensional signals were calculated using the Euclidean 
norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing 
fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, 
fBodyGyroJerkMag.

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

3. The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are 
used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

NOTE:
- In this data set, the values for each combination are normalized and bounded within [-1,1]. 
- Run_analysis.R extracts only the signal variables that measure mean (mean() and meanFreq()) 
and standard deviation (std()). In the tidying the data, the "()" are removed, while the
capitalization is not transformed as it helps with readability of the features.

- See features.txt in downloaded data set for full list of the signal-variable combinations.
- For more information on features, see features_info.txt in the downloaded data set.

average
=======
    This is a numeric average of the observations in each of the 180 unique activity-
    subject-feature pairings.
    
    For features with a t-prefix, the average is in time units.
    For feaures with a f-prefix, the average is in frequency units.


 

  
    

