%----------------------------------------
%  Data Generation
%    Input: 
%          N = number of total data
%          alpa = niose amplitude
%    Output
%          xe(N,1) : independent variable x  (sequential order)
%          ye(N,1) : exact dependent function values
%          xn(N,1) : independent variable x  (random order)
%          yn(N,1): noisy dependent function values  
%----------------------------------------
%  (1) Initialize
%----------------------------------------
xe(1:N,1)  = 0.0;
ye(1:N,1)  = 0.0;
xn(1:N,1)  = 0.0;
yn(1:N,1)  = 0.0;
%----------------------------------------
%  (2) Exact Data (sequential order)
%----------------------------------------
dx = 2.0/(N-1)           ;
for j=1:N
    x1=dx*(j-1)          ;
%
    xe(j,1) = x1          ;
    ye(j,1) = x1 + sin(2*pi*x1) - 0.5*cos(4*pi*x1) + 1.0      ;
end
%----------------------------------------
%  (3) Noisy Data  (random sequence)
%----------------------------------------
for j=1:N
    r1=rand              ;
    x1=2.0*r1            ;
    r2=rand              ;
    n1=alpa*(2.0*r2-1.0) ;
%
    xn(j,1) = x1          ;
    yn(j,1) = x1 + sin(2*pi*x1) - 0.5*cos(4*pi*x1) + 1.0  + n1;
end
%----------------------------------------


