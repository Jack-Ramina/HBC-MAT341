function [vec, t] = radix_Sort(n,seed)
rng(seed)
vec = randi([1 1e9],n,1);     % Generate a random vector of size n
tic
for i = 1:10
    c = [0 0 0 0 0 0 0 0 0 0];
    for j = 1:n
        x = floor(mod(vec(j),(10^i))/(10^(i-1)));
        c(x+1) = c(x+1) + 1;
        if x == 0
            zero(c(x+1)) = vec(j);
        elseif x == 1
            one(c(x+1)) = vec(j);
        elseif x == 2
            two(c(x+1)) = vec(j);
        elseif x == 3
            three(c(x+1)) = vec(j);
        elseif x == 4
            four(c(x+1)) = vec(j);
        elseif x == 5
            five(c(x+1)) = vec(j);
        elseif x == 6
            six(c(x+1)) = vec(j);
        elseif x == 7
            seven(c(x+1)) = vec(j);
        elseif x == 8
            eight(c(x+1)) = vec(j);
        elseif x == 9
            nine(c(x+1)) = vec(j);
        end
    end
    vec = [zero one two three four five six seven eight nine]';
    zero = [0];
    one = [0];
    two = [0];
    three = [0];
    four = [0];
    five = [0];
    six = [0];
    seven = [0];
    eight = [0];
    nine = [0];
end
vec = nonzeros(vec);
t = toc;