%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% The problem of the week proposed in the math department is as follows:
% The numbers 1-16 can be arranged in a sequence such that the sum of each 
% pair of numbers adds up to a square number. This function attempts to
% find the correct order of the sequence by randomizing the sequence until
% it is correct.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sequence = potw()
sequence = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];    % The values 1-16
correct = false;    % Create a variable for the while loop
while correct == false  % While the sequence is incorrect
    sequence = sequence(randperm(length(sequence)));    % Randomize the range
    for i = 1:15
        x(i) = mod(sqrt(sequence(i)+sequence(i+1)),1);  % Create a vector of decimals of square roots of sums of subsequent values
    end     % Perfect squares should have 0 decimals
    if x == [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]     % If they're all zeros, they're all squares
        correct = true;     % Then it is correct
    end
end

% This function will eventually work, however it will be very slow and will
% require a lot of computing power. There are 20 trillion arrangements for
% the numbers 1-16, and only two of them are correct. There is probably a
% better way to solve this.
