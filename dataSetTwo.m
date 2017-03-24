% dataSetTwo.m
% Steve Ryan, started 3/21/2017

% from inspecting the data manually in Excel, Plates 1 & 2 are RT, plates 3
% & 4 are 32 C.  Most FOVs have multiple measurements, but all are at the
% same drug concentration, selected from [0, 0.03, 0.1, 0.3, 1, 3, 10, 30].
% There are 32 fields of view in each plate.  Looks like there is some 
% missing data here.  9 rows missing entirely, another 132 with at least 1 
% missing value.

% I'm interested in the underlying structure of the data.  I'm going to
% import the data, clean it up, sort it, and process it with a hierarchical
% clustering algorithm.  I'll perform the hierarchical clustering without 
% the Temperature, Concentration, Plate Number, and FOV features.
% Afterwards, we can compare the resulting dendrogram to these features
% (particularly Temperature and Concentration) to see if these experimental
% variables resulted in meaningful clustering of the data.  This is a nice
% way to do a first-pass inspection of the data set looking for underlying
% structure and validating the importance of the experimental variables.

% Hierarchical clustering doesn't deal well with missing data.  There are a
% variety of approaches to trying to replace missing data.  Here, as a
% first pass, I'm going to take the conservative approach of just removing 
% rows with missing data.  A more advanced approach would be to use the
% complete portions of the data set to impute reasonable substitutions for 
% missing values.  After it's cleaned up, I'm going to sort it, just to
% make it easier to identify what data ends up in which clusters.

rawData = readtable('sampleFeatureMatrix.csv');
lessData = rawData(:,1:31);
cleanData = rmmissing(lessData);

