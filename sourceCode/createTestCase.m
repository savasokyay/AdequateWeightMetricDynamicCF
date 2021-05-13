function testParams = createTestCase(dataset, path, testSetID, testInstanceName)
%	@func 	createTestCase(dataset, path, testSetID, testInstanceName)
%	@author @savasokyay, @sercanaygun
%	@date 	2020.08.27
%	@brief 	Test parameters are defined and modified in this function
%	@prerq  see mainAuto.m and mainAutoTest.m
%	@input  dataset   : which predefined dataset
%           path      : file path
%           testSetID : numerical task id
%           tes...Name: this parameter is used to identify which run on parallel runs
%	@output testParams: whole test parameters to run automatized
%

%----------------------Enter Test Equations Manually----------------------%
% All 'sigWei=0's must be computed at first (param = -1), and then variable tests can be executed quickly over pre-calculated values
% {'Standard Pearson','PCC';'Median-Based Robust','MRC';'Standard Cosine','COS';'Standard Jaccard','JAC'}
equationSimFunctions = {'PCC','PCCnIOI','MRC','MRCnIOI','COS','COSnIOI','JAC','JACnIOI','PCC','PCCnIOI','MRC','MRCnIOI','COS','COSnIOI','JAC','JACnIOI'};
sigWeCoRatedCount    = [   -1,       -1,   -1,       -1,   -1,       -1,   -1,       -1, -Inf,     -Inf, -Inf,     -Inf, -Inf,     -Inf, -Inf,    -Inf];
%-------------------------------------------------------------------------%

eqCount = length(unique(equationSimFunctions)); %this is the original eq count to handle not significant operations

testParams.nameDataSet = dataset;
testParams.path = path;
testParams.testSetID = testSetID;
testParams.testSetIDstr = [getenv('COMPUTERNAME'), '-', testInstanceName, '-', num2str(testSetID, '%03i')];
testParams.infoTiming.started = -1;
testParams.infoTiming.ended = -1;
testParams.infoTiming.elapsedSec = -1;
testParams.infoTiming.elapsedText = '';

testParams.BNCs = 0:1:100;

testParams.cntTestItemForEachRow = 5;      %test item count for each row -> 5

load(testParams.nameDataSet);
testParams.indicesofTestItems = zeros(size(data.dataset,1),testParams.cntTestItemForEachRow);
testParams.ActualResultsofIndices = zeros(size(data.dataset,1),testParams.cntTestItemForEachRow);
for i = 1:size(data.dataset,1)
    [testParams.indicesofTestItems(i,:), testParams.ActualResultsofIndices(i,:)] = ...
        getIndicesAndActualResults(data.dataset(i,:), testParams.cntTestItemForEachRow);
end

reset(RandStream.getGlobalStream,sum(100*clock));%make the randperm generates different numbers for each exe
testParams.cntKFold = 10;                  
testParams.KFoldIndices = crossvalind('Kfold',size(data.dataset,1),testParams.cntKFold);
testParams.thresholdForOutputAnalysis = 3.5; 

load _definitionSimilarityEquations;
testParams.equationUserEntries.equationCount        = eqCount;
testParams.equationUserEntries.equationSimFunctions = equationSimFunctions;
testParams.equationUserEntries.sigWeCoRatedCount    = sigWeCoRatedCount;
for i=1:length(equationSimFunctions)
    defeq = find(strcmp(equationSimFunctions{i},{definitionSimilarityEquations.abbreviation}));
    if isempty(defeq)
        textErr = ['Abbr(', num2str(i), ')=',equationSimFunctions{i},' is not a compatible abbreviation.'];
        textErr = [textErr, newline, 'Check your test parameters.'];
        textErr = [textErr, newline, 'See equations\_definitionSimilarityEquations for details.'];
        error(textErr);
    end
    testParams.equationParams(i).equationName         = definitionSimilarityEquations(defeq).equationName;
    testParams.equationParams(i).abbreviation         = definitionSimilarityEquations(defeq).abbreviation;
    if -1 == sigWeCoRatedCount(i)
        testParams.equationParams(i).functionName         = definitionSimilarityEquations(defeq).functionName;
        testParams.equationParams(i).functionType         = definitionSimilarityEquations(defeq).functionType;
        testParams.equationParams(i).overrideEquation     = definitionSimilarityEquations(defeq).overrideEquation;
        testParams.equationParams(i).functionExplanation  = definitionSimilarityEquations(defeq).functionExplanation;
    else
        testParams.equationParams(i).functionName         = '-';
        testParams.equationParams(i).functionType         = 2;
        testParams.equationParams(i).overrideEquation     = '-';
        testParams.equationParams(i).functionExplanation  = 'overrides weights via SigWeight method';
    end
    testParams.equationParams(i).sigWeCoRatedCount    = sigWeCoRatedCount(i);
    %testParams.equationParams(i).resultNeighborCounts = -Inf(size(data.dataset,1), testParams.cntTestItemForEachRow);
    
    j=1;
    for idxBNC = 1:length(testParams.BNCs)
        testParams.equationParams(i).results(j).bestNeighborCount = testParams.BNCs(idxBNC);
        testParams.equationParams(i).results(j).CalculatedRawResults = inf(size(data.dataset,1), testParams.cntTestItemForEachRow);
        j=j+1;
    end
end %end of for

testParams.countEqNotOverrided = length(find(0==[testParams.equationParams.functionType]));
testParams.results = [];
testParams.errors = 0;
end %end of function