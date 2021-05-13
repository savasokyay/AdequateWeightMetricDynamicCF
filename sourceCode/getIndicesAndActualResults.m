function [indiceResults, valueResults]=getIndicesAndActualResults(datasetRow, columnCount)
%	@func	getIndicesAndActualResults(datasetRow, columnCount)
%	@author @savasokyay
%	@date 	2019
%	@brief 	Randomly select X items for each row
%	@prerq  ...
%	@input  datasetRow, columnCount
%	@output indiceResults, valueResults
%
reset(RandStream.getGlobalStream,sum(100*clock));%make the randperm generates different numbers for each exe
nonZeroIndices  = find(datasetRow);
indiceResults   = randsample(nonZeroIndices,columnCount);
valueResults    = zeros(columnCount,1);
valueResults(:) = datasetRow(indiceResults(:));

end %end of function