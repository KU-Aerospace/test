%-------------------------------------------------------------------------
% objective : Solving one-variable nonlinear algebraic equation using 
%             Newton-Raphason method
%-------------------------------------------------------------------------
% Input Variables 
%    alpha   : under-relaxation factor
%    epsilon : tolerance
%    iter_max: maximum Newton-Raphson iteration allowd
%    xo      : initial guess of solution
%    delx    : increment of x for finite difference method for gradient computing
%-------------------------------------------------------------------------
% Output Variables 
%    x       : numerial approximation of solution
%    iter    : iteration number upto final computation of x
%    error   : correction of x at iter
%    nstat   : status information for solution
%       if(nstate==0) : solution is not converged with the given number of iteration
%       if(nstate==1) : iteration cannot be continued due to too small function gradient
%       if(nstate==2) : solution is fully converged with the given number of iteration & tolerance
%    xhis    : history of solution convergence (x)
%    fhis    : history of function convergence (fun)
%-------------------------------------------------------------------------
function [x,iter,error,nstate,xhis,fhis,error_his]=newton_raphason_one(alpha,epsilon,iter_max,xo,delx)
%
x      = xo;
nstate = 0;
xhis(1:iter_max,1)      = 0.0;
fhis(1:iter_max,1)      = 0.0;
error_his(1:iter_max,1) = 0.0;
%
for iter = 1:iter_max
%-------------------------------------------------------------------------
% (1) current function resudial: f(x)
%-------------------------------------------------------------------------
    x1 = x;
    [fun]=function1_user(x1);
%-------------------------------------------------------------------------
% (2) positive perturbation
%-------------------------------------------------------------------------
        xp = x + delx;
        [funp]=function1_user(xp);
%-------------------------------------------------------------------------
% (3) negative perturbation
%-------------------------------------------------------------------------
        xm = x - delx;
        [funm]=function1_user(xm);
%-------------------------------------------------------------------------
% (4) function gradient
%-------------------------------------------------------------------------
        grad_fun = 0.5*(funp-funm)/delx;
        if(abs(grad_fun) < epsilon)
            nstate = 1;
            break;
        end
%-------------------------------------------------------------------------
% (5) new solution x
%-------------------------------------------------------------------------
        xhis(iter,1) = x;
        fhis(iter,1) = fun;
%
        del_xnew = -alpha*fun/grad_fun;
        x        = x + del_xnew;
%-------------------------------------------------------------------------
% (6) cheakc termination condition
%-------------------------------------------------------------------------
        error = abs(del_xnew);
%
        error_his(iter,1) = error;
%
        if(error<epsilon) 
            nstate = 2;
            break;
        end
        dispdata = [iter,error,x];
        sprintf('iter = %5d             error = %10.4e         x = %10.4e',dispdata)
end
%-------------------------------------------------------------------------
% (7) display solution results
%-------------------------------------------------------------------------
if(nstate==0)
    disp('solution is not converged with the given number of iteration')
elseif(nstate==1)
    disp('iteration cannot be continued due to too small function gradient')
else
    disp('solution is converged with the given number of iteration & tolerance')
end
%-------------------------------------------------------------------------
% Example #1
%  alpha = 1.0; epsilon=1.0E-05;iter_max =15;xo=0.25;delx=0.0001;
%  [x,iter,error,nstate,xhis,fhis]=newton_raphason_one(alpha,epsilon,iter_max,xo,delx);
%  xx=0:0.1:3.0;
%  xx=xx';
%  [s1,s2]=size(xx);
%  for j=1:s1;
%      x1=xx(j,1);
%      ff(j,1)=x1*(x1-1.0)*(x1-2.0)*(x1-2.0);
%  end
%  close all;
%  plot(xx(:,1),ff(:,1),'-r');grid;hold on;
%  plot(xhis(:,1),fhis(:,1),'-sb');
%-------------------------------------------------------------------------

