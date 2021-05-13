function [w, countCoRated]=eqSimJaccardR(activeUser, neighbor, item, statsRow, loopParams)
countCoRated = length(setdiff(intersect(find(activeUser), find(neighbor)), item));
countMerge   = length(union(find(activeUser), find(neighbor)));
w = countCoRated/countMerge;
end%end of function