This is the Getting and Cleaning Data assignment for Coursera.

We started using a database that can be found at this adress:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The data is described here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The script made assumes that the zip file is located in the local folder. It checks whether this condition is verified and throws an error if not.

The main function is <b>run_analysis()</b> which works in two steps.

It writes a tidyData.txt file in the same folder. 
To read the obtained data use the following script :
```{r}
readData <- read.table("tidyData.txt", header = T)
View(data)
```
(Thanks David Hood!)

The first one is <b>tidyThisData()</b> [questions 1-4] and the second, <b>averageDataSet()</b> uses the dataset obtained to perform some analysis [question 5].

I - <b>tidyThisData()</b> it self consists of three steps:
1/ We load the used libraries (here it's only dplyr) <b>loadLibraries()</b>
2/ We load and merge the data from test and train datasets. <b>getMergeData()</b> [questions 1 and 4]
3/ We extract the relevant columns, ie those that are about mean and std <b>extractMeanSD()</b> [question 2]
4/ We then substitue the activites, that are numbers in the beginning, for their labels <b>nameActivities()</b>

<b>getMergeData()</b>:
1/ Checks whether the zip file is there and if so it unzips it.
2/ Reads the features and the x and y values for train and test (one after the other) and uses the subfunction <b>mergeTwoTables()</b> that appropriately names the columns (making sure there are no duplicates), using features, adds a column to show the origin of the set (train or test) and merges the whole thing. 
3/ Binds the two tables together.

<b>extractMeanSD(data)</b>:
1/ Extracts columns with information (activity, origin).
2/ Extracts columns related to mean.
3/ Extracts columns related to std.
4/ Merges the three tables.

<b>nameActivities(data)</b>:
Replaces activities number by their corresponding label, using the activity_label.txt table provided with the dataset.

We thus obtain a tidied table corresponding to questions 1-4.

II - <b>averageDataSet(data)</b>
Uses the data obtained previously.
1/ Groups row entries according to activities values.
2/ Calculates the mean for each subject (ie each column) except for the origin one, for each activity.