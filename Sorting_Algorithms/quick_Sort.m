function [vec, t] = quick_Sort(n,seed)
rng(seed)
vec = randi([1 1e9],n,1);     % Generate a random vector of size n
tic
part1 = vec(1);     % Choose a partition
c1 = 0;     % initialize 2 count variables
c2 = 0;
for i = 2:n     % start at 2 because we chose 1 to be our partition
    if vec(i) < part1   % if the value is less than the partition
        c1 = c1 + 1;
        left1(c1) = vec(i);     % put it to the left
    else
        c2 = c2 + 1;
        right1(c2) = vec(i);    % otherwise put it to the right
    end
end

c1 = 0;     % Repeat this 6 more times in a binary fashion. At the end we will have 8 smaller arrays
c2 = 0;
part2 = left1(1);
for i = 2:length(left1)
    if left1(i) < part2
        c1 = c1 + 1;
        left2(c1) = left1(i);
    else
        c2 = c2 + 1;
        right2(c2) = left1(i);
    end
end

c1 = 0;
c2 = 0;
part3 = right1(1);
for i = 2:length(right1)
    if right1(i) < part3
        c1 = c1 + 1;
        left3(c1) = right1(i);
    else
        c2 = c2 + 1;
        right3(c2) = right1(i);
    end
end

c1 = 0;
c2 = 0;
part4 = left2(1);
for i = 2:length(left2)
    if left2(i) < part4
        c1 = c1 + 1;
        left4(c1) = left2(i);
    else
        c2 = c2 + 1;
        right4(c2) = left2(i);
    end
end

c1 = 0;
c2 = 0;
part5 = right2(1);
for i = 2:length(right2)
    if right2(i) < part5
        c1 = c1 + 1;
        left5(c1) = right2(i);
    else
        c2 = c2 + 1;
        right5(c2) = right2(i);
    end
end

c1 = 0;
c2 = 0;
part6 = left3(1);
for i = 2:length(left3)
    if left3(i) < part6
        c1 = c1 + 1;
        left6(c1) = left3(i);
    else
        c2 = c2 + 1;
        right6(c2) = left3(i);
    end
end

c1 = 0;
c2 = 0;
part7 = right3(1);
for i = 2:length(right3)
    if right3(i) < part7
        c1 = c1 + 1;
        left7(c1) = right3(i);
    else
        c2 = c2 + 1;
        right7(c2) = right3(i);
    end
end

left4 = insertion_Call(left4)';     % With the 8 small arrays use insertion sort to sort them individually
right4 = insertion_Call(right4)';
left5 = insertion_Call(left5)';
right5 = insertion_Call(right5)';
left6 = insertion_Call(left6)';
right6 = insertion_Call(right6)';
left7 = insertion_Call(left7)';
right7 = insertion_Call(right7)';

vec = [left4; part4; right4; part2; left5; part5; right5; part1; left6; part6; right6; part3; left7; part7; right7];
% Combine all of the smaller sorted arrays (as well as the partitions) into
% one sorted array
t = toc;