test_subjects = read.table(file = "test//subject_test.txt",header = FALSE)
test_x = read.table(file = "test//X_test.txt",header = FALSE)
test_y = read.table(file = "test//y_test.txt",header = FALSE)
features = read.table(file = "features.txt", header = FALSE)

names(test_subjects) = c("Subject")
names(test_y) = c("Activity_Label")
names(test_x) = features$V2
test_data = cbind(test_subjects,test_y,test_x)

training_subjects = read.table(file = "train//subject_train.txt",header = FALSE)
training_x = read.table(file = "train//X_train.txt",header = FALSE)
training_y = read.table(file = "train//y_train.txt",header = FALSE)

names(training_subjects) = c("Subject")
names(training_y) = c("Activity_Label")
names(training_x) = features$V2
train_data = cbind(training_subjects,training_y,training_x)

full_data  = rbind(train_data,test_data)

names_full_data = as.data.frame( grep("mean()",names(full_data) ,value = TRUE))
names(names_full_data) = c("Features")
names_full_data_s = as.data.frame( grep("std()",names(full_data) ,value = TRUE))
names(names_full_data_s) = c("Features")
names_full_data = rbind(names_full_data,names_full_data_s)

names_full_data = names_full_data[c(1:23,27:29,33:35,39,41,43,45,47:79),]
names_full_data  = c("Subject","Activity_Label",as.vector(names_full_data))
step2_data = full_data[,names_full_data]

step2_data[step2_data$Activity_Label == 1,]$Activity_Label = "WALKING"
step2_data[step2_data$Activity_Label == 2,]$Activity_Label = "WALKING_UPSTAIRS"
step2_data[step2_data$Activity_Label == 3,]$Activity_Label = "WALKING_DOWNSTAIRS"
step2_data[step2_data$Activity_Label == 4,]$Activity_Label = "SITTING"
step2_data[step2_data$Activity_Label == 5,]$Activity_Label = "STANDING"
step2_data[step2_data$Activity_Label == 6,]$Activity_Label = "LAYING"

step5_data = aggregate(step2_data[,3:68],list(step2_data$Subject,step2_data$Activity_Label),FUN = mean)
step5_names = names(step5_data)
step5_names[1] = c("Subject")
step5_names[2] = c("Activity_Label")
names(step5_data) = step5_names
write.table(step5_data,file="tidyDataSet.txt",row.name=FALSE)
