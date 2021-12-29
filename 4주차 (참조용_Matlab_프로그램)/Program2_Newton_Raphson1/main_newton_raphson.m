clear all;close all
alpha = 0.5; epsilon=1.0E-05;iter_max =15;xo=0.5;delx=0.0001;
[x,iter,error,nstate,xhis,fhis,error_his]=newton_raphason_one(alpha,epsilon,iter_max,xo,delx);
xx=-1.0:0.1:3.0;
xx=xx';
[s1,s2]=size(xx);
for j=1:s1;
      x1=xx(j,1);
      ff(j,1)=x1*(x1-1.0)*(x1-2.0)*(x1-2.0);
end
plot(xx(:,1),ff(:,1),'-r');grid;hold on;
plot(xhis(:,1),fhis(:,1),'-sb');
axis([-1.0, 3.0, -1.0, 4.0])
xlabel('x');ylabel('function')
  
% 
figure(2)
it=1:iter;
semilogy(it,error_his,'-o');
grid;
title('Convergence History')
xlabel('iteration number')
ylabel('Error (ABS)')
