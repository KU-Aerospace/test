%---------------------------------------
function [FunLag] = Lagrange_funtion(x,N,XN)
%---------------------------------------
% Input
%    x        : evaluation point
%    N        : Number of nodes
%    XN(1:N)  : Nodes
% Output
%    FunLag(1:N)  : Lagrange function values at x
%---------------------------------------
% (1) Initialize
%---------------------------------------
    FunLag(1:N,1) = 1.0    ;
%---------------------------------------
% (2) Loop
%---------------------------------------
    for j = 1: N
        Fun = 1.0 ;
        for k=1:j-1
            Fun = Fun*(x - XN(k) )/( XN(j) - XN(k) ) ;
        end
        for k=j+1:N
            Fun = Fun*(x - XN(k) )/( XN(j) - XN(k) ) ;
        end
        FunLag(j,1) = Fun ;
    end
%---------------------------------------
end
%---------------------------------------
