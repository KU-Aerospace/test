%----------------------------------------
%  Data  
%    Input: 
%          Xp      : Input X-position
%          N       : Number of total data
%          XN(N,1) : Data in Increasing Order
%    Output
%          K       : Interval where XN(K) <= Xp <=XN(K+1)
%          Bm(3,3,N-1) : Matrix Bj in Block Tri-diagonal Matrix
%          Cm(3,3,N-1) : Matrix Cj in Block Tri-diagonal Matrix
%----------------------------------------
function [K] = Interval_Finding(Xp,N,XN)
%----------------------------------------
%  (1) Lower and Upper Limit
%----------------------------------------
    NL = 1  ; NU = N  ; 
%----------------------------------------
%  (2) Finding Interval containing Xp
%----------------------------------------
    for k=1:N
        Nm = int16( (NL + NU)/2 )   ;
        Xm = XN(Nm,1)               ;
        if( Xp <= Xm )
            NU = Nm  ;               
        else
            NL = Nm  ;
        end
%
        if( NU-NL <=1 ) 
            break
        end
    end
    K = NL ;
%----------------------------------------
end 
%----------------------------------------
