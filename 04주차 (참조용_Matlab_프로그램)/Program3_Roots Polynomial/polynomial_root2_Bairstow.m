%------------------------------------------------------------------------------------------
% Finding two roots of an n-th order polynomial using Bairstow's method (Polynomial Deflation)
% y = a(1,1)+a(2,1)*x + a(3,1)*x^2 + .... + a(n+1,1)*x^n
%   = (x^2+q1*x+q0)*[b(1,1)+b(2,1)*x + b(3,1)*x^2 +....+ b(n-1,1)*x^(n-2)]
% roots = 0.5*[-q1+-sqrt(q1^2-4*q0)]
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
%     b          : coeficients of the remained quotient polynomial (order = n-2)
%     r          : coefficient of the residual polynomial (order= 1:r1*x + r0)
%     root       : two roots in complex form
%-------------------------------------------------------------------------
function [b,r,root_real,root_imag,iter]=polynomial_root2_Bairstow(n,a,root1_real0,root1_imag0,root2_real0,root2_imag0,epsilon,alpha,iter_max)
%-------------------------------------------------------------------------
% (1) initial setting of small increment for Newton-Raphson method
%-------------------------------------------------------------------------
delq = 0.01;
%-------------------------------------------------------------------------
% (2) define intial 2nd order polynomial quotient: x^2 + q1*x + q0
%-------------------------------------------------------------------------
% Check the validity of initial roots
error_flag = 0.0;
if root1_real0 ~= root2_real0  % check whether real parts are not equal
    if root1_imag0 ~= 0.0
        error_flag  = 1.0;
    end
    if root2_imag0 ~= 0.0
        error_flag  = 2.0;
    end
else                           % check whether imaginary parts have opposite signs
    if root1_imag0 ~= -root2_imag0
        error_flag  = 3.0;
    end
end
%
if error_flag ~= 0.0
    disp('error in sepcifying the initial roots')
    if error_flag  == 1.0 ; disp('imaginary part of root #1 should be zero');end
    if error_flag  == 2.0 ; disp('imaginary part of root #2 should be zero');end
    if error_flag  == 3.0 ; disp('imaginary parts of two roots should have opposite signs');end
    b         = 0.0;
    r         = 0.0;
    root_real = 0.0;
    root_imag = 0.0; 
    return
end
% intial 2nd order polynomial quotient: x^2 + q1*x + q0
q1  = -(root1_real0 + root2_real0);
q0  =   root1_real0*root2_real0 - root1_imag0*root2_imag0;
% make vector q_new = [q0,q1]^T
q_new(1,1) = q0;
q_new(2,1) = q1;
%-------------------------------------------------------------------------
% (3) Newton-Raphson method to zerorise the resudual polynomial
%-------------------------------------------------------------------------
delq_h = 0.5/delq;
iter = 0;
iter_disp          = 1;
iter_disp_interval = 5;
iter_text          = 0;
%
disp('    iter      q0        q1        err_fun   err_cor   r0        r1') 
for j=1:1:iter_max;
    iter = iter + 1;
%-------------------------------------------------------------------------
% (3-1) Gradient calculation 
%-------------------------------------------------------------------------
%
%  (3-1-1) current coefficient values of residual polynomial
%
    q0           = q_new(1,1) ;
    q1           = q_new(2,1) ;
%
    q_old(1:2,1) = q_new(1:2,1);
%
    [b,r_current]=polynomial_deflation2(n,a,q1,q0);
%
%  (3-1-2) positive pertubation of q0
%
    q0_old = q0;
    q0 = q0_old + delq;
    [b,r_q0_p]=polynomial_deflation2(n,a,q1,q0);
%
%  (3-1-3) negative pertubation of q0
%
    q0 = q0_old - delq;
    [b,r_q0_m]=polynomial_deflation2(n,a,q1,q0);
%
%  (3-1-4)gradient matrix for variable q0  and recover q0
%
    q0 = q0_old;
    grad(1:2,1) = delq_h*(r_q0_p(1:2,1) - r_q0_m(1:2,1));
%
%  (3-1-5) positive pertubation of q1
%
    q1_old = q1;
    q1 = q1_old + delq;
    [b,r_q1_p]=polynomial_deflation2(n,a,q1,q0);
%
%  (3-1-6) negative pertubation of q1
%
    q1 = q1_old - delq;
    [b,r_q1_m]=polynomial_deflation2(n,a,q1,q0);
%
%  (3-1-7) gradient matrix for variable q1 and recover q1
%
    q1 = q1_old;
    grad(1:2,2) = delq_h*(r_q1_p(1:2,1) - r_q1_m(1:2,1));   
%-------------------------------------------------------------------------
% (3-2) Newton-Raphson Iteration
%-------------------------------------------------------------------------
    q_correction = alpha*inv(grad)*r_current ;
    q_new        = q_old - q_correction      ;
%-------------------------------------------------------------------------
% (3-3) Convergence check
%-------------------------------------------------------------------------
    err_function   = sqrt(r_current(1,1)^2    + r_current(2,1)^2);
    err_correction = sqrt(q_correction(1,1)^2 + q_correction(2,1)^2);
%
    if iter > iter_disp
        iter_disp = iter_disp + iter_disp_interval;
%
        iter_text = iter_text + 1;
        if iter_text > 20
            disp('    iter      q0        q1        err_fun   err_cor   r0        r1') ;
            iter_text = 0;
        end
