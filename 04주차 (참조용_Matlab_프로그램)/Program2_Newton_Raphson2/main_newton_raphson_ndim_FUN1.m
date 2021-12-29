clear all;
close all;

alpha = 1.0; epsilon=1.0E-08;iter_max=25;ndim=2;xo(1,1)=1.0;xo(2,1)=1.0;delx=0.0001;
[x,iter,error,nstate,xhis,fhis,error_his]=newton_raphason_ndim_FUN1(alpha,epsilon,iter_max,ndim,xo,delx);
%
xx=0.1:0.1:3.0;
xx=xx';
[s1,s2]=size(xx);
for j=1:s1;
      x1=xx(j,1);
      fy(j,1)=-(x1*x1-10.0)/x1;
end
%
yy=-15:0.1:15.0;
yy=yy';
[s1,s2]=size(yy);
for j=1:s1;
      y1=yy(j,1);
      fx(j,1)=-(y1-57)/(3.0*y1^2);
end
plot(xx(:,1),fy(:,1),'-r');grid;hold on;
plot(fx(:,1),yy(:,1),'-b');
plot(xhis(1,1:iter),xhis(2,1:iter),'-sk');
axis([0 3 -15 15])

xlabel('x')
ylabel('y')
title('Function #1 , Function #2, and Root-Locus')

% 
figure(2)
it=1:iter;
semilogy(it,error_his,'-o');
grid;
title('Convergence History')
xlabel('iteration number')
ylabel('Error (RMS)')