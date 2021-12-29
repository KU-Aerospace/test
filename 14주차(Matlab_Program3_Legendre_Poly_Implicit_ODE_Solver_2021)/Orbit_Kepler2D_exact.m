%-------------------------------------------------------------------------
function [ye] = Orbit_Kepler2D_exact(tau,eccen,T)
%-------------------------------------------------------------------------
  Mue_E = 3.98600435608E+05 ;
  r_E   = 6378.145              ; % Earth's radius
  r_P   = r_E + 100.0           ; % Perigee radius
  P     = (1.0+eccen)*r_P       ; % orbital constant p
  AA    = P/(1.0-eccen^2)       ; % semi major axis
  AA    = P/(1.0-eccen^2)       ; % semi major axis
  Fn    = sqrt(Mue_E/AA^3)      ; % Angular speed of Mean Anomaly
%-------------------------------------------------------------------------
%  (1) Dimentional Time
%-------------------------------------------------------------------------
  t  = T*tau ;
%-------------------------------------------------------------------------
%  (2) Mean Anomaly
%-------------------------------------------------------------------------
  AM = Fn*t              ; % Mean Anomaly (M)
%-------------------------------------------------------------------------
%  (3) Eccentric Anomaly using Iterative Method
%-------------------------------------------------------------------------
  EE = AM                ; % Initialize
  iter_max = 50          ; %
  ToL_max  = 1.0E-08     ; %
  %
  for it = 1:iter_max
      Funn = EE  - eccen*sin(EE) - AM   ;
      Gfun = 1.0 - eccen*cos(EE)       ;
%
      EE = EE - Funn/Gfun              ; % Newton-Raphson method
%
      if ( abs(Funn) < ToL_max)
          break
      end
  end
%-------------------------------------------------------------------------
%  (4) Compute Theta
%-------------------------------------------------------------------------
  cEE = cos(EE)  ; sEE = sin(EE)                ;
  cth = (cEE - eccen)/(1.0 - eccen*cEE)         ;
  sth = sEE*sqrt(1.0-eccen^2)/(1.0 - eccen*cEE) ;
%-------------------------------------------------------------------------
%  (5) Compute Exact Solution
%-------------------------------------------------------------------------
   coef   = 1.0 + eccen*cth ;
%
   r      =  P/coef                    ; % r
   dot_th =  sqrt(P*Mue_E)/r^2         ; % dot_theta
   dot_r  =  P*eccen*dot_th*sth/coef^2 ; 
%   
   ye(1)  = dot_r          ; % Vr
   ye(2)  = r*dot_th       ; % Vth
   ye(3)  = r              ; % r
   ye(4)  = atan2(sth,cth) ;  % th
%-------------------------------------------------------------------------- 
end
%-------------------------------------------------------------------------

