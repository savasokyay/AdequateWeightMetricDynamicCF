function mainAutoTest
%	@func   mainAutoTest
%	@author @savasokyay	 
%	@date 	2020.06.03
%	@brief 	This script automates the test procedure for cascaded multiple times.
%           If you edit or use this code, please read and cite the following article.
%           Experimental Interpretation of Adequate Weight-Metric Combination for Dynamic User-Based Collaborative Filtering,
%			PeerJ Computer Science
%	@prerq  ...
%	@input  -
%	@output testResults file on output path
%

addpath('equations', 'statistics', '_version');
clear; clc;

%---------
%for executable tests, to organize how many instances are running simultaneously, give an id for each instance
%executable file names on current directory are searched on process tree. 
cntInstance = 0;
files = dir('*.exe');
for i=1:length(files)
    [status,list] = system(['tasklist /FI "imagename eq ', [files(i).name],'" /fo table /nh']);
    cntInstance = cntInstance + count(list,newline) - 1;
end
testInstanceName = num2str(cntInstance); 
%---------
disp('program started...');

dataset = '_sample-DummyDataset.mat';
%dataset = '_ml-100k.mat';
%dataset = '_ml-1m.mat';

ver=checkVersion();
dt = strsplit(dataset, ["-", "."]);
testName = ['AdeqWghtMtrc'...
    '_v', ver.Maj,'.', ver.Min,'.', ver.Rev, '_', dt{2}];

path = '..\testResultsAll\';
mkdir(path, testName);
path = [path, testName];

countTest = 50;
for testSetID = 1:countTest
    testParams = createTestCase(dataset, path, testSetID, testInstanceName);
    mainAuto(testParams);
    text = [num2str(testSetID), ' test set has been finished.'];
    disp(text);
end

end %end of function
