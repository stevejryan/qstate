% dataSetTwo.m
% Steve Ryan, started 3/21/2017

data = readtable('sampleFeatureMatrix.csv');

% from inspecting the data manually in Excel, Plates 1 & 2 are RT, plates 3
% & 4 are 32 C.  Most FOVs have multiple measurements, but all are at the
% same drug concentration, selected from [0, 0.03, 0.1, 0.3, 1, 3, 10, 30].
% There are 32 fields of view in each plate.  
% Some rows are empty, or just have empty cells in certain columns.