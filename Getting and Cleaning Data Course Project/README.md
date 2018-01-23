Getting and Cleaning Data Course Project

January 23, 2018

This is an exercise under the John Hopkins Data Science program for data cleaning. Take note that all relevant files should be placed on the working directory

Relevant files:
- X_test
- X_train
- y_test
- y_train
-subject_test
-subject_train
-features
-activity_labels


Summary:
1. Each file was extracted file to a variable database
2. Subject, Features and Activities were combined together.
3. For Features, the only relevant data were those which contained standard deviation and mean. Hence, the rest were filtered out.
4. Reshaping was needed to be done to get the mean based on the activity and subject.
