run_analysis<-function(){
  library(plyr)
  library(reshape)
  library(reshape2)
  
  
  #Read subject_test.txt and subject_train.txt (list of subject) and bind to one
  stest <- read.table("subject_test.txt", col.names="subject")
  strain <- read.table("subject_train.txt", col.names="subject")
  stesttrain <- rbind(stest, strain)
  
  #Read X_test.txt and x_train.txt (list of feature data) and bind
  fdatatest <- read.table("X_test.txt")
  fdatatrain <- read.table("X_train.txt")
  fdatatesttrain <- rbind(fdatatest, fdatatrain)
  #Read features.txt (list of feature labels)
  flist <- read.table("features.txt", col.names=c("id", "feature_labels"))
  flabels <- flist$feature_labels
  #Insert column labels on feature data from features.txt
  colnames(fdatatesttrain) <- flabels
  #Extract columns which indicate std and mean
  fcol_stdmean <- grepl('std\\(\\)|mean\\(\\)',flabels)
  #Retain data which have std and mean values
  fdatatesttrain <- fdatatesttrain[,fcol_stdmean]
  
  #Read y_test.txt and y_train.txt (activity IDs) and bind
  adatatest <- read.table("Y_test.txt", col.names="activity_id")
  adatatrain <- read.table("Y_train.txt", col.names="activity_id")
  adatatesttrain <- rbind(adatatest, adatatrain)
  #Read activity_labels.txt and label columns, take note on same column id activity_id
  alabels<-read.table("activity_labels.txt",col.names=c("activity_id","activity"))
  #Insert labels via joining adatatesttrain and alabels datasets
  a_all<-join(adatatesttrain,alabels,by="activity_id",type="left")
  
  #Bind Subject, Features and Activity Data
  master_data <- cbind(stesttrain, fdatatesttrain, a_all)

  
  #reshape data based on subject and activity
  new_data <- melt(master_data, id=c("subject", "activity"))
  #get the mean based on the activity and subject
  final_data <- dcast(new_data, activity + subject ~ variable, mean)
  
  
}