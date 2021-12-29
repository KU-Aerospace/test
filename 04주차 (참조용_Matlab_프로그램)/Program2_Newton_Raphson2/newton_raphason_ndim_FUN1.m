%-------------------------------------------------------------------------
% objective : Solving one-variable nonlinear algebraic equation using 
%             Newton-Raphason method
%-------------------------------------------------------------------------
% Input Variables 
%    alpha   : under-relaxation factor
%    epsilon : tolerance
%    iter_max: maximum Newton-Raphson iteration allowed
%    ndim    : dimension of x and function
%    xo      : initial guess of solution
%    delx    : increment of x for finite difference method for gradient computing
%-------------------------------------------------------------------------
% Output Variables 
%    x       : numerial approximation of solution
%    iter    : iteration number upto final computation of x
%    error   : correction of x at iter
%    nstat   : status information for solution
%       if(nstate==0) : solution is not converged with the given number of iteration
%       if(nstate==2) : solution is fully converged with the given number of iteration & tolerance
%    xhis    : history of solution convergence (x)
%    fhis    : history of function convergence (fun)
%-------------------------------------------------------------------------
function [x,iter,error,nstate,xhis,fhis,error_his]=newton_raphason_ndim_FUN1(alpha,epsilon,iter_max,ndim,xo,delx)
%-------------------------------------------------------------------------
fun=[];funp=[];funm=[];grad_fun=[];
%-------------------------------------------------------------------------
nstate = 0;
xhis(1:ndim,1:iter_max)     = 0.0;
fhis(1:ndim,1:iter_max)     = 0.0;
grad_fun(1:ndim,1:ndim)     = 0.0;
error_his(1:ndim,1:iter_max)= 0.0;
%

x = xo;
for iter = 1:iter_max
%-------------------------------------------------------------------------
% (1) current function resudial: f(x)
%-------------------------------------------------------------------------
    x1 = x;
    [fun]=function_ndim_user_FUN1(x1);
%
    for j = 1:ndim
%-------------------------------------------------------------------------
% (2) positive perturbation
%-------------------------------------------------------------------------
        x(j,1) = x1(j,1) + delx;
        [funp]=function_ndim_user_FUN1(x);
%-------------------------------------------------------------------------
% (3) negative perturbation
%-------------------------------------------------------------------------
        x(j,1) = x1(j,1) - delx;
        [funm]=function_ndim_user_FUN1(x);
%
        x(j,1) = x1(j,1);
%-------------------------------------------------------------------------
% (4) function gradient
%-------------------------------------------------------------------------
        grad_fun(1:ndim,j) = 0.5*(funp(1:ndim,1)-funm(1:ndim,1))/delx;
    end
%-------------------------------------------------------------------------
% (5) new solution x
%-------------------------------------------------------------------------
    xhis(1:ndim,iter) = x(1:ndim,1);
    fhis(1:ndim,iter) = fun(1:ndim,1);
%
    del_xnew    = -alpha*inv(grad_fun)*fun;
    x(1:ndim,1) = x(1:ndim,1) + del_xnew(1:ndim,1);
%-------------------------------------------------------------------------
% (6) cheakc termination condition
%-------------------------------------------------------------------------
    error = 0.0;
    for j =1:ndim
        error = error + del_xnew(j,1)^2;
    end
    error = sqrt(error/ndim);
%
    error_his(iter,1) = error;
%
    if(error<epsilon) 
         nstate = 2;
         break;
    end
     sol1 = x(1,1);
     sol2 = x(2,1);
%     dispdata = [iter error sol];
     sprintf('iter = %5d    error = %10.4e    x1 = %10.4e    x2 = %10.4e',iter, error,sol1,sol2)
end
%-------------------------------------------------------------------------
% (7) display solution results
%-------------------------------------------------------------------------
if(nstate==0)
    disp('solution is not converged with the given number of iteration')
else
    disp('solution is converged with the given number of iteration & tolerance')
end
%-------------------------------------------------------------------------
% Example #1
%  alpha = 1.0; epsilon=1.0E-05;iter_max=15;ndim=2;xo(1,1)=1.5;xo(2,1)=3.5;delx=0.0001;
%  [x,iter,error,nstate,xhis,fhis]=newton_raphason_ndim(alpha,epsilon,iter_max,ndim,xo,delx)
%
%  xx=0.1:0.1:3.0;
%  xx=xx';
%  [s1,s2]=size(xx);
%  for j=1:s1;
%      x1=xx(j,1);
%      fy(j,1)=(x1*x1-10.0)/x1;
%  end
%
%  yy=0.1:0.1:3.0;
%  yy=yy';
%  [s1,s2]=size(yy);
%  for j=1:s1;
%      y1=yy(j,1);
%      fx(j,1)=-(y1-57)/(3.0*y1^2);
%  end
%  close all;
%  plot(xx(:,1),fy(:,1),'-r');grid;hold on;
%  plot(fx(:,1),yy(:,1),'-b');grid;hold on;
%  plot(xhis(1,:),xhis(2,:),'-sk');
%-------------------------------------------------------------------------

