%----------------------------------------
%  Data  
%    Input: 
%          Xp      : Input X-position
%          N       : Number of total data
%          XN(N,1) : Data in Increasing Order
%          Sc(1:4,N-1) : Cubic Spline Coefficients
%    Output
%          dYp, ddYp  : Estimated first and second derivatives  
%----------------------------------------
function [dYp,ddYp] = CubicSpline_Evaluate_Derivatives(Xp,N,XN,Sc)
%----------------------------------------
%  (1) Finding Interval and Spline Coefficients
%----------------------------------------
    [K] = Interval_Finding(Xp,N,XN) ;
%
    Coef(1:4) = Sc(1:4,K)           ;
%----------------------------------------
%  (2) Non-dimensional Variable
%----------------------------------------
    Dx  = XN(K+1,1) - XN(K,1) ;
    Tau = ( Xp - XN(K,1) )/Dx ;
%----------------------------------------
%  (3) Function Value using Spline Polynomuials
%----------------------------------------
    dYp  = Coef(2) + ( 2.0*Coef(3) + 3.0*Coef(4)*Tau )*Tau ;
    ddYp = 2.0*Coef(3) + 6.0*Coef(4)*Tau                   ;
%
    dYp  =  dYp/Dx    ;
    ddYp = ddYp/Dx^2  ;
%----------------------------------------
end 
%----------------------------------------
