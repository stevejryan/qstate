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

% input data from .csv and sort based on Plate # and FOV #
rawData = readtable('sampleFeatureMatrix.csv');
sortedData = sortrows(rawData,[33 34]); 

% remove any rows with missing data. No need to specify additional 
% characters for missing data, this data set just has empty cells
cleanData = rmmissing(sortedData); 

% remove predictor columns
lessData = cleanData(:,1:31);
dataArray = table2array(lessData);

% clustering
dataDist = pdist(dataArray,'euclid'); 
dataLink = linkage(dataDist,'single'); 
T = cluster(dataLink,'maxclust',16);
dendrogram(dataLink, 0)

writetable([cleanData table(T)],'clusters.csv')

% Results
% Okay, from the dendrogram and manual inspection of the group assignments
% in clusters.csv, it's clear the clustering didn't do what I hoped for.  I
% had hoped the data would cluster more or less by experimental groups, so
% I limited the maximum number of clusters to a conservative estimate of
% group number (# of temperatures * # of drug concentrations: 16).  The
% result was one large cluster containing most of the data and the
% other clusters having only one or two values each.  This seems like the
% clustering is being driven by outliers, so to get this to work I'd need
% to find a way of clustering that's resistant to outliers.  Maybe a better
% linkage function, maybe divisive clustering instead of agglomerative.  In
% truth, it's been a while since I worked on a clustering analysis, so I
% suppose I shouldn't be surprised this would need more optimization to get
% it to a point where it's useful.