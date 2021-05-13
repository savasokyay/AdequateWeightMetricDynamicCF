function [w, countCoRated]=eqSimJaccard(activeUser, neighbor, item, statsRow, loopParams)
countCoRated = length(intersect(find(activeUser), find(neighbor)));
countMerge   = length(union(find(activeUser), find(neighbor)));
w = countCoRated/countMerge;
end%end of function