%-----------------------------------------
%  Test Program for Generalized Newton-Cotes Integration Formula
%-----------------------------------------
%  (1) Number of Nodes and User Functions f(x) = exp(x)  0<= x <=2
%-----------------------------------------
    Node =   10 ;
    Xmin =  0.0 ;
    Xmax =  3.0 ;
%-----------------------------------------
%  (2) Uniform node generation and function evaluation
%-----------------------------------------
    DeLX = (Xmax-Xmin)    ;
    dX   = DeLX /(Node-1) ;
    for j= 1: Node
        X1 = Xmin + dX*(j-1)    ;
        F1 = User_Function1(X1) ;
%        
        X(j) = X1 ;
        F(j) = F1 ;
        T(j) = (X1-Xmin)/DeLX ; % Tau
    end
%-----------------------------------------
%  (3) Basis Function Coefficients
%-----------------------------------------
   Beta = B1_Basis_Function_Coef(Node,T) ;
%-----------------------------------------
%  (4) Integration of Basis Functions 
%-----------------------------------------
   W = B3_Basis_Function_Intg(Node,Beta) ;
%-----------------------------------------
%  (5) Coefficients for Newton’s Interpolation
%-----------------------------------------
   A = B5_Coef_Newton_Interpolation(Node,T,F,Beta) ;
%-----------------------------------------
%  (6) Integration of Newten-Interpolation Function
%-----------------------------------------
   Fint = B6_Newton_Interpolation_Intg(Node,A,W);
%-----------------------------------------
%  (6-1) Resut of Newton-Cotes Integration
%-----------------------------------------
   Fint_NC    = Fint*DeLX  ;
%-----------------------------------------
%  (6-2) Exact Integration
%-----------------------------------------
   Fint_exact = User_Function1_intg_Exact(Xmax) - User_Function1_intg_Exact(Xmin);
%-----------------------------------------
%  (6-3) Error in Newton-Cotes Integration
%-----------------------------------------
   Fint_err = Fint_exact - Fint_NC;
%-----------------------------------------
%  (6-4) Display
%-----------------------------------------
X1=sprintf('  (1)  Resut of Newton-Cotes Integration:     Fint_NewtonCotes =  %d',Fint_NC);
X2=sprintf('  (2)  Exact                 Integration:     Fint_exact       =  %d',Fint_exact);
X3=sprintf('  (3)  Error in Newton-Cotes Integration:     Fint_Error       =  %d',Fint_err);
%
disp(X1)
disp(X2)
disp(X3)
%-----------------------------------------
%
%-----------------------------------------
        
 