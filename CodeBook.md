Abstract: Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

The assignment instructions are in the README.md file. The downloaded text documents are:

Activity_labels.txt : 6 obs of 2 variables ($V1: int (1-6); $V2: factor with 6 levels)

Features.txt: 561 obs of 2 variables ($V1: int (1-561)): $V2: factor with 477 levels)

subject_test.txt : 2947 obs. of  1 variable (int)

subject_train.txt : 7352 obs. of  1 variable (int)

X_test : 2947 obs. of  561 variables (num)

y_test : 2947 obs. of  1 variable (int)

X_train : 7352 obs. of  561 variables (num)

y_train : 7352 obs of 1 variable (int)

Based on the above dimensions and  presence or absence of column name, to build the required tidy data set, the following steps were taken:

read above files into separate dataframes

assign column 2 of features as column names for X_train and X_test

assign colnames to subject_test and subject_train

add extra column with activity labels($V2) to y_test and y_train

assign descriptive colnames to y_test and y_train ('activity label' and 'activity id')

bind data: 1) subject_test, y_test and X_test, and 2) subject_train, y_train and X_train

subset rows in test and train dfs with mean or std plus subject and activity label column

merge test and train data

create tidy data set with averages aggregated on subject and activity

write tidy data set to a file
