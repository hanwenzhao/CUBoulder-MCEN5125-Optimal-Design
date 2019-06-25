clear all
clc
close all

x=0:.05:10;
y = 2*x + 3 + 3*rand(length(x),1)';
%plot(x,y,'r.','markersize',18)

A = [x' ones(length(x),1)];
b = y';
b(1)=30;
b(end)=0;
plot(x,y,'r.','markersize',18)

Sol1 = A\b;

hold on
plot(x,Sol1(1)*x + Sol1(2),'linewidth',2)

cvx_begin
variables z(2);
minimize norm(A*z-b,1)
cvx_end

plot(x,z(1)*x + z(2),'g-.','linewidth',2)

Data = [0 2 5;
        0 3 2];
    
%y = a0 + a1*x + a2*x^2 + a3*x^3 + a4*x^4;

A1 = [ones(3,1) Data(1,:)' Data(1,:)'.^2 Data(1,:)'.^3 Data(1,:)'.^4];
b1 = Data(2,:)';

Sol2 = A1\b1
A1*Sol2-b1
Sol3 = pinv(A1)*b1
A1*Sol3-b1


cvx_begin quiet
variables z(5);
minimize norm(z,2)
subject to 
            A1*z==b1
cvx_end