%
        disp_data(1,1) = iter;
        disp_data(1,2) = q_new(1,1);
        disp_data(1,3) = q_new(2,1); 
        disp_data(1,4) = err_function;
        disp_data(1,5) = err_correction;
        disp_data(1,6) = r_current(1,1);
        disp_data(1,7) = r_current(2,1);
%
        disp(disp_data);
    end
%
    if err_function <= epsilon
        disp('solution converged with err_function');disp(err_function);
        disp('     < epsilon='); disp(epsilon);
        break
    end
%
    if err_correction <= epsilon
        disp('solution converged with err_correction');disp(err_correction);
        disp('     < epsilon=');disp(epsilon);
        break
    end
% 
end
%-------------------------------------------------------------------------
% (4) Computaion of two roots
%-------------------------------------------------------------------------
    q0           = q_new(1,1) ;
    q1           = q_new(2,1) ;
% computation of quotient and residual polynomials 
    [b,r]=polynomial_deflation2(n,a,q1,q0);
% computing roots
    dd = q1*q1 - 4.0*q0;
    real_part = -0.5*q1;
    imag_part =  0.5*sqrt(abs(dd));
    if dd<0.0
        root_real(1:2,1) = real_part;
        root_imag(1,1)   = imag_part;
        root_imag(2,1)   =-imag_part;
    else
        root_imag(1:2,1) = 0.0;
        root_real(1,1)   = real_part + imag_part;
        root_real(2,1)   = real_part - imag_part;
    end
% Display
    root(1:2,1) = root_real(1:2,1)+i*root_imag(1:2,1);
    root
%-------------------------------------------------------------------------
% Example Test #1 y=x^3-1 = (x^2+x+1)(x-1)
%  n=3;a(1:4,1) = 0.0;a(4,1)=1.0;a(1,1)=-1.0;
%  root1_real0=-0.5;root1_imag0=0;root2_real0=-0.5;root2_imag0=0;epsilon=0.00001;alpha = 1.0;iter_max = 1000;
%  [b,r,root_real,root_imag,iter]=polynomial_root2_Bairstow(n,a,root1_real0,root1_imag0,root2_real0,root2_imag0,epsilon,alpha,iter_max)
%
%  Answer: 
%    root = [-0.5000 + 0.8660i,   -0.5000 - 0.8660i]^T
%    b    = [-1, 1]^T
%    r    = 1.0e-005 *[-0.5722,  0.5722]^T
%    iter = 6
%-------------------------------------------------------------------------
% Example #2 y=x^4+x^2+1 = (x^2+x+1)(x^2-x+1)
%    n=3;a(1:4,1) = 0.0;a(4,1)=1.0;a(1,1)=-1.0;
%    root1_real0= 0.5;root1_imag0=0;root2_real0=0.5;root2_imag0=0;epsilon=0.00001;alpha = 1.0;iter_max = 1000;
%    [b,r,root_real,root_imag,iter]=polynomial_root2_Bairstow(n,a,root1_real0,root1_imag0,root2_real0,root2_imag0,epsilon,alpha,iter_max)
%
%  Answer: not converged
%   root = [1.0000,  0.5301]^T
%   iter = 1000
%-------------------------------------------------------------------------
% Example #3 y=x^4+x^2+1 = (x^2+x+1)(x^2-x+1)
%    n=3;a(1:4,1) = 0.0;a(4,1)=1.0;a(1,1)=-1.0;
%    root1_real0= 0.5;root1_imag0=0;root2_real0=0.5;root2_imag0=0;epsilon=0.00001;iter_max = 1000;
%    [b,r,root_real,root_imag,iter]=polynomial_root2_Bairstow(n,a,root1_real0,root1_imag0,root2_real0,root2_imag0,epsilon,alpha,iter_max)
%   
%   The results
%    (1) alpha = 1.0 : diverged  iter = 1000; root =[1.0000,0.5301]^T
%    (2) alpha = 0.9 ; diverge   iter = 1000; root =[1.0378,1.0000]^T
%    (3) alpha = 0.8 ; converge  iter = 16  ; root =[-0.5000 + 0.8660i,-0.5000 - 0.8660i]^T
%    (4) alpha = 0.7 ; converge  iter = 42  ; root =[-0.5000 + 0.8660i,-0.5000 - 0.8660i]^T
%    (5) alpha = 0.6 ; converge  iter = 22  ; root =[-0.5000 + 0.8660i,-0.5000 - 0.8660i]^T
%    (6) alpha = 0.5 ; converge  iter = 20  ; root =[-0.5000 + 0.8660i,-0.5000 - 0.8660i]^T
%    (7) alpha = 0.4 ; diverge   iter = 1000; 
%    (8) alpha = 0.3 ; diverge   iter = 1000;  
%    (9) alpha = 0.2 ; converge  iter = 78  ; root =[-0.5000 + 0.8660i,-0.5000 - 0.8660i]^T
%   (10) alpha = 0.1 ; converge  iter = 177 ; root =[-0.5000 + 0.8660i,-0.5000 - 0.8660i]^T
%   (10) alpha = 0.05; converge  iter = 287 ; root =[-0.5000 + 0.8660i,-0.5000 - 0.8660i]^T
%-------------------------------------------------------------------------
