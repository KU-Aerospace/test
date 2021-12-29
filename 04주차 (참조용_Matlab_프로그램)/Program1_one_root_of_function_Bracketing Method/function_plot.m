function [] = function_plot(Nfig,no_x,xL,xU)
%-----------------------------------------------------------------------
delx= (xU - xL)/(no_x - 1);
x   (1:no_x,1) = 0.0;
funn(1:no_x,1) = 0.0;
for j=1:no_x
    x(j,1) = xL + delx*(j-1);
end
%
for j=1:no_x
    xx        = x(j,1);
    funn(j,1) = user_fun(xx);
end
%
%  plotting function
%
figure(Nfig),
   set(gcf,'DefaultLineLineWidth',2.0);set(gca,'DefaultLineLineWidth',2.0)
   plot(x,funn,'-b')
   grid
   xlabel('x')
   ylabel('function value')
