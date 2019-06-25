% MCEN 5152
% Homework #7
% Hanwen Zhao
% MEID: 650-703

%% Problem #1 & #2
% plot contours
figure; hold on;
M = 10;
val = linspace(0,M*(M+1),5);
theta = linspace(0,2*pi,100)';
plot(cos(theta)*sqrt(val),sin(theta)*sqrt(val/M),'--');
axis('equal')
xlabel('x_1')
ylabel('x_2')
% run two algorithm without specific iteration number
[~,ngd,egd] = gradientDescent([M,1],0.2,0.7);
[~,nnm,enm] = newtonMethod([M,1],0.2,0.7);

%% Problem #3
% convergence plot for each algorithm
figure; hold on;
n1 = 1:ngd+1;
plot(n1,egd(1:ngd+1),'ro-')
n2 = 1:nnm+2;
plot(n2,enm(1:nnm+2),'go-')
xlabel('Iteration Number')
ylabel('f - f^*')
legend('Gradient Descent','Newtons Method')
title('Convergence to Optionmal Soultion')

%% Problem #4
% plot contours
figure; hold on;
M = 10;
val = linspace(0,M*(M+1),5);
theta = linspace(0,2*pi,100)';
p1 = plot(cos(theta)*sqrt(val),sin(theta)*sqrt(val/M),'--');
axis('equal')
xlabel('x_1')
ylabel('x_2')
title('40 iterations')
% perform 40 iterations for each algorithm
[xgd,ngd,egd] = gradientDescent([M,1],0.2,0.7,40);
[xnm,nnm,enm] = newtonMethod([M,1],0.2,0.7,40);
% convergence plot with 40 iteration
figure; hold on;
n1 = 1:ngd+1;
plot(n1,egd(1:ngd+1),'ro-')
n2 = 1:nnm+2;
plot(n2,enm(1:nnm+2),'go-')
xlabel('Iteration Number')
ylabel('f - f^*')
legend('Gradient Descent','Newtons Method')
title('Convergence to Optionmal Soultion with 40 Iterations')