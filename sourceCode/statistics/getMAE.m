function result=getMAE(actual, calculated)

indexNaNs = find(isnan(calculated));
countNaN  = length(indexNaNs);
actualNotNaN            = actual;
actualNotNaN(indexNaNs) = -1;
calculatedNotNaN            = calculated;
calculatedNotNaN(indexNaNs) = -1;

result = sum(sum(abs(actualNotNaN - calculatedNotNaN))) / ...
    ((size(actual,1) * size(actual,2))-countNaN);
%mae(actualNotNaN, calculatedNotNaN); %predefined matlab function but there are NaNs
end %end of function