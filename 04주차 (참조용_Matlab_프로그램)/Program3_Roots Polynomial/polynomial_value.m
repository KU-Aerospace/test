%------------------------------------------------------------------------------------------
% n-th order Polynomial function value with a given value x
% y = a(1,1)+a(2,1)*x + a(3,1)*x^2 + .... + a(n+1,1)*x^n
%------------------------------------------------------------------------------------------
% Input
%     n          : the order of polynomial
%     a(n+1,1)   : polynomial coefficients
%     x(1,1)     : independent variable
%------------------------------------------------------------------------------------------
% Output
%     p          : Computed Polynomial function value
%-------------------------------------------------------------------------
function p=polynomial_value(n,a,x)
p = a(n+1,1);
for j=n:-1:1
    p = a(j,1)+x*p;
end