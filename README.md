Coursera Getting and Cleaning Data Project
------------------------------------------
This is the repository required for the project due in week 3 of the Coursera 
class, "Getting and Cleaning Data".

The Course Project consists of the following files found in this repository:

- README.md - this file
- CodeBook.md - A detailed description of the solution.
- run_analysis.R - The required R code needed to satisfy the assignment.

The Assignment
--------------
The purpose of this project is to demonstrate your ability to collect, work with,
and clean a data set. The goal is to prepare tidy data that can be used for later
analysis. You will be graded by your peers on a series of yes/no questions related
to the project. You will be required to submit: 

1. A tidy data set as described below.
2. A link to a Github repository with your script for performing the analysis.
3. A code book that describes the variables, the data, and any transformations 
or work that you performed to clean up the data called CodeBook.md. 

You should also include a README.md in the repo with your scripts. This repo 
explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable 
computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/) . Companies like Fitbit, Nike, and 
Jawbone Up are racing to develop the most advanced algorithms to attract new 
users. The data linked to from the course website represent data collected from 
the accelerometers from the Samsung Galaxy S smartphone. A full description is 
available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!

Prerequisites for running the Script
------------------------------------
Before running the run_analysis.R script, the following steps must be taken:

- The zip file for the dataset should be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
- The zip file contents should be extracted to a folder in the working directory named "UCI HAR Dataset".
- Within the "UCI HAR Dataset" folder, the following files and folders must exist:

        - test (folder)
        
                - subject_test.txt
                - X_test.txt
                - y_test.txt
                
        - train (folder)
        
                - subject_train.txt
                - X_train.txt
                - y_train.txt
                
        - activity_labels.txt
        - features.txt
        
How the Script Works
--------------------
The following section describes in detail what each portion of the script does.

### usePackage Function
At the beginning of the script file, a function is defined to assist with loading packages.

```
# Convenience function to only load a package if it is not already loaded
usePackage <- function(p) 
{
        if (!is.element(p, installed.packages()[,1]))
                install.packages(p, dep = TRUE)
        require(p, character.only = TRUE)
}

```
The purpose of this function is to allow the script to be run in an itempotent fashion.
That is, it should be possible to execute the package multiple times without any
errors thrown.  Attempting to load a package when the package is already loaded
usually causes an error.  This function simply ensures that the requested package is
not loaded before actually installing the package.

### getFileName Function
The names of all the data files follow a consistent pattern that we can
exploit to easily generate the appropriate file name based on just a 
prefix (X, Y, or Subject) and a set type (test or train).

```
getFileName <- function(prefix, setName)
{
        result <- paste("UCI HAR Dataset/", setName ,"/" , prefix, "_" , setName , ".txt", sep="")        
        return(result)
}
```

### extractData Function

Given a specific data set (test or train) extract data from the 
appropriate data files and combine into a tidy dplyr table. The complete function
is shown below with a more detailed breakdown of its operation following.

```
extractData <- function(setName) 
{
        #This holds the volunteer ID column for the set
        subject <- read.table(getFileName("subject", setName))
        colnames(subject) <- "subject_id"
        
        #This has the activity ID for the data set
        y <- read.table(getFileName("y", setName))
        colnames(y) <- "activity_id"
        
        #Join the Activity Names to the Activity Columns using dplyer
        y_with_names <- left_join(y,activity_labels, by="activity_id")
        
        #This holds the measures for the training set
        x <- read.table(getFileName("X", setName))
        colnames(x) <- measurement_colnames
        
        #Combine the data into one table
        result_tbl <- bind_cols(subject, y_with_names, x)    
        
        return(result_tbl)
}
```
First the column of data representing the users is loaded to a data table. 
The getFileName function defined earlier is used to construct the full 
path to the data file.  A column name is then set to identify the purpose of 
the data.

```
        subject <- read.table(getFileName("subject", setName))
        colnames(subject) <- "subject_id"
```

