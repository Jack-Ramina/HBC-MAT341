%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This script aims to solve the travelling salesperson problem using
% simulated annealing. In this version of the travelling salesperson
% problem, the salesperson must visit all of 1000 cities. The cost to
% travel between any two cities is given in the matrix A. The goal is to
% travel to all 1000 cities while spending the least amount of money.
%
% Simulated annealing is used in this case to optimize the cost function.
% When searching for a global minimum across a function, it is possible to
% get trapped in a local minimum and be unaware that there is a different
% value with less cost. Simulated annealing tries to reduce that
% probability by occasionally accepting a value that is higher than the
% previous iteration in hopes of bumping the approximate minimum out of a
% local minimum and down into the global minimum.
%
% This is the first iteration of that code that was written and it does not
% work very well... It will get the job done eventually and it will do it
% right. The only problem is that it takes way to long to run. The reason
% for this is that an external script cost_Func was used. This script is
% called, which is 3 times per iteration for a total of 10500 times. Each
% time it is called it has to initialize a 1000x1000 matrix. The time it
% takes to initialize this matrix is minimal, but when it is repeated 10500
% times it really adds up.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function simulated_Annealing()

% initialzation
guess = 1:1:1000;   % Starting order of cities
frac = 7/8;         % How much the temperature decreases by each iteration  
tol = 10;           % ending temperature
temp = 1000;        % starting temperature
k = 0.0001;         % constant used in the exponential step
max_iter = 100;     % how many times the inner loop runs
count = 0;          % count variable

while temp > tol                    % keep iterating until the temperature reaches the specified tolerance
    for i = 1:max_iter              % iterate 100 times
        count = count + 1;          % increment the count variable once every iteration
        cost = cost_Func(guess);    % calculate the cost to travel with the current route
        
        % Make a new guess
        guessTemp = guess;          
        q = randi(999);         % Pick a random index and swap that one with the one to the right
        swap = guessTemp(q);
        guessTemp(q) = guessTemp(q+1);
        guessTemp(q+1) = swap;
        
        newCost = cost_Func(guessTemp);     % calculate the cost of the new guess
        deltaC = newCost - cost;            % Find the difference between the new and old cost
        
        if deltaC < 0           % If the cost decreases,
            guess = guessTemp;  % Then keep the change
        else                                % If the cost does not decrease, randomly decide to keep the change anyway
            ex = exp((-deltaC)/(k*temp));   % as the temperature gets lower, it will be less likely to keep the change
            r = rand();                     % If the change in cost is really bigm it will be less likely to keep the change
            if r < ex                       % The reason we sometimes keep the change even if it is worse is because
                guess = guessTemp;          % we do not want to get stuck in a local minimum.
            end                             % Ideally the worse cost will kick us out of the minimum we are stuck in so we can
        end                                 % find the global minimum instead.
        
        costs(count) = cost_Func(guess);    % store the current cost in a vector
    end
    temp = frac * temp;                     % After iterating 100 times, decrease the temperature
end
costs               % print the cost vector to screen
guess'              % print the final route to screen
cost_Func(guess)    % print the final cost to screen
