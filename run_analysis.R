rm(list = ls())
library(dplyr)
library(data.table)
library(rio)
Features<-import("features.txt")
TestData<-import("X_test.txt")
colnames(TestData)<-Features$V2
TestLabels<-import("Y_test.txt")
colnames(TestLabels)<-"Activity"
TestData_full<-cbind(TestData,TestLabels)
Features<-import("features.txt")
TrainData<-import("X_train.txt")
colnames(TrainData)<-Features$V2
TrainLabels<-import("y_train.txt")
colnames(TrainLabels)<-"Activity"
TrainData_full<-cbind(TrainData,TrainLabels)
colnames(TestData)<-Features$V2
colnames(TrainData)<-Features$V2
Merged<-rbind(TestData_full,TrainData_full)
ActivityLabels <-import("activity_labels.txt")
ActivityLabels
Merged$Activity<-as.factor(as.character(Merged$Activity))
Merged$Activiy
Merged$Activ<-factor(Merged$Activity, levels=ActivityLabels$V1, labels=ActivityLabels$V2)
Merged$Activ
