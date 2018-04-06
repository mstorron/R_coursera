library(dplyr)
today = as.Date(Sys.time())
#fetch zip data
wdataset<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(wdataset, destfile = "./wdataset.zip", method = "curl")
#unzip it
unzip("wdataset.zip")
#read features and activity labels files
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels<-  read.table("./UCI HAR Dataset/activity_labels.txt")

#read test folder
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <-read.table("./UCI HAR Dataset/test/subject_test.txt")

#read train folder
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <-read.table("./UCI HAR Dataset/train/subject_train.txt")

#assign column 2 of features as column names for X_train and X_test:
colnames(X_test) <- features[,2]
colnames(X_train) <- features[,2]

# assign a name to subject_test and subject_train
colnames(subject_test) <-"subject"
colnames(subject_train)<- "subject"

#add extra column with activity names to y_test and y_train
y_test[,2]<- activity_labels[[2]][y_test[,1]]
y_train[,2]<- activity_labels[[2]][y_train[,1]]

#assign names to y_test and y_train
names(y_test) = c("activity_id", "activity_label")
names(y_train) = c("activity_id", "activity_label")

# append subject_test, y_test and X_test, and subject_train, y_train and X_train
bound_test<- bind_cols(subject_test, y_test, X_test)
bound_train<- bind_cols(subject_train, y_train, X_train)

# subset rows in test and train dfs with mean or std plus subject and activity label columnd
bound_test_subset<-  bound_test[grepl(c("subject|activity_label|std|mean"), names(bound_test))]
bound_train_subset<-  bound_train[grepl(c("subject|activity_label|std|mean"), names(bound_train))]

#merge test and train data
alldata<- bind_rows(bound_test_subset, bound_train_subset)

#create tidy data set with averages
tidyset<- aggregate(.~activity_id+subject+activity_label, alldata, FUN =  mean)
# write it to a file
write.table(tidyset, file = "./tidy_data.txt", row.names = FALSE)
