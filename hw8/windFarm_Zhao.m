% MCEN 5125
% Optimal Design
% Wind Farm
% Hanwen Zhao

clc
clear
close all
% parameters from three turbine example
% model parameters
rho = 1.225; % kg/m^3
k = 0.075;
U = 10; % m/s
D = 80;
A = pi*(D/2)^2;
C = zeros(3,1);
% coefficients for wind speed calculation
C(1)=(D / (D + 2*k*400))^2;
C(2)=(D / (D + 2*k*800))^2;
C(3)=(D / (D + 2*k*400))^2;
% calculate aggregate wind speed
v1 = U;
v2 = @(a) U*(1-2*a(1)*C(1));
v3 = @(a) U*(1-2*sqrt((a(1)*C(2))^2+(a(2)*C(3))^2));
% power efficiency coefficient
Cp1 = @(a) 4*a(1)*(1-a(1))^2;
Cp2 = @(a) 4*a(2)*(1-a(2))^2;
Cp3 = @(a) 4*a(3)*(1-a(3))^2;
% calculate power for each turbine and total power
P1 =@(a) 0.5*rho*A*(v1)^3*Cp1(a);
P2 =@(a) 0.5*rho*A*(v2(a))^3*Cp2(a);
P3 =@(a) 0.5*rho*A*(v3(a))^3*Cp3(a);
P = @(a) -(P1(a)+P2(a)+P3(a));
% using matlab builtin to solve problem
Aeq = [-eye(3); eye(3)];
beq = [zeros(3,1); 0.5*ones(3,1)];
% use zeros as our initial guess
x0=[0 0 0];
x = fmincon(P,x0,Aeq,beq)