# Load packages
library(dplyr)

# Download zip file and unzip
filename <- "dataset.zip"

if (!file.exists(filename)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, "dataset.zip", method = "curl")
}

dir_name <- "UCI HAR Dataset"
if (!file.exists(dir_name)){
  unzip("dataset.zip", exdir = ".")
}

# Read in features data set
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

#Read in activity_labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("n", "activity"))

# Read in test and train data sets
for (i in c("train", "test")){
  for(j in c("X", "subject", "y")) {
    assign(paste0(j,"_",i),read.table(paste0("UCI HAR Dataset/",i,"/",j,"_",i,".txt")))
  }
  
  # Assign features data as X_test and X_train column names
  assign(paste0("X_",i), setNames(get(paste0("X_",i)), features$functions))

  # Rename columns "subjectid" and "activity"
  assign(paste0("subject_",i), setNames(get(paste0("subject_",i)), "subjectid"))
  assign(paste0("y_",i), setNames(get(paste0("y_",i)), "activity"))

  # Combine all test data sets and all train data sets
  assign(i, cbind(get(paste0("y_",i)), get(paste0("subject_",i)), get(paste0("X_",i))))
 }

# Merge test and train data
masterdata <- rbind(train, test) %>%
  select(subjectid, activity, contains("mean()"), contains("std()")) #Extracts only the measurements on the mean and standard deviation for each measurement

# Assign descriptive activity names to name the activities in the data set
masterdata$activity <- factor(masterdata$activity,
                                levels = activity_labels$n,
                                labels = activity_labels$activity)

# Assign appropriate labels
labels_abb <- c("^t", "^f", "Acc", "Gyro", "Mag", "-mean..", "-std..", "BodyBody", "-X", "-Y", "-Z")
labels <- c("time", "frequency", "accelerometer", "gyrometer", "magnitude", "mean", "sd", "body", "X", "Y", "Z")

for (i in 1:length(labels_abb)){
  colnames(masterdata) <- gsub(labels_abb[i], labels[i], colnames(masterdata), ignore.case = TRUE)
}

colnames(masterdata) <- tolower(colnames(masterdata))

# Create tidy data set with the average of each variable for each activity and each subject.
tidydata <- masterdata %>%
  group_by(activity, subjectid) %>%
  summarise_all(funs(mean))

write.table(tidydata, "tidydata.txt",row.name=FALSE)
