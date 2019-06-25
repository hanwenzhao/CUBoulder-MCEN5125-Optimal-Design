% MCEN 5125
% Homework 5
% Hanwen Zhao
% MEID: 650-703
close all; clear all; clc;

%% Exercise 5
A = [-1,-1,0;
    1,2,0;
    -1,0,0;
    0,-1,0;
    0,0,-1];
b = [-1,3,0,0,0];
f = [-1,0,1;
    0,1,0;
    0,0,-1];
for i=1:3
    fprintf('For the set %d of c, we have the following solution', i)
    linprog(transpose(f(i,:)),A,b)
end

%% Exercise 13
% call ex13data to get ts and ys
ex13data()
% plot the points
figure
hold on
plot(t,y,'r.')
% Least Square
fprintf('Least Square\n')
[m,n] = size(t);
A1 = [ones(m,1) t];
b1 = y;
result1 = A1\b1;
fprintf('The least square results alpha = %4.2f beta = %4.2f.\n\n',result1(1),result1(2))
plot(t,result1(1)+result1(2)*t,'linewidth',2)

% l1-norm
fprintf('1-Norm\n')
A2 = [ones(m,1) t -eye(m)
    -ones(m,1) -t -eye(m)];
b2 = [y;-y];
f2 = [0;0;ones(m,1)];
result2 = linprog(f2, A2, b2);
fprintf('The l1-norm results alpha = %4.2f beta = %4.2f.\n\n',result2(1),result2(2))
plot(t,result2(1)+result2(2)*t,'linewidth',2)

% linf-norm
fprintf('Infinity Norm\n')
A3 = [ones(m,1) t -ones(m,1)
    -ones(m,1) -t -ones(m,1)];
b3 = [y;-y];
f3 = [0;0;1];
result3 = linprog(f3, A3, b3);
fprintf('The linfinity-norm results alpha = %4.2f beta = %4.2f.\n\n',result3(1),result3(2))
plot(t,result3(1)+result3(2)*t,'linewidth',2)

legend('Data Points','Least Square','1-Norm','Inf-Norm')

%% Exercise 14
% problem b
fprintf('Problem b(i)\n')
% import A and Ides
[A, Ides] = ex14data();
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
fprintf('Problem b(ii)\n')
% generate a diagonal matrix
d = ones(1,size(A,2));
D = diag(d);
b2 = ones(size(A,2),1) * 0.5;
% form new matrix and loop through to find x
mu = 1;
while 1
    newA = [A;sqrt(mu).*D];
    newB = [b;sqrt(mu)*b2];
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

% problem c
[m,n] = size(A);
A4 = [A -ones(m,1);
    -A -ones(m,1);
    eye(m,n) zeros(m,1);
    -eye(m,n) zeros(m,1)];
b4 = [Ides*ones(m,1);-Ides*ones(m,1);ones(m,1);zeros(m,1)];
f4 = [zeros(n,1);1];
result4 = linprog(f4,A4,b4);
p = result4(1:end-1);
I_new = A * p;
cost_new = sum((I_new - Ides).^2);
fprintf('The resulting value of the new cost function as the LP problem is %4.2f.\n',cost_new)

%% Exercise 17
clear all
N = 20;
% create container for s1 s2 d etc
c1 = zeros(1,N);
c2 = zeros(1,N);
b = [10;0];
% fill the s2 matrix
for i=1:N
   c2(i) = 0.95^(N-i);
end
% format the s1 matrix
c1(end) = 0;
for i=fliplr(1:N-1)
    c1(i) = c1(i+1) + c2(i+1);
end
% format matrix C
C = 0.1.*[c1;c2];
A1 = [eye(N) -eye(N);
    -eye(N) -eye(N);
    2*eye(N) -eye(N);
    -2*eye(N) -eye(N)];
b1 = [zeros(N,1);zeros(N,1);ones(N,1);ones(N,1)];
A2 = [eye(N) zeros(N);
    -eye(N) zeros(N)];
b2 = [ones(N,1);zeros(N,1)];
Aeq = [C zeros(2,N)];
beq = [10;0];
A = A1;
b = b1;
f = [zeros(N,1);ones(N,1)];
result5 = linprog(f,A,b,Aeq,beq);
u = result5(1:20);
position = zeros(1,20);
velocity = zeros(1,20);
t1 = 1:1:20;
% calculate position and velocity for each time steps
for i = 1:20
    x = C(:,end-i+1:end)*u(1:i,:);
    position(i) = x(1);
    velocity(i) = x(2);
end
% plot
figure
hold on
stairs([0,t1],[reshape(u,[1,20]),0],'LineWidth',2)
plot([0,t1],[0,position],'LineWidth',2)
plot([0,t1],[0,velocity],'LineWidth',2)
legend('u(t)','position','velocity')
xlabel('Time')
ylabel('Magnitude')
title('Position and Velocity of Optimal u(t)')
axis([0 20 -2 10])
cost = sum(result5(21:40));
fprintf('Therefore the total fuel consumed is %4.2f. \n',cost)