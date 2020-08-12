library(data.table)

if(!file.exists("~/UCI HAR Dataset.zip")) {
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, "~/UCI HAR Dataset.zip", mode = "wb")
unzip("UCI HAR Dataset.zip", exdir = getwd())
}

features <- read.csv("~/Daniel/Data science course/Getting and cleaning data/Assignment/UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
features <- as.character(features[,2])
testX <- read.table("~/Daniel/Data science course/Getting and cleaning data/Assignment/UCI HAR Dataset/test/X_test.txt")
testY <- read.csv("~/Daniel/Data science course/Getting and cleaning data/Assignment/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = " ")
testSubject <- read.csv("~/Daniel/Data science course/Getting and cleaning data/Assignment/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = " ")
test <- data.frame(testSubject, testY, testX)
names(test) <- c(c("subject", "activity"), features)
trainX <- read.table("~/Daniel/Data science course/Getting and cleaning data/Assignment/UCI HAR Dataset/train/X_train.txt")
trainY <- read.csv("~/Daniel/Data science course/Getting and cleaning data/Assignment/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = " ")
trainSubject <- read.csv("~/Daniel/Data science course/Getting and cleaning data/Assignment/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = " ")
train <- data.frame(trainSubject, trainY, trainX)
names(train) <- c(c("subject", "activity"), features)

databind <- rbind(train, test)

meanStandard <- grep("mean|std", features)
dataFinal <- databind[,c(1,2,meanStandard +2)]

activityLabels <- read.table("~/Daniel/Data science course/Getting and cleaning data/Assignment/UCI HAR Dataset/activity_labels.txt", header = FALSE)
activityLabels <- as.character(activityLabels[,2])
dataFinal$activity <- activityLabels[dataFinal$activity]

name <- names(dataFinal)
name <- gsub("[(][)]", "", name)
name <- gsub("^t", "TimeDomain_", name)
name <- gsub("^f", "FrequencyDomain_", name)
name <- gsub("Acc", "Accelerometer", name)
name <- gsub("Gyro", "Gyroscope", name)
name <- gsub("Mag", "Magnitude", name)
name <- gsub("-mean-", "_Mean_", name)
name <- gsub("-std-", "_StandardDeviation_", name)
name <- gsub("-", "_", name)
names(dataFinal) <- name

tidyData <- aggregate(dataFinal[,3:81], by = list(dataFinal$activity, subject = dataFinal$subject), FUN = mean)
write.table(tidyData, file = "tidy_data.txt", row.names = FALSE)