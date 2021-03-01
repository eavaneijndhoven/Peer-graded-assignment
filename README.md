# Peer graded assignment: Getting and Cleaning Data Course Project

## Introduction
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

## Data set
Data was collected data collected from the accelerometers from the Samsung Galaxy S smartphone, and downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## File overview
The following files are included in the repository:

- `Codebook.md`: A code book that describes the variables, the data, and any transformations used to transform the data into a tidy dataset
- `run_analysis.R`: Rscript that transforms the data  into the tidy dataset saved as `tidydata.txt`
  - Load packages
  - Download zip file and unzip
  - Read in data sets
  - Assign column names different data sets
  - Combine all test data sets, and all train data set
  - Merge test and train data set into master data set
  - Assign descriptive activity names to name the activities in the master data set
  - Assing appropriate labels in the master data set
  - Create independent tidy data set from master data set with the average of each variable for each activity and each subject
  - Write tidy data set into .txt file
- `tidydata.txt`: The tidy data set that is the output from running the Rscript `run_analysis.R` 
