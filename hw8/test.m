clc;clear all; close all;
rho = 1.225;
k=0.075;
u=10;
D=80;
A = pi*(D/2)^2;
C = zeros(3,1);
C(1)=(D/(D+2*k*400))^2;
C(2)=(D/(D+2*k*800))^2;
C(3)=(D/(D+2*k*400))^2;

v1 = u;
v2 = @(a)u*(1-2*a(1)*C(1));
v3 = @(a)(u*(1-2*sqrt((a(1)*C(2))^2+(a(2)*C(3))^2)));
cp1 = @(a)4*a(1)*(1-a(1))^2;
cp2 = @(a)4*a(2)*(1-a(2))^2;
cp3 = @(a)4*a(3)*(1-a(3))^2;

P1 =@(a) 0.5*rho*A*(v1)^3*cp1(a);
P2 =@(a) 0.5*rho*A*(v2(a))^3*cp2(a);
P3 =@(a) 0.5*rho*A*(v3(a))^3*cp3(a);
P = @(a) -(P1(a)+P2(a)+P3(a));

A_eq = [-eye(3); eye(3)];
b_eq = [zeros(3,1); 0.5*ones(3,1)];
x0=[0 0 0];
x = fmincon(P,x0,A_eq,b_eq)