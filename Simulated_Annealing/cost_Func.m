%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This is the function that computes the cost and distance in the simulated
% annealing problem. It computes it as a rolling sum, adding the cost to go
% between city i and city i+1 each iteration. It now takes in the matrix
% instead of having to initialize it each time it is called
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cost = cost_Func(vec,A)
cost = 0;
for i = 1:length(vec)-1
    cost = cost + A(vec(i), vec(i+1));
end
