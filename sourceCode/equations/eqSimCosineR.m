function [w, countCoRated]=eqSimCosineR(activeUser, neighbor, item, statsRow, loopParams)
countCoRated = length(setdiff(intersect(find(activeUser), find(neighbor)), item));
activeUser(item) = 0;
w = dot(activeUser,neighbor)/(norm(activeUser)*norm(neighbor));
end%end of function