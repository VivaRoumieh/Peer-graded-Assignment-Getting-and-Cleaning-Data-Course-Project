# CodeBook for the Human Activity Recognition Project

## Project Description
This project analyzes data collected from the accelerometers from the Samsung Galaxy S smartphone, aiming to prepare a tidy dataset that reflects measurements related to mean and standard deviation for various activities.

## Study Design and Data Source
Data was collected from 30 subjects performing activities while carrying a waist-mounted smartphone that recorded 3-axial linear acceleration and 3-axial angular velocity. The original data is sourced from:
[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Dataset Description
The dataset includes the following files:
- `X_train.txt`: Training set.
- `Y_train.txt`: Training labels.
- `X_test.txt`: Test set.
- `Y_test.txt`: Test labels.
- `features.txt`: List of all features.
- `activity_labels.txt`: Links the class labels with their activity name.

## Variables Description
- `subjectID`: Identifier of the subject who carried out the experiment.
- `activityID`: Identifier of activity type the subject performed during recording.
- `activityType`: Descriptive name of the activity performed.

### Feature Selection
The following patterns in feature names were considered for extraction:
- `mean()`: Indicates mean value
- `std()`: Indicates standard deviation
- Feature names have been further refined to be more descriptive:
  - Prefix `t` is replaced by `time`
  - Prefix `f` is replaced by `frequency`
  - `Acc` is expanded to `Accelerometer`
  - `Gyro` is expanded to `Gyroscope`
  - `Mag` is replaced by `Magnitude`
  - `BodyBody` is corrected to `Body`

## Data Transformation Steps
The following steps were performed to clean up the data:
1. **Merging Training and Test Sets**: Training and test sets were merged to create one data set using `rbind` and `cbind`.
2. **Extracting Measurements**: Extracted only the measurements on the mean and standard deviation for each measurement.
3. **Applying Descriptive Activity Names**: Activity IDs were replaced with descriptive activity names using data from `activity_labels.txt`.
4. **Labeling the Data Set with Descriptive Names**: Modified variable names to be more descriptive, making them readable and understandable.
5. **Creating a Tidy Dataset**: Averaged each variable for each activity and each subject using the `dplyr` package and saved the result into `tidySet.txt`.

## Output File
- `tidySet.txt`: Independent tidy data set with the average of each variable for each activity and each subject.

## Acknowledgments
Data collected from experiments are courtesy of the Group of Smartlab - Non Linear Complex System Laboratory at the Università degli Studi di Genova, Italy.