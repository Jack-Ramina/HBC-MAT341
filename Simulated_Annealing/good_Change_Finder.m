%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function is not directly used in the simulated annealing problem,
% but it is used to help find the "Good" and "Bad" change values used in
% the code. When the cost decreases by a large amount we want to keep the
% change, even if the distance increases a little bit. But what is a "large
% amount?" This script aims to find those amounts. It computes the ratio of
% change in cost over original cost (and distance) 100000 times and stores
% them in a vector, which is then sorted. The user can choose the top X% to
% be considered "Good." 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [goodCost,badCost,goodDist,badDist] = good_Change_Finder()
load('Cost_and_Distance_Matrices.mat')
rng(862379) 
v = randperm(1000);             % generate starting route
cost = cost_Func(v,A);          % starting cost
dist = cost_Func(v,DistMAT);    % starting function
pcc = 1;    % positive cost count
pdc = 1;    % positive distance count
ncc = 1;    % negative cost count
ndc = 1;    % negative distance count
for i = 1:100000        % iterate 100000 times
    q = randi(999);     % randomly choose an index and swap with the one to the right
    swap = v(q);
    v(q) = v(q+1);
    v(q+1) = swap;
    
    newCost = cost_Func(v,A);   % calculate new cost and distance
    newDist = cost_Func(v,DistMAT);
    deltaC = newCost - cost;    % calculate change in cost and distance
    deltaD = newDist - dist;
    if deltaC < 0                           % if the change in cost is negative
        costRatN(ncc) = deltaC/cost * 100;  % store the ratio in the negative cost vector
        ncc = ncc + 1;
    else
        costRatP(pcc) = deltaC/cost * 100;  % do the same for positive cost changes
        pcc = pcc + 1;
    end
    if deltaD < 0
        distRatN(ndc) = deltaD/cost * 100;  % and negative distance changes
        ndc = ndc + 1;
    else
        distRatP(pdc) = deltaD/cost * 100;  % and positive distance changes
        pdc = pdc + 1;
    end
    cost = newCost; % Set the old cost to the new cost so that each iteration we get the ratio to the previous cost, not the
    dist = newDist; % very first cost (and distance)
end

costRatN = sort(costRatN,'descend');    % sort so biggest negative changes are at the bottom of the vector
distRatN = sort(distRatN,'descend');    
costRatP = sort(costRatP);              % sort so biggest positive changes are at the bottom of the vector
distRatP = sort(distRatP);

a = 1:1:length(costRatN);   % create vectors that span the length of each ratio vector so they can be plotted
b = 1:1:length(distRatN);
c = 1:1:length(costRatP);
d = 1:1:length(distRatP);

figure(3)           % Plot each sorted ratio vector and a line at the chosen cutoff percentage
plot(a,costRatN); hold on
xline(length(costRatN) - ceil(length(costRatN)) * .33); hold off
title('Good change in cost')

figure(4)
plot(b,distRatN); hold on
xline(length(distRatN) - ceil(length(distRatN)) * .25); hold off
title('Good change in distance')

figure(5)
plot(c,costRatP); hold on
xline(length(costRatP) - ceil(length(costRatP)) * .25); hold off
title('Bad change in cost')

figure(6)
plot(d,distRatP); hold on
xline(length(distRatP) - ceil(length(distRatP)) * .1); hold off
title('Bad change in distance')

% Suppose we want the top 33% of cost decreases to count as "good." We take
% the length of the vector and subtract 33% of that. The value at that
% index will be the cutoff point. Anything below that point will be not big
% enough and anything above will be big enough.
goodCost = costRatN(length(costRatN) - ceil(length(costRatN) * 0.33));
goodDist = distRatN(length(distRatN) - ceil(length(distRatN) * 0.25));
badCost  = costRatP(length(costRatP) - ceil(length(costRatP) * 0.1));
badDist  = distRatP(length(distRatP) - ceil(length(distRatP) * 0.1));