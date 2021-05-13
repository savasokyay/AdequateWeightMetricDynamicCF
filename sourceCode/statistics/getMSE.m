function result=getMSE(actual, calculated)

indexNaNs = find(isnan(calculated));
countNaN  = length(indexNaNs);
actualNotNaN            = actual;
actualNotNaN(indexNaNs) = -1;
calculatedNotNaN            = calculated;
calculatedNotNaN(indexNaNs) = -1;

result = (sum(sum((actualNotNaN-calculatedNotNaN).^2))) / ...
    ((size(actual,1) * size(actual,2))-countNaN);
%mse(actualNotNaN, calculatedNotNaN);%predefined matlab function but there are NaNs
end %end of function