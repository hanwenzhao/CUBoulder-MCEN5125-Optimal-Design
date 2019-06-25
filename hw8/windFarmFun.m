function [P] = windFarmFun(a)
% rho: air density
% k:
% u: initial wind speed
% D: diameter of turbine
% calculate area
rho = 1.225;
k = 0.075;
u = 10;
d = 80;
A = pi * d^2/4;
C1 = (d/(2*k*400))^2;
C2 = (d/(2*k*400))^2;
C3 = (d/(2*k*400))^2;
% wind speeds
v1 = u;
v2 = u*(1-2*a(1)*C1);
v3 = (u*(1-2*sqrt((a(1)*C2)^2+(a(2)*C3)^2)));
% 
cp1 = 4*a(1)*(1-a(1))^2;
cp2 = 4*a(2)*(1-a(2))^2;
cp3 = 4*a(3)*(1-a(3))^2;
%
P1 = 0.5*rho*A*(v1)^3*cp1;
P2 = 0.5*rho*A*(v2)^3*cp2;
P3 = 0.5*rho*A*(v3)^3*cp3;
P = -(P1+P2+P3);
end