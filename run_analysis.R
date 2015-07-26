#*********************************************************************
# run_analysis.R
#*********************************************************************
# This package reads activity data gathered by 30 volunteers 
# performing 6 different types of actions over time.
#
# Author: Jim Kay
# Created: 7/25/2015
#*********************************************************************


#*********************************************************************
# Functions
#*********************************************************************

#.........................................................................
# usePackage Function
#.........................................................................
# Convenience function to only load a package if it is not already loaded
#.........................................................................
usePackage <- function(p) 
{
        if (!is.element(p, installed.packages()[,1]))
                install.packages(p, dep = TRUE)
        require(p, character.only = TRUE)
}

#.........................................................................
# getFileName Function
#.........................................................................
# The names of all the data files follow a consistent pattern that we can
# exploit to easily generate the appropriate file name based on just a 
# prefix (X, Y, or Subject) and a set type (test or train).
#.........................................................................
getFileName <- function(prefix, setName)
{
        result <- paste("UCI HAR Dataset/", setName ,"/" , prefix, "_" , setName , ".txt", sep="")        
        return(result)
}

#.........................................................................
# extractData Function
#.........................................................................
# Given a specific data set (test or train) extract data from the 
# appropriate data files and combine into a tidy dplyr table.
#.........................................................................
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

#*********************************************************************
# Main Code
#*********************************************************************

#-----------------------------------
# Load the dplyer package
#-----------------------------------
usePackage("dplyr")

#-----------------------------------
# Get the column label data
#-----------------------------------
#Read the "Walking, Sitting, Standing, etc" activities with their ID numbers.
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activity_id", "activity_name")

#These are the labels for the measurements - there are 561 different types of measures
features <- read.table("UCI HAR Dataset/features.txt")

#We only need the second column, which contains the names of the measurement columns
measurement_colnames <- features[,2]

#--------------------------------------
# Get Raw Test Data (from 9 volunteers)
#--------------------------------------
test_tbl <- extractData("test")

#-------------------------------------------
# Get Raw Training Data (from 21 volunteers)
#-------------------------------------------
train_tbl <- extractData("train")

#-----------------------------------
# Merge the Two Data Sets
#-----------------------------------
#Merge the training and test tables into one combined table
combined_tbl <- bind_rows(test_tbl, train_tbl)

#Select just the mean and standard deviation columns we want 
tidy_detailed_tbl <- combined_tbl %>% 
        select(subject_id, activity_name, contains("-std()"), contains("-mean()"))

#Now average each measurement by activity and subject 
tidy_summary_tbl <- tidy_detailed_tbl  %>% 
        group_by(subject_id, activity_name) %>% 
        summarise_each(funs(mean))

#Finally, Write this tidy data set to a text file
write.table(tidy_summary_tbl, file="tidy.txt", row.name=FALSE)

