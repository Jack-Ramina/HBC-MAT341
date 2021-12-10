function [vec,t] = bubble_Sort(n,seed)
rng(seed)
vec = randi([1 1e9],n,1);     % Generate a random vector of size n
tic
for i = n:-1:2      % loop starting at the end until the second from the beginning
    for j = 1:i-1   % loop starting at the beginning until the second from the end
        if vec(j) > vec(j+1)    % compare the current index with the one to the right
            temp = vec(j);      % If the one on the left is larger, swap them
            vec(j) = vec(j+1);
            vec(j+1) = temp;
        end
    end
end
t = toc;