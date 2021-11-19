function simulated_Annealing()

guess = 1:1:1000;
frac = 7/8;
tol = 10;
temp = 1000;
k = 0.0001;
max_iter = 100;
count = 0;

while temp > tol
    for i = 1:max_iter
        count = count + 1;
        cost = cost_Func(guess);
        
        guessTemp = guess;
        q = randi(999);
        swap = guessTemp(q);
        guessTemp(q) = guessTemp(q+1);
        guessTemp(q+1) = swap;
        
        newCost = cost_Func(guessTemp);
        deltaC = newCost - cost;
        
        if deltaC < 0
            guess = guessTemp;
        else
            ex = exp((-deltaC)/(k*temp));
            r = rand();
            if r < ex
                guess = guessTemp;
            end
        end
        
        costs(count) = cost_Func(guess);
    end
    temp = frac * temp;
end
costs
guess'
cost_Func(guess)
