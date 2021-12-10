function [vec, t] = bogo_Sort(n,seed)
rng(seed)
vec = randi([1 1e9],n,1)     % Generate a random vector of size n
tic
unsorted = true;
while unsorted
    vec = vec(randperm(length(vec)));    % Randomize the range
    count = 0;
    for i = 1:n-1
        if vec(i) < vec(i+1)
            count = count + 1;
        end
    end
    if count == n-1
        unsorted = false;
    end
end
t = toc;