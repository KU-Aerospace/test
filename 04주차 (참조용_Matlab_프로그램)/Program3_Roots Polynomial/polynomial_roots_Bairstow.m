%------------------------------------------------------------------------------------------
% Finding all roots of an n-th order polynomial using Bairstow's method (Polynomial Deflation)
% y = a(1,1)+a(2,1)*x + a(3,1)*x^2 + .... + a(n+1,1)*x^n
%------------------------------------------------------------------------------------------
% Input
%     n          : the order of polynomial
%     a(n+1,1)   : polynomial coefficients
%     root1_real0: real      part of the initial guess of one root
%     root1_imag0: imaginary part of the initial guess of one root
%     root2_real0: real      part of the initial guess of the other root
%     root2_imag0: imaginary part of the initial guess of the other root
%     epsilon    : tolerance
%     alpha      : under relaxation factor ((0,1])
%     iter_max    : allowd maximum number of iteration
%------------------------------------------------------------------------------------------
% Output
%     nroot              : number of roots found
%     root_real(nroot,1) : real      parts of roots
%     root_imag(nroot,1) : imaginary parts of roots
%     nresid             : number of the 1st order residual function
%     residual(nresid,2) : coefficients of the 1st order residual function
%     iter_root(nresid,1): iteration number for each polynomial-deflation routine
%-------------------------------------------------------------------------------------------
function [nroot,root_real,root_imag,nresid,residual,iter_root]=polynomial_roots_Bairstow(n,a,root1_real0,root1_imag0,root2_real0,root2_imag0,epsilon,alpha,iter_max)
%-------------------------------------------------------------------------------------------
% (1) intialize parameter
%-------------------------------------------------------------------------------------------
epsilon_eisilon = 0.1^16;
nroot           = 0     ;
nresid          = 0;
residual(1,1:2) = 0.0;
iter_root(1,1)  = 0;
%-------------------------------------------------------------------------------------------
% (2) define maximum number of root search using function (polynomial_root2_Bairstow)
%-------------------------------------------------------------------------------------------
iter_root_max = n/2 + 1 ; % maximum number of root search using (polynomial_root2_Bairstow)
%-------------------------------------------------------------------------------------------
% (3) Check the polynomial order
%-------------------------------------------------------------------------------------------
if n < 3
    [nroot,root_real,root_imag] = root_formula(a,epsilon_eisilon);
    return
end
%-------------------------------------------------------------------------------------------
% (4) iterative root-finding
%-------------------------------------------------------------------------------------------
for iter1 = 1:1:iter_root_max
    [b,r,r_real,r_imag,iter]=polynomial_root2_Bairstow(n,a,root1_real0,root1_imag0,root2_real0,root2_imag0,epsilon,alpha,iter_max)
    n1 = nroot +  1;
    n2 = nroot +  2;
    root_real(n1:n2,1) = r_real(1:2,1);
    root_imag(n1:n2,1) = r_imag(1:2,1);    
%    
    nroot                = nroot + 2  ;
    nresid               = nresid+ 1  ;
    residual(nresid,1:2) = r(1:2,1)   ;
    iter_root(nresid,1)  = iter       ;
%-------------------------------------------------------------------------------------------
% (5) Preparation of next iteration
%-------------------------------------------------------------------------------------------
    n          = n - 2     ;
    a          = 0.0       ;
    a(1:n+1,1) = b(1:n+1,1);
    b          = 0.0       ;
%
    root1_real0= r_real(1,1);     root1_imag0= r_imag(1,1);
    root2_real0= r_real(2,1);     root2_imag0= r_imag(2,1);
%
%   Check the polynomial order
%
    if n < 3
        if n == 1
            a(3,1) = 0.0;
        end
%            
       [nroot1,r_real,r_imag] = root_formula(a,epsilon_eisilon);
        n1 = nroot + 1     ;
        n2 = nroot + nroot1;
        root_real(n1:n2,1) = r_real(1:nroot1,1);
        root_imag(n1:n2,1) = r_imag(1:nroot1,1);    
%    
        nroot                = nroot  + nroot1  ;
        nresid               = nresid + 1       ;
        residual(nresid,1:2) = 0.0 ;
        iter_root(nresid,1)  = 0   ;
%
        return
    end

