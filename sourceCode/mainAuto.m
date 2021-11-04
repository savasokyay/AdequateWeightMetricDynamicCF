function mainAuto(testParams)
%	@func   mainAuto(testParams)
%	@author @savasokyay	 
%	@date 	2020.08.24
%	@brief 	...
%           If you edit or use this code, please read and cite the following article.
%           Experimental Interpretation of Adequate Weight-Metric Combination for Dynamic User-Based Collaborative Filtering,
%			PeerJ Computer Science
%	@prerq  testParams parameter must be set manually or using createTestCase.m scirpt.
%	@input  testParams: ...
%	@output creates a results *.mat file at the end of test instance.
%

load(testParams.nameDataSet);
testParams.infoTiming.started = datestr(now, 'yy-mm-dd_HH.MM.SS.fff');
testParams.testSetIDstr = [testParams.testSetIDstr, '_(', testParams.infoTiming.started, ')'];

tic;
for a = 1:size(data.dataset,1)
    for i = 1:testParams.cntTestItemForEachRow
        for eq = 1:testParams.equationUserEntries.equationCount
            w(eq).wghts = -inf(1, 3); %weight, indexNegihbor, countCorated
        end
        for eq = 1:length(testParams.equationParams)
            loopParams.currentRow      = a;
            loopParams.currentColumn   = testParams.indicesofTestItems(a,i);
            loopParams.currentEquation = eq;
            
            vector = data.dataset(loopParams.currentRow,:);
            vector(loopParams.currentColumn) = 0;
            dynamicMean_nIOI = mean(vector(find(vector))); %nIOI contribution for Pearson Eqs in Prediction way, see sim eqs for sim way
            
            neighborWeightsForEquation = getNeighborsAllForEq(w, testParams, loopParams, data);
            if testParams.equationUserEntries.equationCount>=eq
                w(eq).wghts = neighborWeightsForEquation;
            end
            %testParams.equationParams(eq).resultNeighborCounts(a,i) = size(neighborWeightsForEquation,1);
            
            j=1;
            paiAllNeighbors=-inf;
            for idxBNC = 1:length(testParams.BNCs)
                bestNeighborCount = testParams.BNCs(idxBNC);
                if(0==bestNeighborCount)
                    rawPrediction = eqPreWeightedAverageOfDeviationsFromNeighborsMean(...
                        loopParams, neighborWeightsForEquation, ...
                        data.dataset(:,loopParams.currentColumn), ...
                        testParams.equationParams(eq).abbreviation, ...
                        data.avgUserRatings, dynamicMean_nIOI);
                    paiAllNeighbors = rawPrediction;
                elseif(bestNeighborCount<size(neighborWeightsForEquation,1))
                    bestNeighbors = neighborWeightsForEquation(1:bestNeighborCount,:);
                    rawPrediction = eqPreWeightedAverageOfDeviationsFromNeighborsMean(...
                        loopParams, bestNeighbors, ...
                        data.dataset(:,loopParams.currentColumn), ...
                        testParams.equationParams(eq).abbreviation, ...
                        data.avgUserRatings, dynamicMean_nIOI);
                elseif(bestNeighborCount>=size(neighborWeightsForEquation,1))
                    rawPrediction = paiAllNeighbors;
%                 else
%                     error('1.1 - this line should have never be executed!'); %TODO: Not critical at this time, maybe detailed later.
                end
                                
%                 if(bestNeighborCount ~= testParams.equationParams(eq).results(j).bestNeighborCount)
%                     error('1.2 - this line should have never be executed!'); %TODO: Not critical at this time, maybe detailed later.
%                 end               
%                 if testParams.equationParams(eq).results(j).bestNeighborCount ~= bestNeighborCount
%                     error('1.3 - this line should have never be executed!');
%                 end
                
                testParams.equationParams(eq).results(j).CalculatedRawResults(a, i) = rawPrediction;
                j=j+1;
            end %end of for bestNeighborCount
            printStatsProgress(testParams.path, testParams.testSetIDstr, toc, a, size(data.dataset,1), i, testParams.indicesofTestItems(a,i), testParams.cntTestItemForEachRow, eq, length(testParams.equationParams));
        end %end of for simEquations
    end %end of for cntTestItemForEachRow
end %end of for userCount

testParams.results = getTestResults(testParams, testParams.thresholdForOutputAnalysis);

testParams.infoTiming.ended = datestr(now, 'yy-mm-dd_HH.MM.SS');
elapsedTime = toc;
testParams.infoTiming.elapsedSec = elapsedTime;
text = ['Elapsed time is ', num2str(elapsedTime/60), ' minutes.'];
testParams.infoTiming.elapsedText = text;

%decreasing output size (MBs to KBs). Is there need to store predictions? Then comment below line.
testParams = rmfield(testParams, {'equationUserEntries', 'equationParams'});
save([testParams.path, '\', testParams.testSetIDstr, '.mat'], 'testParams');
disp(text);

end %end of function
