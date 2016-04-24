# JHU Getting and Cleaning Data Project

# Create Working Folder
if(!file.exists("./data")){dir.create("./data")}

# Define Path
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download data to working folder
download.file(url,destfile="./data/Dataset.zip")

# Unzip data file
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Data is now in a folder "data/UCI HAR Dataset
# List files and path
install.packages("reshape2")
library(reshape2)

# Load activity labels and features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# 2) Etract on the measurements on the mean and STD.
mean_std <- grep(".*mean.*|.*std.*", features[,2])
mean_std.names <- features[mean_std,2]
mean_std.names = gsub('-mean', 'Mean', mean_std.names)
mean_std.names = gsub('-std', 'Std', mean_std.names)
mean_std.names <- gsub('[-()]', '', mean_std.names)

# Load training and test data
train <- read.table("UCI HAR Dataset/train/X_train.txt")[mean_std]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[mean_std]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# 1) Merge the training and test date sets and create labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", mean_std.names)

# 3) Create  subject and activity factorals
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

#  Write data out to .txt file "tidydata.txt"
write.table(allData.mean, "tidydata.txt", row.names = FALSE, quote = FALSE)