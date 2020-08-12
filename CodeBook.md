# Code Book

### 1. Download zip file and extract files
* Data set is downloaded from the site provided and extracted inside a folder called UCI HAR Dataset.

### 2. Read files and assign variables
* `features` <- features.txt
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
* `testX` <- X_test.txt
Test data of features
* `testY` <- y_test.txt
Test data of activities
* `testSubject` <- subject_test.txt
Test data of subjects
* `trainX` <- X_train.txt
Train data of features
* `trainY` <- y_train.txt
Train data of activities
* `trainSubject` <- subject_train.txt
Train data of subjects
* `activityLabels` <- activity_labels.txt
List of activities performed whilemeasurements were taken

### 3. Merging training data and test sets to create one data set
* `test` variable is created merging `testSubject`, `testY`, and `testX`, in that order.
* `train` variable is created merging `trainSubject`, `trainY`, and `trainX`, in that order.
* Variables `test` and `train` are merged in `databind` using rbind() function.

### 4. Extracting the measurements on the mean and standard deviation for each measurement

* `meanStandard` calculates the mean and standard deviation of the variable `features` using grep and then is used to create `dataFinal` in which the results are incorporated with `databind` variable.

### 5. Descriptive activity names to name the activities in the data set
* Names in activity_labels.txt are stored under `activityLabels` and incorporated into `dataFinal`.

### 6. Adding appropriate descriptive variable names in the data set
* Words starting with "t" are replaced by TimeDomain.
* Words starting with "f" are replaced by FrequencyDomain.
* Acc is replaced by Accelerometer.
* Gyro is replaced by Gyroscope.
* Mag is replaced by Magnitude.
* -mean- is replaced by Mean.
* -std- is replaced by StandardDeviation.
* "-" are replaced by "_".

### 7. New independent tidy data set with the average of each variable for each activity and each subject
* `tidy_data` variable is created to show the average of each variable for each activity and each subject and tidy_data.txt file is generated.