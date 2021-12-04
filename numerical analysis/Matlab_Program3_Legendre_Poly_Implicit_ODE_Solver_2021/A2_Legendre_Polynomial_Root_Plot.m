%-------------------------------------------------------------------------
%  (1) Parameters and nodes
%-------------------------------------------------------------------------
clear all; close all;
Norder =   9  ;
Node   = 101 ;
dtau   = 2.0/(Node-1) ;
for  j=1:Node
     taun(j) = -1.0 + dtau*(j-1) ;
end
%-------------------------------------------------------------------------
%  (2) Compute Legendre Function
%-------------------------------------------------------------------------
for  j=1:Node
     tau1 = taun(j)  ;
     [fL,dfL] = L1_Legendre_Poly(Norder,tau1) ;
     funL(j)  = fL ;
end
[tau_vec] = L2_Legendre_Poly_Roots(Norder) ;
yyy_vec(1:Norder) = 0.0                         ; 
figure(1)
     plot(taun,funL,'-r') ; hold on; grid on
     plot(tau_vec,yyy_vec,'bs') ;
     