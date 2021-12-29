%----------------------------------------
%  Data Generation
%    Input: 
%          N = number of total data
%    Output
%          xe(N,1) : independent variable x  (sequential order)
%          ye(N,1) : exact dependent function values
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