end
%-------------------------------------------------------------------------
% Example Test #1 n=8
% (a) MATLAB
%>>  p=[1 2 3 4 5 6 7 8 9];
%>>  rmat = roots(p)
%    rmat =
%      -1.2888 + 0.4477i
%      -1.2888 - 0.4477i
%      -0.7244 + 1.1370i
%      -0.7244 - 1.1370i
%       0.1364 + 1.3050i
%       0.1364 - 1.3050i
%       0.8767 + 0.8814i
%       0.8767 - 0.8814i
% (b) BAIRSTOW
%>>    n = 8; a=[9;8;7;6;5;4;3;2;1];
%>>    root1_real0 = 0.0; root1_imag0 = 0.0; root2_real0 = 0.0;root2_imag0 = 0.0;
%>>    epsilon     = 0.1^8;  alpha       = 1.0; iter_max    = 1000;
%    
%>>    [nroot,root_real,root_imag,nresid,residual,iter_root] &
%       =polynomial_roots_Bairstow(n,a,root1_real0,root1_imag0,root2_real0,root2_imag0,epsilon,alpha,iter_max)
%>> nroot
%   nroot =  8
%>> nresid
%   nresid = 4
%>>   root1 = root_real+i*root_imag
%     root1 =
%        0.1364 + 1.3050i
%        0.1364 - 1.3050i
%       -1.2888 + 0.4477i
%       -1.2888 - 0.4477i
%       -0.7244 + 1.1370i
%       -0.7244 - 1.1370i
%        0.8767 + 0.8814i
%        0.8767 - 0.8814i
%>> residual
%   residual =
%          1.0e-012 *
%            0.5720   -0.1421
%            0.0009   -0.0007
%            0.0009   -0.5009
%                 0         0
%>> iter_root
%   iter_root =
%            8
%            13
%            6
%            0
%>> figure(1),p1=plot(rmat,'ob');grid;hold on;p2=plot(root1,'sr');xlabel('real part');ylabel('imaginary part');legend([p1,p2],'MATLAB','BAIRSTOW')
%-------------------------------------------------------------------------
% Example Test #2 n=9
% (a) MATLAB
%>>   p=[1 2 3 4 5 6 7 8 9 10];
%>>   rmat = roots(p)
%     rmat =
%      -1.3386          
%      -1.0970 + 0.7570i
%      -1.0970 - 0.7570i
%      -0.4657 + 1.2295i
%      -0.4657 - 1.2295i
%       0.3103 + 1.2423i
%       0.3103 - 1.2423i
%       0.9217 + 0.7964i
%       0.9217 - 0.7964i
% (b) BAIRSTOW
%>>    n = 9; a=[10;9;8;7;6;5;4;3;2;1];
%>>    root1_real0 = 0.0; root1_imag0 = 0.0; root2_real0 = 0.0;root2_imag0 = 0.0;
%>>    epsilon     = 0.1^8;  alpha       = 1.0; iter_max    = 1000;
%    
%>>    [nroot,root_real,root_imag,nresid,residual,iter_root] 
%       =polynomial_roots_Bairstow(n,a,root1_real0,root1_imag0,root2_real0,root2_imag0,epsilon,alpha,iter_max)
%>> nroot
%   nroot =   9
%>> nresid
%   nresid =   5
%>> root1 = root_real+i*root_imag
%   root1 =
%      0.3103 + 1.2423i
%      0.3103 - 1.2423i
%     -1.0970 + 0.7570i
%     -1.0970 - 0.7570i
%      0.9217 + 0.7964i
%      0.9217 - 0.7964i
%     -0.4657 + 1.2295i
%     -0.4657 - 1.2295i
%     -1.3386          
%>> residual
%   residual =
%     1.0e-011 *
%      -0.1982   -0.0229
%      -0.0259   -0.0319
%      -0.0019    0.0093
%            0   -0.0000
%            0         0
%>> iter_root
%   iter_root =
%       13
%       20
%       11
%        7
%        0
%>> figure(1),p1=plot(rmat,'ob');grid;hold on;p2=plot(root1,'sr');xlabel('real part');ylabel('imaginary part');legend([p1,p2],'MATLAB','BAIRSTOW')%-------------------------------------------------------------------------
