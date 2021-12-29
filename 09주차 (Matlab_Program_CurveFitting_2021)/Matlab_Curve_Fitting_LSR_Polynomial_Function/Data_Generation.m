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
dx = 10.0/(N-1)           ;
for j=1:N
 
    x1=-5.0 + dx*(j-1)          ;
    xe(j,1) = x1;
    ye(j,1) = 1/(1+x1^2);
    
    %
end
%----------------------------------------
%  (3) Noisy Data  (random sequence)
%----------------------------------------
for j=1:N
    
        r1=rand              ;
        x1= -5.0 + 10.0*r1            ;
        r2=rand              ;
        n1=alpa*(10.0*r2) ;
%
        xn(j,1) = x1          ;
        yn(j,1) =  1/(1+x1^2) + n1;

end
%----------------------------------------


