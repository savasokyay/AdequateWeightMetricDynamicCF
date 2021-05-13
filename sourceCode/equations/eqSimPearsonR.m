function [w, countCoRated]=eqSimPearsonR(actveUsr, neighbor, item, statsRow, loopParams)
ratingsCommon = setdiff(intersect(find(actveUsr), find(neighbor)), item);
countCoRated = length(ratingsCommon);

meanAc = mean(actveUsr(setdiff(find(actveUsr),item)));
meanNg = mean(neighbor(find(neighbor)));

w = (...
    (actveUsr(ratingsCommon)-meanAc) * ...
    (neighbor(ratingsCommon)-meanNg)' ...
    ) / ( ...
    sqrt(sum((actveUsr(ratingsCommon)-meanAc) .^2)) *...
    sqrt(sum((neighbor(ratingsCommon)-meanNg) .^2)) ...
    );
end %end of function