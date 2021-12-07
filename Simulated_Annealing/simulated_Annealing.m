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
% This is the second iteration of the code. A number of things were added
% and edited. The most important was the cost_Func function was removed.
% Instead of calling the function every time the cost has to be computed
% and creating the 1000x1000 matrix every time, the 1000x1000 matrix is
% loaded once at the beginning of the script and the cost is calculated
% multiple times throughout the script. A few other smaller things were
% changed as well, which will be discussed in the comments in the code
% itself.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function simulated_Annealing()
load('Cost_Matrix.mat')     % Load the cost matrix once at the beginning of the script to minimize run time
rng(30)
% Because I am working as part of a team for this project, we all had an
% rng line with the same value so that we all had the same output and could
% troubleshoot easier.

% initialization
guess = randperm(1000);     % Generate a random route instead of going 1-1000
frac = 0.9;                 % How much the temperature decreases by each iteration
tol = 1e-3;                 % ending temperature
temp = 1e3;                 % starting temperature
k = 0.01;                   % constant used in the exponential step
max_iter = 5000;            % how many times the inner loop runs
count = 0;                  % count variable

% calculate the cost of a specific route. This snip of code will be used
% many times throughout the program. This was originally in cost_Func
cost = 0;   % Rolling sum starting at 0
for j = 1:length(guess)-1   % iterate over every combination of adjascent cities
    cost = cost + A(guess(j), guess(j+1));  % Add the cost to travel between those cities to the rolling sum
end
        
while temp > tol            % keep iterating until the temperature reaches the specified tolerance
    for i = 1:max_iter      % run the inner loop 5000 times
        count = count + 1;  % increment the count variable once every iteration
        
        % make a new guess
        guessTemp = guess;
        q = randi(999);         % pick a random index and swap it with the one to the right
        swap = guessTemp(q);
        guessTemp(q) = guessTemp(q+1);
        guessTemp(q+1) = swap;
        
        newCost = 0;    % calculate the cost of the new guess
        for m = 1:length(guessTemp)-1
            newCost = newCost + A(guessTemp(m),guessTemp(m+1));
        end
        deltaC = newCost - cost;    % find the difference between the new and old cost
        
        if deltaC < 0           % If the cost decreases
            guess = guessTemp;  % keep the new guess
            cost = newCost;     % replace the cost so it does not need to be recalculated
        else                                % If the cost does not decrease, randomly decide to keep the change anyway
            ex = exp((-deltaC)/(k*temp));   % as the temperature gets lower, it will be less likely to keep the change
            r = rand();                     % If the change in cost is really bigm it will be less likely to keep the change
            if r < ex                       % The reason we sometimes keep the change even if it is worse is because
                guess = guessTemp;          % we do not want to get stuck in a local minimum.
                cost = newCost;             % Ideally the worse cost will kick us out of the minimum we are stuck in so we can
            end                             % find the global minimum instead.
        end
        
        costs(count) = cost;    % store the current cost in a vector
        counts(count) = count;  % store the current count in a vector
    end
    temp = frac * temp;         % After iterating 5000 times, decrease the temperature
end
guess'              % print the final route to the screen
costs(count)        % print the final cost to the screen

figure(1)
plot(counts,costs)  % plot the cost as time goes on
