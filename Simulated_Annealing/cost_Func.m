function cost = cost_Func(vec)
load('Cost_Matrix.mat')
cost = 0;
for i = 1:length(vec)-1
    cost = cost + A(vec(i), vec(i+1));
end
