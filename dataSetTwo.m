% dataSetTwo.m
% Steve Ryan, started 3/21/2017

% from inspecting the data manually in Excel, Plates 1 & 2 are RT, plates 3
% & 4 are 32 C.  Most FOVs have multiple measurements, but all are at the
% same drug concentration, selected from [0, 0.03, 0.1, 0.3, 1, 3, 10, 30].
% There are 32 fields of view in each plate.  
% Some rows are empty, or just have empty cells in certain columns.  We'll
% have to cull those at the appropriate time.
clear all;
data = readtable('sampleFeatureMatrix.csv');

%% Manual Data Segmentation

% There are for sure more graceful ways to do this in R, but in Matlab I
% have traditionally generated my own tables in ways that didn't need
% segmentation like this to examine, so I've never learned this corner of
% Matlab.  Hence, I'm doing it the ugly way =)

dataRT = data(ismember(data.Temperature,'RT','rows'),:);
data32 = data(ismember(data.Temperature,'32 C','rows'),:);

dataRT_0   = dataRT(ismember(dataRT.Concentration1,'0 uM','rows'),:);
dataRT_003 = dataRT(ismember(dataRT.Concentration1,'0.03 uM','rows'),:);
dataRT_01  = dataRT(ismember(dataRT.Concentration1,'0.1 uM','rows'),:);
dataRT_03  = dataRT(ismember(dataRT.Concentration1,'0.3 uM','rows'),:);
dataRT_1   = dataRT(ismember(dataRT.Concentration1,'1 uM','rows'),:);
dataRT_3   = dataRT(ismember(dataRT.Concentration1,'3 uM','rows'),:);
dataRT_10  = dataRT(ismember(dataRT.Concentration1,'10 uM','rows'),:);
dataRT_30  = dataRT(ismember(dataRT.Concentration1,'30 uM','rows'),:);

data32_0   = data32(ismember(data32.Concentration1,'0 uM','rows'),:);
data32_003 = data32(ismember(data32.Concentration1,'0.03 uM','rows'),:);
data32_01  = data32(ismember(data32.Concentration1,'0.1 uM','rows'),:);
data32_03  = data32(ismember(data32.Concentration1,'0.3 uM','rows'),:);
data32_1   = data32(ismember(data32.Concentration1,'1 uM','rows'),:);
data32_3   = data32(ismember(data32.Concentration1,'3 uM','rows'),:);
data32_10  = data32(ismember(data32.Concentration1,'10 uM','rows'),:);
data32_30  = data32(ismember(data32.Concentration1,'30 uM','rows'),:);

