function [x_out,nIter,error] = newtonMethod(x0,alpha,beta,maxIter)
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
lamda2 = inf;
x = x0;
% while loop
while lamda2/2>=tol & nIter<maxIter
   % calculate gradient
   dx = -inv(hessianCal(x,gamma))*gradientCal(x,gamma)';
   lamda2 = transpose(gradientCal(x,gamma)).*(inv(hessianCal(x,gamma))).*gradientCal(x,gamma);
   % back tracking line search
   t = backLineSearch2(dx,x,alpha,beta,gamma);
   % calcuate new x
   x_new = x + t*dx';
   % plot
   plot([x(1) x_new(1)],[x(2) x_new(2)],'go-');
   refresh
   % update
   nIter = nIter + 1;
   x_out(nIter,:) = x_new;
   error(nIter) = myFun(x,gamma)-0;
   x = x_new;
end
nIter = nIter - 1;
end