Next the column of data representing the activities that the volunteers were 
performing is loaded into a dataset and a column name is added.

```
        y <- read.table(getFileName("y", setName))
        colnames(y) <- "activity_id"
```

We then want to take the column with the activity IDs and add the corresponding
activity names.  To do so we will use dplyr to join the two data tables together.

```
        #Join the Activity Names to the Activity Columns using dplyer
        y_with_names <- left_join(y,activity_labels, by="activity_id")
```

We then read the raw measurement data into a table and label the columns with 
the names that would have been read earlier in the main script.

```
        #This holds the measures for the training set
        x <- read.table(getFileName("X", setName))
        colnames(x) <- measurement_colnames
```

Finally we merge the data from these different sources into one dplyr table:

```
        #Combine the data into one table
        result_tbl <- bind_cols(subject, y_with_names, x)    
        
        return(result_tbl)
```


### Main Routine
The main portion of the script performs the following actions:

- Load dplyr
- Extract the Column Labels
- Extract the Test Data
- Extract the Training Data
- Combine the Two Data Sets
- Produce the tidy data summary

These sections are described below.

### Load the dplyr package
Using the above function, the dplyr package can be loaded easily.

```
usePackage("dplyr")
```

The dplyr package is an excellent tool to use for manipulating data in R.  
It is recommended that anyone not familar with dplyr take a look
at the [Data Wrangling with dplyr and tidyr Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) by RStudio.  This two-page document provides an excellent summary
of all the functions contained in this library.

### Getting the Column Label Data
The next section of the code reads the data from the activity_labels.txt and features.txt files.

The activity_labels.txt file identifies the 6 types of activities that the volunteers were asked to perform.
After loading the data, descriptive column names are assigned to the data.
```
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activity_id", "activity_name")
```

The features.txt file lists the names of the 561 measures used in the study.

```
features <- read.table("UCI HAR Dataset/features.txt")
```

We only need the second column, which contains the names of the measurement columns.  
This data is stored in the measurement_colnames variable.

```
measurement_colnames <- features[,2]
```

### Extract the Data
Use the extractData function described earlier to load the two sets of data:

```
#--------------------------------------
# Get Raw Test Data (from 9 volunteers)
#--------------------------------------
test_tbl <- extractData("test")

#-------------------------------------------
# Get Raw Training Data (from 21 volunteers)
#-------------------------------------------
train_tbl <- extractData("train")
```

### Merge the Data

Now that we have two tidy data sets, it is easy to combine them using dplyr:

```
combined_tbl <- bind_rows(test_tbl, train_tbl)
```
Next we will trim the number of columns down to only include the subject ID, 
the activity name, and any measures involving standard deviations or means.

**Note** There are a variety of measures with mean as part of the measure name
such as angle(tBodyAccMean,gravity).  For this assignment I have excluded those
measures in favor of only including the measures that specifically list mean by
itself such as tBodyAccJerk-mean()-X.

This is also the first place that we will use the extremely useful pipe
command (%>%) in dplyr to break up lines in a relatively easy-to-read manner.

```
tidy_detailed_tbl <- combined_tbl %>% 
        select(subject_id, activity_name, contains("-std()"), contains("-mean()"))
```

### Grouping and Summarizing the data

The last transformation we need to perform is to group the data by subject and
by activity, then to calculate the average of each of the measurements.


```
tidy_summary_tbl <- tidy_detailed_tbl  %>% 
        group_by(subject_id, activity_name) %>% 
        summarise_each(funs(mean))
```

Finally, Write this tidy data set to a text file

```
write.table(tidy_summary_tbl, file="tidy.txt", row.name=FALSE)
```

Reading the Data from the Text File
-----------------------------------
To read the data from the final text file, first ensure that your working
directory contains a copy of the text file, then use the following commands:


```
file_path <- "tidy.txt"

data <- read.table(file_path, header = TRUE)
View(data)
```

This should allow you to examine the final data set.

