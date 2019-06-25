function [x_out,nIter,error] = gradientDescent(x0,alpha,beta,maxIter)
gamma = x0(1);
% if the maximum number of iteration is not defined
if nargin == 3
    maxIter = 10000;
end
x_out = zeros(maxIter,2);
error = zeros(maxIter,1);
% define tolerance
tol = 1e-6;
% initialize number of iternation
nIter = 0;
% initialize gradient norm
gNorm = inf;
x = x0;
% while loop
while gNorm>=tol && nIter<maxIter
   % calculate gradient
   dx = -gradientCal(x,gamma);
   gNorm = norm(dx);
   % back tracking line search
   t = backLineSearch(dx,x,alpha,beta,gamma);
   % calcuate new x
   x_new = x + t*dx;
   % plot
   plot([x(1) x_new(1)],[x(2) x_new(2)],'ro-')
   refresh
   % update
   nIter = nIter + 1;
   x_out(nIter,:) = x_new;
   error(nIter) = myFun(x,gamma)-0;
   x = x_new;
end
nIter = nIter - 1;
end