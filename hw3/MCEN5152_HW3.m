function [] = MCEN5152_HW3()
clear all
close all
clc
%% Problem #3
% Section (b)
[u1,c1,~] = P3(30);
% create matrix for position and velocity
position1 = zeros(1,30);
velocity1 = zeros(1,30);
t1 = 1:1:30;
% calculate position and velocity for each time steps
for i = 1:30
    x = c1(:,end-i+1:end)*u1(1:i,:);
    position1(i) = x(1);
    velocity1(i) = x(2);
end
% plot
figure
hold on
stairs([0,t1],[reshape(u1,[1,30]),0],'LineWidth',2)
plot([0,t1],[0,position1],'LineWidth',2)
plot([0,t1],[0,velocity1],'LineWidth',2)
legend('u(t)','position','velocity')
xlabel('Time')
ylabel('Magnitude')
title('Position and Velocity of Optimal u(t)')
axis([0 30 -2 10])

% Section (c)
N = 2:29;
E = zeros(length(N));
% calculate cost for each N
for i = 2:29
    [~,~,E(i-1)] = P3(i);
end
% semilogy plot
figure
semilogy(N,E,'LineWidth',2)
xlabel('N')
ylabel('E')
title('E vs. N')

% Section (d)
[u,c2,~] = P3D(30);
% create matrix for position and velocity
position2 = zeros(1,30);
velocity2 = zeros(1,30);
u2 = u(1:end-1);
t2 = 1:1:30;
% calculate position and velocity for each time step
for i = 1:30
    x = c2(:,end-i:end-1)*u2(1:i,:);
    position2(i) = x(1);
    velocity2(i) = x(2);
end
figure
hold on
stairs([0,t2],[reshape(u2,[1,30]),0],'LineWidth',2)
plot([0,t2],[0,position2],'LineWidth',2)
plot([0,t2],[0,velocity2],'LineWidth',2)
legend('u(t)','position','velocity')
xlabel('Time')
ylabel('Magnitude')
title('Position and Velocity of Optimal u(t) without position constrain')
axis([0 30 -2 10])

%% Problem #4
[u,v,C1,C2] = P4(20);
position3 = zeros(1,20);
position4 = zeros(1,20);
t1 = 1:1:20;
% calculate position for each vehicle at each time steps
for i = 1:20
    x1 = C1(:,end-i+1:end)*u(1:i,:);
    x2 = C2(:,end-i+1:end)*v(1:i,:);
    position3(i) = x1(1);
    %velocity3(i) = x1(2);
    position4(i) = x2(1);
    %velocity4(i) = x2(2);
end
figure
hold on
plot([0,t1],[0,position3],'LineWidth',2)
% offset postion since it starts one
plot([0,t1],[0+1,position4+1],'LineWidth',2)
legend('position s','position p')
xlabel('Time')
ylabel('Magnitude')
title('Position of s and p without specified destination(Minimum Energy)')
%figure
%hold
%plot([0,t1],[0,velocity3],'LineWidth',2)
%plot([0,t1],[0,velocity4],'LineWidth',2)

%% Problem #4 Second Thought
[u,v,c1,c2] = P4_2(20);
position5 = zeros(1,20);
position6 = zeros(1,20);
t1 = 1:1:20;
% calculate position for each vehicle at each time steps
for i = 1:20
    x1 = c1(:,end-i+1:end)*u(1:i,:);
    x2 = c2(:,end-i+1:end)*v(1:i,:);
    position5(i) = x1(1);
    position6(i) = x2(1);
end
figure
hold on
plot([0,t1],[0,position5],'LineWidth',2)
% offset postion since it starts one
plot([0,t1],[0+1,position6+1],'LineWidth',2)
legend('position s','position p')
xlabel('Time')
ylabel('Magnitude')
title('Position of s and p with specified destination at 10')
end

function [u,C,E] = P3(N)
% create container for s1 s2 d etc
c1 = zeros(1,N);
c2 = zeros(1,N);
d = [10;0];
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
u = pinv(C)*d;
E = norm(u);
end

function [u,C,E] = P3D(N)
% create container for s1 s2 d etc
c1 = zeros(1,N);
c2 = zeros(1,N);
d = [10;0];
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
C = [0.1.*c1 1;0.1*c2 0];

u = pinv(C)*d;
E = norm(u);
end

function [u,v,C1,C2] = P4(N)
% create container for s1 s2 d etc
c1 = zeros(1,N);
c2 = zeros(1,N);
c3 = zeros(1,N);
c4 = zeros(1,N);
d = [1;0;0];
% fill the s2 matrix
for i=1:N
   c2(i) = 0.95^(N-i);
   c4(i) = 0.8^(N-i);
end
% format the s1 matrix
c1(end) = 0;
c3(end) = 0;
for i=fliplr(1:N-1)
    c1(i) = c1(i+1) + c2(i+1);
    c3(i) = c3(i+1) + c4(i+1);
end
% format matrix C
C = zeros(3,2*N);
C(1,1:N) = 0.1.*c1;
C(2,1:N) = 0.1.*c2;
C(1,N+1:end) = -0.2.*c3;
C(3,N+1:end) = 0.2.*c4;
ans = pinv(C)*d;
u = ans(1:N);
v = ans(N+1:2*N);
C1 = [0.1.*c1;0.1.*c2];
C2 = [0.2.*c3;0.2.*c4];
end

function [u,v,C1,C2] = P4_2(N)
% create container for s1 s2 d etc
c1 = zeros(1,N);
c2 = zeros(1,N);
c3 = zeros(1,N);
c4 = zeros(1,N);
d = [10;0;9;0];
% fill the s2 matrix
for i=1:N
   c2(i) = 0.95^(N-i);
   c4(i) = 0.8^(N-i);
end
% format the s1 matrix
c1(end) = 0;
c3(end) = 0;
for i=fliplr(1:N-1)
    c1(i) = c1(i+1) + c2(i+1);
    c3(i) = c3(i+1) + c4(i+1);
end
% format matrix C
C = zeros(4,2*N);
C(1,1:N) = 0.1.*c1;
C(2,1:N) = 0.1.*c2;
C(3,N+1:end) = 0.2.*c3;
C(4,N+1:end) = 0.2.*c4;
ans = pinv(C)*d;
u = ans(1:N);
v = ans(N+1:2*N);
C1 = [0.1.*c1;0.1.*c2];
C2 = [0.2.*c3;0.2.*c4];
end