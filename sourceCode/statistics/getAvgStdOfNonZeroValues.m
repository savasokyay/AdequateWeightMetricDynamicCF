function [c, r, s]=getAvgStdOfNonZeroValues(vector)
%	@func   getAvgStdOfNonZeroValues(vector)
%	@author @savasokyay
%	@date 	2019
%	@brief 	Test parameters are defined and modified in this function
%	@prerq  see mainAuto.m and mainAutoTest.m
%	@input  vector (dataset row/column)
%	@output r (avg), s (std)

nonZeroValues = vector(find(vector)); 
c = length(nonZeroValues);
r = mean(nonZeroValues); 
s = std(nonZeroValues,1);

end %end of function