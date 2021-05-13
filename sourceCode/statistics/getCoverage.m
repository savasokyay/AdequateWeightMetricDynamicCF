function result=getCoverage(RawResults)
result = 1 - (sum(sum(isnan(RawResults)))/(size(RawResults,1) * size(RawResults,2)));
end %end of function