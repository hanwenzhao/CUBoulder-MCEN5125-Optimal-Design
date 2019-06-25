% MCEN 5125
% Homework #1 Brute Force
% Hanwen Zhao
% MEID: 650-703

%% Problem 2

% Assume we use all the material to produce A, the maximum number of A we
% can produce is 33 due to the total number of nickel we have
% Also assume we use all the material to produce B, the maximum number of B
% we can produce is 33 due to the total number of nickel we have
% Agian for C, the maximum number of C we can produce is 25 due to the
% limitation of steel
% First we want to loop throught all the possible combination, elimate
% those impossible cases: use more nickel or steel than we have
% find the maximum profit we can have throughout all the cases

% 3A+3B+1C <= 100
% 4A+2B+8C <= 200

maxP = 0;
for A = 0:33
    for B = 0:33
        for C = 0:25
            % the material left could not be negative
            nickel = 100 - 3*A - 3*B - 1*C;
            steel = 200 - 4*A - 2*B - 8*C;
            if (nickel >= 0) && (steel >=0)
                % calcualte profit
                P = 10*A + 5*B + 15*C;
                if P > maxP
                    % if current profit is greater
                    maxP = P;
                    % store final values
                    Af = A; Bf = B; Cf = C;
                end
            end
        end
    end
end

fprintf('To maximize the profits, %d widgets of A will be produced, %d widgets of C will be produced, %d widgets of C will be produced, the final profit is %d.\n',Af,Bf,Cf,maxP)


%% Problem 3
% Use the same method of problem 2
% Assme we only use feed1, in order to meet the requirement, we need at
% least 24 units; assume we only use feed2, we need at least 42 bags
% Loop throught all possible cases, but elimate cases which nutrients
% requirements do no meet

% start an estimation on minimum cost 
minCost = 24*10;
% loop through all possible cases
for feed1 = 1:24
    for feed2 = 1:42
        % calculate the nutrients requirements
        A = 60 - 3*feed1 - 2*feed2;
        B = 84 - 7*feed1 - 2*feed2;
        C = 72 - 3*feed1 - 6*feed2;
        if (A <= 0) && (B <= 0) && (C <= 0)
            % if the all the requirements all meet
            cost = 10*feed1 + 4*feed2;
            if cost < minCost
                % if current cost is smaller
                minCost = cost;
                feed1f = feed1;
                feed2f = feed2;
            end
        end
    end
end

fprintf('To minimize the costs, %d units of feed 1 will be used, %d units of feed 2 will be used, the final cost is %d.\n',feed1f,feed2f,minCost)

