# CodeBook
The features selected for this database originate from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation

## Transformations
The data from the original data set, found in (X_test.txt and X_train.txt) has been summarized 
in this tidy.txt dataset.  The summarization was performed by first excluding all measurements 
that were not using either a standard deviation or a mean.  The data was then grouped by 
the subject ID and by the activity that the subject was performing.  An average was then taken of
all the measurements based on this grouping.

## Categorical Data

- Tidy Column 1: **subject_id**:  A number from 1-30 identifying each volunteer in the study.
- Tidy Column 2: **activity_name**: A string describing which of 6 possible activities the volunteer was performing.

        activity names can be one of the following values:
                 
        - WALKING
        - WALKING_UPSTAIRS
        - WALKING_DOWNSTAIRS
        - SITTING
        - STANDING
        - LAYING


## Observational Data
The tidy data set will contain the mean of all related observations from the 
source data sets (X_test.txt and X_train.txt).

- Tidy Column 3 | Source Column: 4 |  **tBodyAcc-std()-X**
- Tidy Column 4 | Source Column: 5 |  **tBodyAcc-std()-Y**
- Tidy Column 5 | Source Column: 6 |  **tBodyAcc-std()-Z**
- Tidy Column 6 | Source Column: 44 |  **tGravityAcc-std()-X**
- Tidy Column 7 | Source Column: 45 |  **tGravityAcc-std()-Y**
- Tidy Column 8 | Source Column: 46 |  **tGravityAcc-std()-Z**
- Tidy Column 9 | Source Column: 84 |  **tBodyAccJerk-std()-X**
- Tidy Column 10 | Source Column: 85 |  **tBodyAccJerk-std()-Y**
- Tidy Column 11 | Source Column: 86 |  **tBodyAccJerk-std()-Z**
- Tidy Column 12 | Source Column: 124 |  **tBodyGyro-std()-X**
- Tidy Column 13 | Source Column: 125 |  **tBodyGyro-std()-Y**
- Tidy Column 14 | Source Column: 126 |  **tBodyGyro-std()-Z**
- Tidy Column 15 | Source Column: 164 |  **tBodyGyroJerk-std()-X**
- Tidy Column 16 | Source Column: 165 |  **tBodyGyroJerk-std()-Y**
- Tidy Column 17 | Source Column: 166 |  **tBodyGyroJerk-std()-Z**
- Tidy Column 18 | Source Column: 202 |  **tBodyAccMag-std()**
- Tidy Column 19 | Source Column: 215 |  **tGravityAccMag-std()**
- Tidy Column 20 | Source Column: 228 |  **tBodyAccJerkMag-std()**
- Tidy Column 21 | Source Column: 241 |  **tBodyGyroMag-std()**
- Tidy Column 22 | Source Column: 254 |  **tBodyGyroJerkMag-std()**
- Tidy Column 23 | Source Column: 269 |  **fBodyAcc-std()-X**
- Tidy Column 24 | Source Column: 270 |  **fBodyAcc-std()-Y**
- Tidy Column 25 | Source Column: 271 |  **fBodyAcc-std()-Z**
- Tidy Column 26 | Source Column: 348 |  **fBodyAccJerk-std()-X**
- Tidy Column 27 | Source Column: 349 |  **fBodyAccJerk-std()-Y**
- Tidy Column 28 | Source Column: 350 |  **fBodyAccJerk-std()-Z**
- Tidy Column 29 | Source Column: 427 |  **fBodyGyro-std()-X**
- Tidy Column 30 | Source Column: 428 |  **fBodyGyro-std()-Y**
- Tidy Column 31 | Source Column: 429 |  **fBodyGyro-std()-Z**
- Tidy Column 32 | Source Column: 504 |  **fBodyAccMag-std()**
- Tidy Column 33 | Source Column: 517 |  **fBodyBodyAccJerkMag-std()**
- Tidy Column 34 | Source Column: 530 |  **fBodyBodyGyroMag-std()**
- Tidy Column 35 | Source Column: 543 |  **fBodyBodyGyroJerkMag-std()**
- Tidy Column 36 | Source Column: 1 |  **tBodyAcc-mean()-X**
- Tidy Column 37 | Source Column: 2 |  **tBodyAcc-mean()-Y**
- Tidy Column 38 | Source Column: 3 |  **tBodyAcc-mean()-Z**
- Tidy Column 39 | Source Column: 41 |  **tGravityAcc-mean()-X**
- Tidy Column 40 | Source Column: 42 |  **tGravityAcc-mean()-Y**
- Tidy Column 41 | Source Column: 43 |  **tGravityAcc-mean()-Z**
- Tidy Column 42 | Source Column: 81 |  **tBodyAccJerk-mean()-X**
- Tidy Column 43 | Source Column: 82 |  **tBodyAccJerk-mean()-Y**
- Tidy Column 44 | Source Column: 83 |  **tBodyAccJerk-mean()-Z**
- Tidy Column 45 | Source Column: 121 |  **tBodyGyro-mean()-X**
- Tidy Column 46 | Source Column: 122 |  **tBodyGyro-mean()-Y**
- Tidy Column 47 | Source Column: 123 |  **tBodyGyro-mean()-Z**
- Tidy Column 48 | Source Column: 161 |  **tBodyGyroJerk-mean()-X**
- Tidy Column 49 | Source Column: 162 |  **tBodyGyroJerk-mean()-Y**
- Tidy Column 50 | Source Column: 163 |  **tBodyGyroJerk-mean()-Z**
- Tidy Column 51 | Source Column: 201 |  **tBodyAccMag-mean()**
- Tidy Column 52 | Source Column: 214 |  **tGravityAccMag-mean()**
- Tidy Column 53 | Source Column: 227 |  **tBodyAccJerkMag-mean()**
- Tidy Column 54 | Source Column: 240 |  **tBodyGyroMag-mean()**
- Tidy Column 55 | Source Column: 253 |  **tBodyGyroJerkMag-mean()**
- Tidy Column 56 | Source Column: 266 |  **fBodyAcc-mean()-X**
- Tidy Column 57 | Source Column: 267 |  **fBodyAcc-mean()-Y**
- Tidy Column 58 | Source Column: 268 |  **fBodyAcc-mean()-Z**
- Tidy Column 59 | Source Column: 345 |  **fBodyAccJerk-mean()-X**
- Tidy Column 60 | Source Column: 346 |  **fBodyAccJerk-mean()-Y**
- Tidy Column 61 | Source Column: 347 |  **fBodyAccJerk-mean()-Z**
- Tidy Column 62 | Source Column: 424 |  **fBodyGyro-mean()-X**
- Tidy Column 63 | Source Column: 425 |  **fBodyGyro-mean()-Y**
- Tidy Column 64 | Source Column: 426 |  **fBodyGyro-mean()-Z**
- Tidy Column 65 | Source Column: 503 |  **fBodyAccMag-mean()**
- Tidy Column 66 | Source Column: 516 |  **fBodyBodyAccJerkMag-mean()**
- Tidy Column 67 | Source Column: 529 |  **fBodyBodyGyroMag-mean()**
- Tidy Column 68 | Source Column: 542 |  **fBodyBodyGyroJerkMag-mean()**
