% MCEN 5125
% Homework 4
% Hanwen Zhao
% MEID: 650-703

clear all
close all
clc

% read the excel data
[~,~,food] = xlsread('DietProblemData.xlsx',1);
[~,~,nutrient] = xlsread('DietProblemData.xlsx',2);
% form the first third A matrix
% A1x >= bmin
% A1 needs to be negative since the default in linprog is <=
A1 = -1 * transpose(cell2mat(food(2:end,2:end-1)));
% form the second thrid A matrix
% A2x <= bmax
A2 = transpose(cell2mat(food(2:end,2:end-1)));
% form the last portion of the A matrix
% Ix >= 0
% Again the A3 needs to be negative
A3 = -1 * eye(length(A1));
% the f is the price of each item, we want to mininmize this
f = transpose(cell2mat(food(2:end,end)));
% the first part of the b is the minimum value of nutrients
% the b1 needs to be negative
b1 = -1 * cell2mat(nutrient(2:end,3:end-1));
% the second part of the b is the maximum value of nutrients
b2 = cell2mat(nutrient(2:end,end));
% the third part of the b matrix are zeros
b3 = zeros(length(A1),1);
% now we can form the final matrix
A = [A1;A2;A3];
b = [b1;b2;b3];
% call linprog
result = linprog(f,A,b);
% get the index and quantity of the food selection
index = find(result~=0)+1;
quantity = result(index-1);
% print the result
fprintf('In order to meet the nutrients requirements, the following items are selected: \n')
for i=1:length(index)
    fprintf('%4.2f serving of %s \n', quantity(i), food{index(i),1})
end
% calculate the final nutrient values
nutrientResult = -A*result;
nutrientResult = nutrientResult(1:11);
% print out the values
fprintf('\n\nThe final nutrient values contains \n')
fprintf('%4.2f cal Calories \n', nutrientResult(1))
fprintf('%4.2f mg Cholesterol \n', nutrientResult(2))
fprintf('%4.2f g Total_Fat \n', nutrientResult(3))
fprintf('%4.2f g Sodium \n', nutrientResult(4))
fprintf('%4.2f g Carbohydrates \n', nutrientResult(5))
fprintf('%4.2f g Dietary_Fiber \n', nutrientResult(6))
fprintf('%4.2f g Protein \n', nutrientResult(7))
fprintf('%4.2f IU Vitamin A \n', nutrientResult(8))
fprintf('%4.2f IU Vitamin C \n', nutrientResult(9))
fprintf('%4.2f mg Calcium \n', nutrientResult(10))
fprintf('%4.2f mg Iron \n', nutrientResult(11))

fprintf('\n\nThe total cost is %4.2f dollars.\n', f*result)