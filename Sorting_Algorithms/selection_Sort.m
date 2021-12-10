function [vec, t] = selection_Sort(n,seed)
rng(seed)
vec = randi([1 1e9],n,1);     % Generate a random vector of size n
tic
for i = 1:n-1
    ind = i;
    for j = i:n
        min = vec(ind);
        if vec(j) < vec(ind)
            ind = j;
        end
    end
    temp = vec(i);
    vec(i) = vec(ind);
    vec(ind) = temp;
end
t = toc;