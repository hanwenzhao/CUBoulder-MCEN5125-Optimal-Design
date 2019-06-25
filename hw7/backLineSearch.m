function [t] = backLineSearch(dx,x,alpha,beta,gamma)
t = 1;
while myFun(x+t*dx,gamma) > myFun(x,gamma)+alpha*t*gradientCal(x,gamma)'*dx
    t = beta*t;
end