function [w, countCoRated]=eqSimCosine(activeUser, neighbor, item, statsRow, loopParams)
countCoRated = length(intersect(find(activeUser), find(neighbor)));
w = dot(activeUser,neighbor)/(norm(activeUser)*norm(neighbor));
end%end of function