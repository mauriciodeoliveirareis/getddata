#load sqldf lib (Obs, if you don't have, you need to install sqldf into R)
library(sqldf)
#function to calculate the mean of the cols from the final data set
calculateMean <- function(data, groupCol = "ActNumber") {
  returnVal <- NULL
  for(col in colnames(data)) {
    if(col == "ActNumber" || col == "ActDesc" || col == "SubNumber"){
      next
    }
    arrResult <- tapply(data[,col], data[, groupCol], mean)
    dfResult <- as.data.frame(arrResult)
    colnames(dfResult) <- col
    if(is.null(returnVal)){
      returnVal <- dfResult
    } else {
      returnVal <- cbind(returnVal, dfResult)
    }
  }
  returnVal
}



#Read all the necessary data files
xtest = read.table("test/X_test.txt")
xtrain = read.table("train/X_train.txt")

ytest = read.table("test/y_test.txt")
ytrain = read.table("train/y_train.txt")

actLabel = read.table("activity_labels.txt")

subTest = read.table("test/subject_test.txt")
subTrain = read.table("train/subject_train.txt")

features = read.table("features.txt")

#Join x files
xTestTrain = rbind(xtest, xtrain)

#Join y files
yTestTrain = rbind(ytest, ytrain)

#Join subject files
subTestTrain = rbind(subTest, subTrain)

#get the entries from features in as the headings for x
colnames(xTestTrain) <- features$V2

#Give name to act columns
colnames(yTestTrain) <- c("ActNumber")
#Give name to Subject columns
colnames(subTestTrain) <- c("SubNumber")

#combine the joined x, the joined y, and the joined subject
allTestTrain <- cbind(xTestTrain, yTestTrain, subTestTrain)

#get the activity labels in based on the y column
allTestTrainAct <- sqldf("SELECT a.*, lb.V2 as 'ActDesc' FROM allTestTrain a, actLabel lb WHERE a.ActNumber = lb.V1")

#gets all the colnames to create a specific dataset with only mean, std,
#subject and activities
allColNames <- colnames(allTestTrainAct)

#get the columns that involves mean
meanCols <- grep("mean", allColNames)

#get the columns that involves standard deviation "std"
stdCols <- grep("std", allColNames)

#get the act col numbers
actNumberCol = grep("ActNumber", allColNames)
actDescCol = grep("ActDesc", allColNames)

#get subject col number
subNumberCol = grep("SubNumber", allColNames)

#merge mean and std columns
meanStdCols <- c(meanCols, stdCols)

#merge mean, std, activity and subject cloumns
finalCols <- c(meanCols, stdCols, actNumberCol, actDescCol, subNumberCol)

#create a dataset just with the coluns that are specified in finalCols
#this is the first  tidy data set asked in the project
finalData <- allTestTrainAct[, finalCols]

#generates a file with the final data 
write.table(finalData, "finalData.txt")



#create the second tidy data set
#calculate the mean grouped by action
meanAct <- calculateMean(finalData, "ActDesc")
#calculate the mean grouped by subject
meanSub <- calculateMean(finalData, "SubNumber")
#merges the two datas
meanActSub <- rbind(meanAct, meanSub)
#generates a file with the final mean data
write.table(meanActSub, "finalMeanData.txt")
