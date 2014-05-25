#Code Book for the variables inside the files finalData and finalMeanData

##finalData.txt
This file has all the data asked for the excercise until the step 4 from the excercise according with my interpretation from 
the requirements.
The excercise asked to get the mean and standard deviation informations from the file so, this file consists in colummns 
\*mean\*, \*std\* and the tree extra merged columns "ActNumber" (Activity number),	ActDesc(Activity Description) and	
"SubNumber" (Subject number).
The code inside run_analysis.R is well commented to be easy to maintain. What was done in the code is explained below:

1. Joined test/X_test.txt and train/X_train.txt with a simple rbind operation.
2. Joined test/y_test.txt and train/y_train.txt with a simple rbind operation.
3. Joined test/subject_test.txt and train/subject_train.txt with a simple rbind operation.
4. Inserted in the merged X data sets the columns names from features.txt
5. Changed the column name from the merged Y data sets to "ActNumber"
6. Changed the column name from the merged subjects data sets to "SubNumber"
7. Joined with a cbind the X, Y and subjects data sets into a allInOne data set.
8. Joined the activity description from activity_labels.txt into the allInOne data set based on the ActNumber Column. (For
academic proposes, I've decided to use the sqldf lib to tes how it works.
9. Get all the colnames from the allInOne data set that has mean or std in the name.
10. Created a final data set from the allInOne dataSet just with the columns \*mean\*, \*std\* and the tree extra merged columns 
"ActNumber" (Activity number),	"ActDesc"(Activity Description) and	"SubNumber" (Subject number).
11. Generated the file finalData.txt from this final data set.

##finalMeanData.txt
This file contains the data asked in the step 5 from the excercise and it's initial data is based on the final data set 
described above.
The first column has the kind of data that was measured. The first six rows have the 6 diferents kinds of activies and the
subsequent rows have the diferents Subjects.
The other columns are the \*mean\* and \*std\* ones and its values are the averege values for each group criteria from the 
first columns.
I've wrote a function called calculateMean to centrilize a few operations that are performe twice. The complete steps to
genereta finalMeanData are described below:
1. Calculate the mean from each column (except for "ActNumber",	"ActDesc" and	"SubNumber") grouping by ActDesc
2. Calculate the mean from each column (except for "ActNumber",	"ActDesc" and	"SubNumber") grouping by SubNumber
3. Merged the two mean data sets with rbind
4. 11. Generated the file finalMeanData.txt from this merged data set.



