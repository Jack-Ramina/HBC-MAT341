function simulated_Annealing2()
load('Cost_Matrix.mat')
rng(30)

guess = randperm(1000);
frac = 0.975;
tol = 1e-3;
temp = 1e3;
k = 0.01;
max_iter = 10000;
count = 0;

cost = 0;
for j = 1:length(guess)-1
    cost = cost + A(guess(j), guess(j+1));
end
        

while temp > tol
    for i = 1:max_iter
        count = count + 1;
        
        guessTemp = guess;
        q = randi(999);
        swap = guessTemp(q);
        guessTemp(q) = guessTemp(q+1);
        guessTemp(q+1) = swap;
        
        newCost = 0;
        for m = 1:length(guessTemp)-1
            newCost = newCost + A(guessTemp(m),guessTemp(m+1));
        end
        deltaC = newCost - cost;
        
        if deltaC < 0
            guess = guessTemp;
            cost = newCost;
        else
            ex = exp((-deltaC)/(k*temp));
            r = rand();
            if r < ex
                guess = guessTemp;
                cost = newCost;
            end
        end
        
        costs(count) = cost;
        counts(count) = count;
    end
    temp = frac * temp;
end
guess'
cost_Func(guess)

figure(1)
plot(counts,costs)