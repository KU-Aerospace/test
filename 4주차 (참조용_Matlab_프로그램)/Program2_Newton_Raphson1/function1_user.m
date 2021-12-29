%-------------------------------------------------------------------------
% objective : computing function & its gradient,which are provided by users
%-------------------------------------------------------------------------
% Input Variables 
%    ncase  : function type
%             ncase = 1 --> [f1]                  f1 = 3x^2
%             ncase = 2 --> [f2]                  f2 = cos(x)
%             ncase = 3 --> [f3,f4]^t             f3 = x^2 + y^2 + 2x
%                                                 f4 = cos(x) +2sin(y)
%    x      : current values of each variable
%-------------------------------------------------------------------------
% Output Variables 
%    fexact(no_fun)     : function values at x
%    fgrad_eaxct(:,:)   : function gradient at x
%-------------------------------------------------------------------------
function [fun]=function1_user(x)
%-------------------------------------------------------------------------
%  function #1
    fun = x*(x-1.0)*(x-2.0)*(x-2.0);
%-------------------------------------------------------------------------
%  funtion #2
%    fun = cos(x)
%-------------------------------------------------------------------------
