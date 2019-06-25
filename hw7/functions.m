function [t] = backLineSearch(dx,x,alpha,beta,gamma)
t = 1;
while myFun(x+t*dx,gamma) > myFun(x,gamma)+alpha*t*gradientCal(x,gamma)'*dx
    t = beta*t;
end
end

function [t] = backLineSearch2(dx,x,alpha,beta,gamma)
t = 1;
while myFun(x+t*dx',gamma) > myFun(x,gamma)+alpha*t*gradientCal(x,gamma)'*dx'
    t = beta*t;
end
end

function g = gradientCal(x,gamma)
g = [x(1) gamma*x(2)];
end

function h = hessianCal(x,gamma)
h = [1,0
     0,gamma];
end

function obj = myFun(x,gamma)
obj = (x(1)^2 + gamma*x(2)^2)/2;
end