function Pai=eqPreWeightedAverageOfDeviationsFromNeighborsMean(loopParams, bestNeighbors, ratingsItem, abbr, avgUsrRatings, dynamicMean_nIOI)
if(contains(abbr, 'nIOI'))
    avg = dynamicMean_nIOI;
else
    avg = avgUsrRatings(loopParams.currentRow);
end

Pai = avg + ...
    ((sum((ratingsItem(bestNeighbors(:,2)) - avgUsrRatings(bestNeighbors(:,2))) .* bestNeighbors(:,1)))/ ...
    sum(bestNeighbors(:,1)));
end