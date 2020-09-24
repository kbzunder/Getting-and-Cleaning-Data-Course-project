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
TrainData<-import("X_train.txt")
colnames(TrainData)<-Features$V2
TrainLabels<-import("y_train.txt")
colnames(TrainLabels)<-"Activity"
TrainData_full<-cbind(TrainData,TrainLabels)
colnames(TestData)<-Features$V2
colnames(TrainData)<-Features$V2
Merged<-rbind(TestData_full,TrainData_full)
ActivityLabels <-import("activity_labels.txt")
Merged$Activity<-as.factor(as.character(Merged$Activity))
Merged$Activ<-factor(Merged$Activity, levels=ActivityLabels$V1, labels=ActivityLabels$V2)
std_mean<-grep("(std|mean)\\(\\)",names(Merged),value = TRUE)
Selected_Merged<-select(Merged,std_mean)
Selected_Merged
ColNams<-colnames(Selected_Merged)
ColNames_beautified<-gsub("[()]","",ColNams)
colnames(Selected_Merged)<-ColNames_beautified
Selected_Merged
tidy_data<-summarise_all(Selected_Merged,mean)

