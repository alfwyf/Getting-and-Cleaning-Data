
# read data
trainX<-read.table("train/X_train.txt")
trainy<-read.table("train/y_train.txt")
trainsub<-read.table("train/subject_train.txt")
testX<-read.table("test/X_test.txt")
testy<-read.table("test/y_test.txt")
testsub<-read.table("test/subject_test.txt")

#step1: merge data
dataX<-rbind(trainX,testX)
datay<-rbind(trainy,testy)
datasub<-rbind(trainsub,testsub)

# clear memory
rm(trainX,trainy,trainsub)
rm(testX,testy,testsub)

#step4: attach colomn names
features<-read.table("features.txt")
names(datay)<-"activity"
names(datasub)<-"subject"
names(dataX)<-features[,2]

#step2: extract mean and std measurements
dataX<-dataX[,grep("mean\\(|std\\(",features[,2])]

#step3: rename activities
activity<-read.table("activity_labels.txt")
dataact<-activity[datay[,1],2]
names(dataact)<-"activity"

#step5: tidy data, mean by activites and subjects
tidy<-aggregate(dataX,by=cbind(dataact,datasub),mean)

write.table(dataX,"clean_data.txt",row.names=FALSE)
write.table(tidy,"tidy_data.txt",row.names=FALSE)