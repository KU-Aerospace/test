%---------------------------------------
function [dot_FunLag] = Lagrange_funtion_derivative(x,N,XN)
%---------------------------------------
% Input
%    x        : evaluation point
%    N        : Number of nodes
%    XN(1:N)  : Nodes
% Output
%    dot_FunLag(1:N)  : Lagrange function values at x
%---------------------------------------
% (1) Initialize
%---------------------------------------
   [FunLag] = Lagrange_funtion(x,N,XN) ;
   dot_FunLag(N,1) = 0.0               ; 
%---------------------------------------
% (2) Finding the zero Node
%---------------------------------------
    K0 = 0 ; 
    for k = 1:N
        DX = abs( x - XN(k) ) ;
        if ( abs( DX ) < 1.0E-15 )   
            K0 = k ;
            break  ;
        end
    end
%---------------------------------------
% (3) Case when K0=0
%---------------------------------------   
    if ( K0 == 0 )
%---------------------------------------
        for j = 1: N
            FL              = FunLag(j,1) ;
            for k=1:j-1
                dot_FunLag(j,1) = dot_FunLag(j,1) + FL/( x - XN(k) ) ;
            end
            for k=j+1:N
                dot_FunLag(j,1) = dot_FunLag(j,1) + FL/( x - XN(k) ) ;
            end
        end
%---------------------------------------
    else
%---------------------------------------
        for j = 1: N
%---------------------------------------
            FL              = FunLag(j,1) ;
            for k=1:j-1
                if( k ~= K0 )
                   dot_FunLag(j,1) = dot_FunLag(j,1) + FL/( x - XN(k) ) ;
                end
            end
%
            for k=j+1:N
                if( k ~= K0 )
                   dot_FunLag(j,1) = dot_FunLag(j,1) + FL/( x - XN(k) ) ;
                end
            end
%---------------------------------------
             Xnew(1:N-2) = 0.0 ;
             m= 0            ;
             for k=1:N
                 if( k~= j && k~=K0 )
                     m=m+1               ;
                     Xnew(m) = XN(k)     ;
                 end
             end
%---------------------------------------
             FL = 1.0 ;
             for k=1:m
                 FL = FL*( x - Xnew(k) )/( XN(j) - Xnew(k) ) ;
             end
%
            if (j~= K0)
                dot_FunLag(j,1) = dot_FunLag(j,1) + FL/( XN(j) - XN(K0) ) ;
            end
%---------------------------------------
        end
%---------------------------------------
    end
%---------------------------------------
   end
%---------------------------------------
