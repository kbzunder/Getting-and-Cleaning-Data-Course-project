rm(list = ls())
library(dplyr)
library(data.table)
library(rio)
library(reshape2)
#downloading files
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path <- getwd()
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")
#reading data with rio package
#naming columns
Features<-import("features.txt")
TestData<-import("X_test.txt")
colnames(TestData)<-Features$V2
TestLabels<-import("Y_test.txt")
colnames(TestLabels)<-"Activity"
TrainData<-import("X_train.txt")
colnames(TrainData)<-Features$V2
SubjectNum_train<-import("subject_train.txt")
SubjectNum_test<-import("subject_test.txt")
colnames(SubjectNum_test)<-"SubjectNum"
colnames(SubjectNum_train)<-"SubjectNum"
TrainLabels<-import("y_train.txt")
colnames(TrainLabels)<-"Activity"
#adding Activity and SubjectNum columns to eash data frame
TrainData_full<-cbind(TrainData,TrainLabels,SubjectNum_train)
TestData_full<-cbind(TestData,TestLabels,SubjectNum_test)
#Merging two data frames
Merged<-rbind(TestData_full,TrainData_full)
ActivityLabels <-import("activity_labels.txt")
#making factor var (6 activities) from Activ column
Merged$Activity<-as.factor(as.character(Merged$Activity))
Merged$Activ<-factor(Merged$Activity, levels=ActivityLabels$V1, labels=ActivityLabels$V2)
#selecting only columns with std and mean
std_mean<-grep("(std|mean)\\(\\)",names(Merged),value = TRUE)
Selected_Merged<-select(Merged,std_mean,SubjectNum,Activ)
#making a vector of colnames for future renaming
ColNams<-colnames(Selected_Merged)
#making colnames of the dataframe more readable
ColNames_beautified<-gsub("[()]","",ColNams)
colnames(Selected_Merged)<-ColNames_beautified
#aggregating values in a data frame by number and activity
aggregated<-aggregate(Selected_Merged,list(Selected_Merged$SubjectNum,Selected_Merged$Activ),mean)
