%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% The problem of the week proposed in the math department is as follows:
% The numbers 1-16 can be arranged in a sequence such that the sum of each 
% pair of numbers adds up to a square number. This function attempts to
% find the correct order of the sequence without randomly guessing.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sequence = potw2()
sequence = [ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];     % Create a sequence vector with nothing of importance in it
for i = 1:16    % find the sum of each possible pair
    for j = 1:16
        Mat(i,j) = mod(sqrt(i+j),1) + 1;    % If it is a perfect square, the output will be exactly 1
        if Mat(i,j) ~= 1    % If it is not 1, (it is not a perfect square)
            Mat(i,j) = 0;   % Then set it to zero
        end
    end
end
for i = 1:16
    Mat(i,i) = 0;   % Set the diagonals to zero because you can't use the same value twice for example, even though 2+2 is a perfect square
end
Mat
for i = 1:16
    if sum(Mat(i,:)) == 1   % Find the rows where there is only one pairing that adds up to a perfect square
        singles(i) = i;     % Logically there should only be two because the sequence will only have two values at the ends
    else
        singles(i) = 0;     % Set everything else to zeros because they are not important
    end
end

singles = nonzeros(singles);    % Remove the zeros so only the important values are still there
sequence(1) = singles(1);       % Set the first and last values in the sequence to the two special values we found
sequence(16) = singles(2);

for i = 1:16
    if Mat(sequence(1),i) == 1  % Find the second value of the sequence. This should be the only value that works with the first
        sequence(2) = i;
    end
    if Mat(sequence(16),i) == 1 % Find the 15th value of the sequence. This should be the only value that works with the 16th
        sequence(15) = i;
    end
end

for i = 3:14    % Find the rest of the values
    for j = 1:16
        if Mat(sequence(i-1),j) == 1    % Find where the value to the left of the current value is part of a pair
            if j ~= sequence(i-2)       % If it is not the same pair as the one previously found
                sequence(i) = j;        % Then it is the next value
            else                        % Otherwise don't do anything
            end
        end
    end
end