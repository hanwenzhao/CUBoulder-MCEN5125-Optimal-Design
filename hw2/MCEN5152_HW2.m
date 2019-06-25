% MCEN 5125
% Homework #2
% Hanwen Zhao
% MEID: 650-703
close all;clear all;clc;
%% Problem 2
% problem a
fprintf('Problem 2(a)\n')
% import A and Ides
[A, Ides] = HW2Prob2();
% generate b
b = ones(size(A,1),1) .* Ides;
% calculare x by using least square
x = A\b;
% x must between 0 and 1
x_hat = x;
x_hat(x>1) = 1; x_hat(x<0) = 0;
fprintf('The solutuon is \n')
transpose(x)
fprintf('After correction \n')
transpose(x_hat)
% calculate resulting value of the cost function
I = A * x_hat;
cost = sum((I - Ides).^2);
fprintf('The resulting value of the cost function is %4.2f.\n',cost)
% problem b
fprintf('Problem 2(b)\n')
% generate a diagonal matrix
d = ones(1,size(A,2));
D = diag(d);
b2 = ones(size(A,2),1) * 0.5;
% form new matrix and loop through to find x
mu = 1;
while 1
    newA = [A;mu.*D];
    newB = [b;mu*b2];
    newX = newA \ newB;
    if all(0<=newX) && all(newX<=1)
        break
    else
        mu = mu + 1;
    end
end
fprintf('The solutuon is \n')
transpose(newX)
fprintf('When mu = %d, the solutiuon satisfiy all 0<=x<=1.\n', mu)
% calucate new cost function
newI = A * newX;
newCost = sum((newI - Ides).^2);
fprintf('The resulting value of the new cost function is %4.2f.\n',newCost)

%% Problem 3
xcor = HW2Prob3;
% generate matrix
x = [1:size(xcor,1)];
mu = 1;
z = zeros(999,1);
D = sparse(999,1000);
D(:,1:999) =  -speye(999);
D(:,2:1000) =  D(:,2:1000) + speye(999);
I = eye(1000);
% use 8.10 to solve
A = [I; sqrt(mu)*D];
b = [xcor;z];
x1 = A\b;
% plot with different method and differen mu
subplot(2,2,1)
hold on
plot(x,xcor)
plot(x,x1)
title('mu = 1 with 8.10')

subplot(2,2,2)
hold on
plot(x,xcor)
plot(x,xhat(1))
title('mu = 1 with 8.11')

subplot(2,2,3)
hold on
plot(x,xcor)
plot(x,xhat(100))
title('mu = 100 with 8.11')

subplot(2,2,4)
hold on
plot(x,xcor)
plot(x,xhat(10000))
title('mu = 10000 with 8.11')

fprintf(['From the plot we can see that as mu increase, the solution gets\n'...
    ' more smooth, however with a large smooth factor, the solution loose its accuracy.'])

%% Problem 4
fprintf('Problem 4\n')
[u, v] = HW2Prob4;
% form matrix
A4 = [2*u, 2*v, ones(size(u,1),1)*-1];
b4 = u.^2+v.^2;
% use least square to calculate solutions
sol = A4\b4;
uc = sol(1,1); vc = sol(2,1); w = sol(3,1);
R = sqrt(uc^2 + vc^2 - w);
% plot the data points and solution
figure
t = linspace(0, 2*pi, 1000);
plot(u, v, 'o', R*cos(t)+uc, R*sin(t)+vc,'-')
fprintf('The resulting value of uc=%4.2f, vc=%4.2f, R=%4.2f.\n',uc,vc,R)
axis square