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
dye(1:N,1)  = 0.0;
ddye(1:N,1)  = 0.0;
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
%  (3) Exact derivative (sequential order)
% ----------------------------------------
% dx = 6.0/(N-1)           ;
% for j=1:N
%     if(j < N/3 || j >2*N/3)
%         x1=-3.0 + dx*(j-1)          ;
%         xe(j,1) = x1;
%         dye(j,1) = 0.0;
%     
%     else
% 
%         x1=-3.0 + dx*(j-1)          ;
%         xe(j,1) = x1          ;
%         dye(j,1) =  3 - 3*x1^2     ;
%     end
% end

%----------------------------------------
