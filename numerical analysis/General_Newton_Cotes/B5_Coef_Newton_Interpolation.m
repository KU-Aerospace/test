%----------------------------------------
%  Newton-Polynomial-Interpolation Coefficients
%----------------------------------------
function [A] = B5_Coef_Newton_Interpolation(Node,T,F,Beta)
%-----------------------------------------
%  (1) 1st and Second Coefficients
%-----------------------------------------
   A(1) = F(1) ;
%  
   T1   = T(2)             ;
   Coef(1:2) = Beta(1:2,1) ;
   Fun1      = B2_Basis_Function_Value(1,T1,Coef) ;
   A(2) = (F(2) - A(1) )/Fun1                    ;
%-----------------------------------------
   for j =3:Node
       jm = j-1 ;
%-----------------------------------------
%  (5-1) Basis Function Values at T(j)
%-----------------------------------------
       T1 = T(j) ; 
%
       Fun_vec(1:jm) = 0.0 ;
       for k=1:jm
           kp = k + 1 ;
           Coef(1:kp) = Beta(1:kp,k)                      ;
           Fun_vec(k) = B2_Basis_Function_Value(k,T1,Coef) ;
       end
%-----------------------------------------
%  (5-2) Coefficients for Newton’s Interpolation
%-----------------------------------------
       sum1 = F(j) - A(1) ;
       for k=2:j-1
           km = k - 1; 
           sum1 = sum1 - A(k)*Fun_vec(km) ;
       end
       A(j) = sum1/Fun_vec(jm) ;
   end
%-----------------------------------------
end
%-----------------------------------------