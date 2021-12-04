%----------------------------------------
%  Newton-Polynomial-Interpolation Coefficients
%----------------------------------------
function [Fint] = B6_Newton_Interpolation_Intg(Node,A,W)
%-----------------------------------------
   Fint = A(1) ;
   for k=1:Node-1 
       kp= k+1 ;
       Fint = Fint + A(kp)*W(k) ;
   end
%-----------------------------------------
end
%-----------------------------------------