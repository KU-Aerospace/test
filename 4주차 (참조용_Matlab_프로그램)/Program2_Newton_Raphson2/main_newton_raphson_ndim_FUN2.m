clear all;
close all;

alpha = 0.5; epsilon=1.0E-09;iter_max=250;ndim=2;xo(1,1)=0.1;xo(2,1)=2.0;delx=0.0001;
[x,iter,error,nstate,xhis,fhis,error_his]=newton_raphason_ndim_FUN2(alpha,epsilon,iter_max,ndim,xo,delx);
%
th=0.0:0.1:2.0*pi+1.0;
th=th';
[s1,s2]=size(th);
for j=1:s1;
      xx1(j,1) = cos(th(j,1));
      yy1(j,1) = sin(th(j,1));
%
      xx2(j,1) = xx1(j,1) + 1.0;
      yy2(j,1) = yy1(j,1) + 1.0;
end
%
p1=plot(xx1(:,1),yy1(:,1),'--r');grid;hold on;
p2=plot(xx2(:,1),yy2(:,1),':b');
legend([p1,p2],': Function #1',': Function #2')
plot(xhis(1,1:iter),xhis(2,1:iter),'-sk');
axis([-2 2 -2 2])
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