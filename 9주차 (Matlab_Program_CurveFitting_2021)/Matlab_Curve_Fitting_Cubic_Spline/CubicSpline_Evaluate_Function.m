%----------------------------------------
%  Data  
%    Input: 
%          Xp      : Input X-position
%          N       : Number of total data
%          XN(N,1) : Data in Increasing Order
%          Sc(1:4,N-1) : Cubic Spline Coefficients
%    Output
%          Yp       : Estimated Function  
%----------------------------------------
function [Yp] = CubicSpline_Evaluate_Function(Xp,N,XN,Sc)
%----------------------------------------
%  (1) Finding Interval and Spline Coefficients
%----------------------------------------
    [K] = Interval_Finding(Xp,N,XN) ;
%
    Coef(1:4) = Sc(1:4,K)           ;
%----------------------------------------
%  (2) Non-dimensional Variable
%----------------------------------------
    Tau = ( Xp - XN(K,1) ) /( XN(K+1,1) - XN(K,1) ) ;
%----------------------------------------
%  (3) Function Value using Spline Polynomuials
%----------------------------------------
    Yp = Coef(1) + ( Coef(2) + ( Coef(3) + Coef(4)*Tau )*Tau )*Tau ;
%----------------------------------------
end 
%----------------------------------------
