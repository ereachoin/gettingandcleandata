parent=getwd()
#read features
setwd("./UCI HAR Dataset")
uci=getwd()
features=read.table("features.txt")
features=features[,2]
features=as.vector(features)

#read training files#
setwd("./train")
subjecttrain = read.table("subject_train.txt",col.names="subject")
xtrain=read.table("X_train.txt",colClasses="numeric",col.names=features)
ytrain=read.table("Y_train.txt",col.names="activity")

#read test files 
setwd(uci)
setwd("./test")
subjecttest = read.table("subject_test.txt",col.names="subject")
xtest=read.table("X_test.txt",colClasses="numeric",col.names=features)
ytest=read.table("Y_test.txt",col.names="activity")

#combine cols and rows 
subject=rbind(subjecttrain,subjecttest)
features=rbind(xtrain,xtest)
activity=rbind(ytrain,ytest)
tidytrain=cbind(features,subject)
tidytrain=cbind(tidytrain,activity)

library(dplyr)
options(dplyr.width = Inf)

##******end of STEP 1*******
##**************************

#extract measturements on means and standard deviation

extract = grepl("mean()|std()",names(tidytrain))
keepcol=vector()
coln=ncol(tidytrain)
for(i in 1:coln){
   if(extract[i]==TRUE){
           keepcol=append(keepcol,i)
   }     
}
tidytrain=tidytrain[,keepcol]

#whoops, some meanFreq are in the dataframe
#let's delete those columns

extract=grepl("meanFreq",names(tidytrain))
keepcol=vector()
coln=ncol(tidytrain)
for(i in 1:coln){
        if(extract[i]==FALSE){
                keepcol=append(keepcol,i)
        }     
}
tidytrain=tidytrain[,keepcol]
tidytrain=cbind(tidytrain,subject)
tidytrain=cbind(tidytrain,activity)

##******end of STEP 2*******
##**************************

#Uses descriptive activity names to name the activities in the data set
setwd(uci)
ActivityNames=read.table("activity_labels.txt",col.names=c("activity","ActivityItems"))
merged=merge(tidytrain, ActivityNames, by = "activity", all.x = TRUE)

##******end of STEP 3*******
##**************************

#Step 4 is finished in Step 1# 

#From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable for each activity and each subject.

#group according to subject and activity
#then summarize each variable using mean
by_sub_act= group_by(merged,subject,ActivityItems)
by_sub_act=by_sub_act %>% summarise_each(funs(mean))
tidy=arrange(by_sub_act,subject,activity)
print(tidy)
#tidy is the tidy dataset here 
