function sortedWeights=getNeighborsAllForEq(w, testParams, loopParams, data)
%	@func   getNeighborsAllForEq(w, testParams, loopParams, data)
%	@author @savasokyay	 
%	@date 	2020.08.24
%	@brief 	This function computes all weights for each (a,u) pair via predefined similarity equations.
%           If you edit or use this code, please read and cite the following article.
%           Experimental Interpretation of Adequate Weight-Metric Combination for Dynamic User-Based Collaborative Filtering,
%			PeerJ Computer Science
%	@prerq  testParams parameter must be passed.
%	@input  w           : precalculated different equation weights for the same (a, u) pair. This is useful for overriding the weights.
%           testParams  : ...
%           loopParams  : for which a, u, i, eq
%           data        : input rating matrix
%	@output creates a results *.mat file at the end of test instance.
%

if(-1 == testParams.equationParams(loopParams.currentEquation).sigWeCoRatedCount) %no sigWeighting
    if(0 == testParams.equationParams(loopParams.currentEquation).functionType) %compute from zero
        neighborsTrain = intersect(find(data.dataset(:,loopParams.currentColumn)), ...
            find(testParams.KFoldIndices(loopParams.currentRow) ~= testParams.KFoldIndices));
        weights = zeros(length(neighborsTrain), 3); %weight, indexNegihbor, countCorated
        
        for index = 1:length(neighborsTrain)
            u = neighborsTrain(index);
            loopParams.currentNeighbor = u;
            eval(['[weight, countCoRated] = ', ...
                testParams.equationParams(loopParams.currentEquation).functionName, '(', ...
                'data.dataset(loopParams.currentRow,:),', ...
                'data.dataset(loopParams.currentNeighbor,:),', ...
                'loopParams.currentColumn,', ...
                'data.statsRow,', ...
                'loopParams);']);
            
            weights(index,1) = weight;
            weights(index,2) = u;
            weights(index,3) = countCoRated;
        end
    else %override standard sim weights
        ovrdEq = min(find(strcmp({testParams.equationParams.abbreviation}, ...
            testParams.equationParams(loopParams.currentEquation).overrideEquation)));
        eval(['weights = ', ...
            testParams.equationParams(loopParams.currentEquation).functionName, ...
            '(w(', num2str(ovrdEq),').wghts, testParams, loopParams, data);']);
    end %end if
else %Significance Weighting
    weights = w(min(find(strcmp({testParams.equationParams.abbreviation}, ...
            testParams.equationParams(loopParams.currentEquation).abbreviation)))).wghts;
    sigWeCoRatedCount=testParams.equationParams(loopParams.currentEquation).sigWeCoRatedCount;
    if -Inf==sigWeCoRatedCount
        weights(:,1) = weights(:,1) .* weights(:,3);
    else
        if(1>sigWeCoRatedCount)%Special condition, improvised
            sigWeCoRatedCount = round(sigWeCoRatedCount*2*mean(weights(:,3)));
            if(isnan(sigWeCoRatedCount) || ~sigWeCoRatedCount)
                sigWeCoRatedCount = 1;
            end
        end
        sigWeCoRatedRates = weights(:,3)/sigWeCoRatedCount;
        sigWeCoRatedRates(find(sigWeCoRatedRates>1), 1) = 1;
        weights(:,1) = weights(:,1) .* sigWeCoRatedRates;  
    end
end
weights(find(isnan(weights(:,1))),:)=[]; %Eliminate row
sortedWeights(:,:) = flipud(sortrows(weights(1:max(find(weights(:,2)~=0)),:)));
end %end of function
