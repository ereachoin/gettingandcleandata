#Preliminary 
The default directory of the file assumes run_analysis.R and the UCI HAR Dataset is in the same folder. 
Make sure you store your parent path as `parent = getwd()` to play with files in different folders. 

#Primary Transformation

###Step 1: Read and Merge the data 

Read the files (features.txt, subject_train.txt, subject_test.txt, x_train.txt,x_test.txt, y_train.txt,y_test.txt) using`read.table()`. Remeber to include colclasses all the time for big files, especially for x_train.txt and x_test.txt. 

###Note: use col.names here to appropriate assign names to all the variables:

>two "x.txt" files = vector from "features.txt" 

>two the "y.txt files = activity 

>two the "subject" files = subject 

Merge the two "x.txt" files, two "y.txt" files and two "subject.txt" files using `rbind()` for test and train, 
then merge "x.txt","y.txt","subject.txt" using `cbind()`.

###Step 2: Extract variables with mean and std

First, use `grepl()`to get whether the names of the variables of raw dataset contains strings "mean()" or "std()".

Then, loop over every column variable in the raw dataset to get a vector `keepcol` with column numbers that contains the two strings.  

Get the extracted dataset by `raw[,keepcol]`

###Step 3: Add descriptive values to Activity 

Use `read.table()`again to read the activity_labels.txt file. 

Merge the activity_labels file and the extracted dateset in step 2 according to the activity index in two files. 

You can use `merge()` function. 

###Step 4 is finished in Step 1# 
All the "V1, V2, V3 " for are already appropriately labeled appropriately with measurements variable names found in features.txt. 

###Step 5: Create a tidy data set with the average of each variable for each activity and each subject.

Please call the dplyr package using `library(dplyr)`. 

Then use the `group_by()` function to split the current dataset according to subject and then activity index. 

Finally, get the mean of each variable for each activity and each subject using `summarise_each()` function. 

The function I used is `by_sub_act %>% summarise_each(funs(mean))` 
