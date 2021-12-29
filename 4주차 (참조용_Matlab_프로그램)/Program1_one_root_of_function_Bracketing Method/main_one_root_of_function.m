no_x =  20;
xL   = 0.0;
xU   = 0.7;
epsilon  =1.0E-05;
iter_max = 100; 
[xroot,error_his,xroot_his,iter,fun_final] = one_root_of_function(xL,xU,epsilon,iter_max);
function_plot(1,no_x,xL,xU);
%
% Plot convergence history
%
figure(2)
   set(gcf,'DefaultLineLineWidth',1.5);set(gca,'DefaultLineLineWidth',1.5)
   [s1,s2]=size(error_his);
   it=(1:s1)'; % transpose to make column vector
   semilogy(it(:,1), error_his(:,1),'-sb')
   grid
   xlabel('iteration number')
   ylabel('relative error')
   title('convergence history of root finding')
%
% Plot locus of approximated root
%
figure(3),
set(gcf,'DefaultLineLineWidth',1.5);set(gca,'DefaultLineLineWidth',1.5)
function_plot(3,no_x,xL,xU);
%
hold on
   for j=1:s1
       xC  = xroot_his(j,1);
       fun_his(j,1) = user_fun(xC);
   end
%   
   p1= plot(xroot_his(1,1), fun_his(1,1),'or');
   p2= plot(xroot_his(2,1), fun_his(2,1),'sr');
   p3= plot(xroot_his(3,1), fun_his(3,1),'dr');
   p4= plot(xroot_his(4:s1,1), fun_his(4:s1,1),'^r');
%
   plot(xroot_his(:,1), fun_his(:,1),'-r');
   title('function plot and locus of approximated roots')
   legend([p1,p2,p3,p4],': iter = 1',': iter = 2',': iter = 3',': iter = 4 ~ ')
   
   axis([0.3 0.7 -7.0 3.0])