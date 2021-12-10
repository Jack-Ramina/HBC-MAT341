function [vec, t] = insertion_Sort(n,seed)
rng(seed)
vec = randi([1 1e9],n,1);     % Generate a random vector of size n
tic
if vec(1) > vec(2)      % Complete the initial comparisson before the loops
    temp = vec(1);      % so that you do not start and end a for loop at
    vec(1) = vec(2);    % the same number
    vec(2) = temp;
end

for i = 3:n             % Start at the third value and work your way to the right
    for j = i:-1:2      % compare it to everything to its left.
        if vec(j) < vec(j-1)    % If it is less than what it is being compared to
            temp = vec(j);      % swap them
            vec(j) = vec(j-1);
            vec(j-1) = temp;
        else        % otherwise, move onto the next index to the right
            break
        end
    end
end     
t = toc;