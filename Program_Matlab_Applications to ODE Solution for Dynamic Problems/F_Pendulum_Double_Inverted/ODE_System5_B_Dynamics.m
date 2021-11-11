%-------------------------------------------------------------------------
function [dot_y] = ODE_System5_B_Dynamics(y,t)
%-------------------------------------------------------------------------
   th1   =  y(1)  ; % angle of mass 1
   th2   =  y(2)  ; % angle of mass 2
   dth1  =  y(3)  ; % angular velocity of mass 1
   dth2  =  y(4)  ; % angular velocity of mass 2
%
   cth1  = cos(th1) ; sth1 = sin(th1) ;
   cth2  = cos(th2) ; sth2 = sin(th2) ;
%
   dth1P2 = dth1*dth1  ;
   dth2P2 = dth2*dth2  ; 
%-------------------------------------------------------------------------
   Density  = 1.2250       ;
   GravCoef = 9.8          ;
   Length1  = 1.0          ;    Length2  = 1.0          ;
   CD1      = 0.50         ;    CD2      = 0.50         ;
   Mass1    = 0.25         ;    Mass2    = 0.25         ;
   Radius1  = 0.1          ;    Radius2  = 0.1          ;
   Area1    = pi*Radius1^2 ;    Area2    = pi*Radius1^2 ;
%-------------------------------------------------------------------------
% (1) Displacement and velocity vectors of pendulums
%-------------------------------------------------------------------------
   r1_vec(1) = Length1*sth1 ; r2_vec(1) = Length2*sth2 ; 
   r1_vec(2) = Length1*cth2 ; r2_vec(2) = Length2*sth2 ; 
%
   omega1 = -dth1           ; omega2 = -dth2 ;
%   
   v1_vec(1) = -omega1*r1_vec(2)   ;
   v1_vec(2) =  omega1*r1_vec(1)   ;
   speed1    =  sqrt(  v1_vec(1)^2 + v1_vec(2)^2  ) ;
%
   v2_vec(1) =  v1_vec(1) - omega2*r2_vec(2)   ;
   v2_vec(2) =  v1_vec(1) + omega2*r2_vec(1)   ;
   speed2    =  sqrt(  v2_vec(1)^2 + v2_vec(2)^2  ) ;
%
   CoefA1 = -CD1*Density*Area1*0.5*speed1 ;
   CoefA2 = -CD2*Density*Area2*0.5*speed2 ;
%-------------------------------------------------------------------------
% (2) M-matrix and its inverse
%-------------------------------------------------------------------------
     fm11 = Mass1*Length1^2 + Mass2*Length2^2    ;
     fm12 = Mass2*Length1*Length2*cos(th1 - th2) ;
     fm21 = fm12                                 ;
     fm22 = Mass2*Length2^2                      ;
%
     det = fm11*fm22 - fm12*fm21                 ;
     fm_inv(1,1) =  fm22   ; fm_inv(1,2) = -fm12 ;
     fm_inv(2,1) = -fm21   ; fm_inv(2,2) =  fm11 ;
%
     fm_inv(1:2,1:2) = fm_inv(1:2,1:2)/det       ;
%-------------------------------------------------------------------------
% (3) C-matrix  
%-------------------------------------------------------------------------
     cm(1,1) = (Mass1 + Mass2)*sin(2.0*th1)*Length1^2 ;
     cm(1,2) =  Mass2*Length1*Length2*sin(th1 + th2)  ;
     cm(2,1) =  cm(1,2)                               ;
     cm(2,2) =  Mass2*Length2^2 ;

%-------------------------------------------------------------------------
% (4) Gravity and aerodynamic forces
%-------------------------------------------------------------------------
    force2(1:2) = CoefA2*v2_vec(1:2)                ;
    force2(2)   = force2(2)  + Mass2*GravCoef       ;
%
    force1(1:2) = CoefA1*v1_vec(1:2) + force2(1:2)  ;
    force1(2)   = force1(2)      + Mass1*GravCoef  ;
%-------------------------------------------------------------------------
% (5) z-axis Components of rotational moments
%-------------------------------------------------------------------------
    Moment(1) = r1_vec(1)*force1(2)-r1_vec(2)*force1(1) ;
    Moment(2) = r2_vec(1)*force2(2)-r2_vec(2)*force2(1) ;
%-------------------------------------------------------------------------
% (6) Assemble Right-Hand-Side
%-------------------------------------------------------------------------
    vec(1) = dth1P2   ; vec(2) = dth1P2 ;
%    
    Moment(1) = Moment(1) + cm(1,1)*vec(1) + cm(1,2)*vec(2) ;
    Moment(2) = Moment(2) + cm(2,1)*vec(1) + cm(2,2)*vec(2) ;
%-------------------------------------------------------------------------
% (6) Motion Equations
%-------------------------------------------------------------------------
    dot_y(1) = dth1 ;
    dot_y(2) = dth2 ;
%
    dot_y(3) =  fm_inv(1,1)*Moment(1) +  fm_inv(1,2)*Moment(2) ;
    dot_y(4) =  fm_inv(2,1)*Moment(1) +  fm_inv(2,2)*Moment(2) ;
%
    dot_y(3:4) = -dot_y(3:4)                                   ;
%-------------------------------------------------------------------------
