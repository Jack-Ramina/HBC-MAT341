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
% In this version, the biggest change was adding a second variable, the
% distance. Now that we had an optimization scheme for cost alone, we
% decided to see if we would be able to optimize two variables at the same
% time. With the second variable, there are a lot more possibilities. One
% possibility that required an important change was if the cost decreases a
% lot but the distance increases. We needed to figure out at what point an
% increase is too much. See the comments in good_Change_Finder for more
% information on that.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function simulated_Annealing3()
load('Cost_and_Distance_Matrices.mat')
B = DistMAT;    % Load the cost and distance matricies. Rename DistMAT to B for consistency
rng(98435)
% Because I am working as part of a team for this project, we all had an
% rng line with the same value so that we all had the same output and could
% troubleshoot easier.

guess = randperm(1000);     % Generate a random route
frac = 0.95;                % How much the temperature decreases by each iteration
tol = 1e-3;                 % ending temperature
temp = 1e4;                 % starting temperature
kC = 0.01;                  % constant used in the exponential step for cost
kD = 0.01;                  % constant used in the exponential step for distance
max_iter = 7500;            % how many times the inner loop runs
count = 0;                  % count variable

% These are values that are "Good" or "Bad" changes. If the cost decreases
% by more than 1.07% and the distance increases by less than 2.24% we keep
% the change. These vales come from good_Change_Finder
GCChange = 1.07;
BCChange = 1.92;
GDChange = 1.26;
BDChange = 2.24;

% cost_Func is no longer obsolete because the matrices A and B can be
% passed into it instead of initializing them each time they are called
cost = cost_Func(guess,A); 
dist = cost_Func(guess,B);

while temp > tol            % While the temperature is greater than the ending value, keep going
    for i = 1:max_iter      % iterate the inner loop 7500 times
        count = count + 1;  % increment the counter by one for each iteration
        
        guessTemp = guess;      % make a new guess
        q = randi(999);         % pick a random index and swap it with the one to the right
        swap = guessTemp(q);
        guessTemp(q) = guessTemp(q+1);
        guessTemp(q+1) = swap;
        
        newCost = cost_Func(guessTemp,A);   % find the new cost, change in cost, and ratio of change/original
        deltaC = newCost - cost;
        costRat = abs(deltaC/cost) * 100;
        newDist = cost_Func(guessTemp,B);   % do the same for distance
        deltaD = newDist - dist;
        distRat = abs(deltaD/dist) * 100;
        
        if deltaC < 0 && deltaD < 0     % if both the cost and distance decrease
            guess = guessTemp;          % keep the change
            cost = newCost;
            dist = newDist;
        elseif deltaC < 0 && costRat > GCChange && distRat < BDChange
% if the cost decreases by a substantial amount, and the distance does not
% increase by a substantial amount, keep the change
            guess = guessTemp;
            cost = newCost;
            dist = newDist;
        elseif deltaD < 0 && distRat > GDChange && costRat < BCChange
% if the distance decreases by a substantial amount, and the cost does not
% increase by a substantial amount, keep the change
            guess = guessTemp;
            cost = newCost;
            dist = newDist;
        else    % if none of these conditions are met, randomly decide to keep the change using simulated annealing
            exc = exp((-deltaC)/(kC*temp));     % as the temperature gets lower, it will be less likely to keep the change
            exd = exp((-deltaD)/(kD*temp));     % If the change is really big it will be less likely to keep the change
            rc = rand();                        % The reason we sometimes keep the change even if it is worse is because
            rd = rand();                        % we do not want to get stuck in a local minimum.
            if deltaC > 0 && rc < exc           % Ideally the worse cost or distance will kick us out of the minimum we are
                guess = guessTemp;              % stuck in so we can find the global minimum instead.
                cost = newCost;
                dist = newDist;
            elseif deltaD > 0 && rd < exd
                guess = guessTemp;
                cost = newCost;
                dist = newDist;
            end
        end
        
        costs(count) = cost;            % store the current cost in a vector
        dists(count) = dist;            % store the current distance in a vector
        counts(count) = count;          % store the count in a vector so it can be used to help plot
        total(count) = cost + dist;     % store the sum of cost and distance in a vector
    end
    temp = frac * temp;     % after iterating 7500 times, decreases the temperature
end
guess'                          % print the final route to the screen
finalCost = cost_Func(guess,A)  % print the final cost to the screen
finalDist = cost_Func(guess,B)  % print the final distance to the screen
tot = finalDist + finalCost     % print the sum of cost and distance to the screen

figure(1)   % plot cost and distance over each iteration
plot(counts,costs,'color','red'); hold on
plot(counts,dists,'color','blue'); hold off
legend('Cost','Distance')
xlabel('Iteration Number')
ylabel('Cost or Distance')

figure(2)   % plot the sum of the cost and distance over each iteration
plot(counts,total,'color','green','Linewidth',5)
xlabel('Iteration Number')
ylabel('Cost + Distance')
