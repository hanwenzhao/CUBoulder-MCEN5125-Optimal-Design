% MCEN 5125
% Homework 4
% Hanwen Zhao
% MEID: 650-703

clear all
close all
clc
% Building constrain matrix from statics equations
A1 = [0,0,1,1,0,-1;
    0,0,-4,4,0,0;
    1,1,-1,0,-1,0;
    -8,8,-4,0,0,0];
A1 = [A1,zeros(4,4)];
% Add slack varibales so that tension is smaller than the maximum
A2 = [eye(4,6),eye(4,4)];
% combine the previous problem
A = [A1;A2];
% statics equations have 0 on rhs
b1 = zeros(4,1);
% define the maximum tensions
b2 = [120;160;100;100];
b = [b1;b2];
% -1 for W1 and W2 so we are minimize 
f = [zeros(4,1);-1;-1;zeros(4,1)];
% call linprog and set lower bound to 0
result = linprog(f,[],[],A,b,zeros(10,1),[]);
W1 = result(5)
W2 = result(6)