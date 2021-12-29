%------------------------------------------------------------------------------------------
% Finding roots for the 1st order and the 2nd order polynomial equations
% y = a(1,1)+a(2,1)*x + a(3,1)*x^2
%------------------------------------------------------------------------------------------
% Input
%     a(3,1)          : polynomial coefficients
%     epsilon_eisilon : very very small number (0.1^16)
%------------------------------------------------------------------------------------------
% Output
%     m          : number of roots
%     root_real  : real parts of roots
%     root_imag  : imaginary parts of roots
%-------------------------------------------------------------------------
function [m,root_real,root_imag] = root_formula(a,epsilon_eisilon)
%-------------------------------------------------------------------------
%  Computaion of two roots
%-------------------------------------------------------------------------
    root_real(1:2,1) = 0.0;
    root_imag(1:2,1) = 0.0;
%    
    aa = a(3,1);
    bb = a(2,1);
    cc = a(1,1);
%
    if abs(aa) < epsilon_eisilon
        if abs(bb) < epsilon_eisilon
            m = 0;
            return
        else
            m = 1;
            root_real(1,1) = -cc/bb;
            return
        end
    else
        m  = 2;
        dd = bb*bb - 4.0*aa*cc;
        coef           =  0.5/aa;
        real_part      = -bb*coef;
        imag_part      =  sqrt(abs(dd))*coef;
%        
        if dd < 0.0
            root_real(1:2,1) = real_part;
            root_imag(1,1)   = imag_part;
            root_imag(2,1)   =-imag_part;
        else
            root_imag(1:2,1) = 0.0;
            root_real(1,1)   = real_part + imag_part;
            root_real(2,1)   = real_part - imag_part;
        end
    end
%-------------------------------------------------------------------------
%    Example #1
%    epsilon=0.00000001;a(1,1) =1;a(2,1)=2;a(3,1)=1;[m,root_real,root_imag] = root_formula(a,epsilon)
%    root = root_real+j*root_imag
%-------------------------------------------------------------------------
