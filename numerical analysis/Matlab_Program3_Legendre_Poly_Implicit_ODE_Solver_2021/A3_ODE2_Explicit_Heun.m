%-------------------------------------------------------------------------
%  Explicit Heun's Method
%-------------------------------------------------------------------------
% (1) Initial conditions ans solution parameters
%-------------------------------------------------------------------------
   eccen = 0.05 ;
%   
   [y0,Nstep,taumax,T] = ODE_System_Init(eccen) ;
%
   DeLtau = taumax/(Nstep-1) ;
%-------------------------------------------------------------------------
% (2) ODE Solver
%-------------------------------------------------------------------------
   y(1:4) = y0(1:4) ;
%
   tvec(1)     = 0.0                 ;
   yvec(1:4,1) = y(1:4)              ; 
   yvec(  5,1) = y(3)                ; 
   yvec(  6,1) = 0.0                 ; 
   evec(1:4,1) = 0.0                 ;
%-------------------------------------------------------------------------
   for J = 1:Nstep  ;
%-------------------------------------------------------------------------
       Jp = J + 1   ;
       tau     = DeLtau*(J-1)                   ;
%-------------------------------------------------------------------------
% (2-1) Heun's Method
%-------------------------------------------------------------------------
% Predictor Step
       [dot_y1] = ODE_System_Dynamics(y,tau,T) ;
       yp(1:4)  = y(1:4) + DeLtau*dot_y1(1:4)  ;
% Corrector Step
       tau1 = tau + DeLtau ;
       [dot_y2] = ODE_System_Dynamics(yp,tau1,T) ;
       y(1:4)  = y(1:4) +0.5*DeLtau*( dot_y1(1:4)+dot_y2(1:4) ) ;
%-------------------------------------------------------------------------
% (2-2) Exact solution
%-------------------------------------------------------------------------
       [ye] = Orbit_Kepler2D_exact(tau,eccen,T)    ;
%-------------------------------------------------------------------------
% (2-3) Save Results
%-------------------------------------------------------------------------
       tvec(Jp)     = (tau + DeLtau)*T/3600.;
       yvec(1:4,Jp) = y(1:4)                ; 
%
       th = y(4) ; cth = cos(th) ; sth = sin(th) ;
       yvec(5,Jp)   = y(3)*cth         ; 
       yvec(6,Jp)   = y(3)*sth         ; 
       evec(1:4,Jp) = abs(y(1:4)-ye(1:4)) ;
%-------------------------------------------------------------------------
   end
%-------------------------------------------------------------------------
% (3) Plot Results
%-------------------------------------------------------------------------
   LW  =  2 ; 
   mark='-r';
   pirat = 180.0/pi;  
% 
   figure(1);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
      subplot(4,2,1), plot(tvec(:),yvec(1,:),mark)       ; grid on; hold on;xlabel('time (hr)');ylabel('V_r (km/sec)')
      subplot(4,2,2), plot(tvec(:),evec(1,:),mark)       ; grid on; hold on;xlabel('time (hr)');ylabel('err-V_r (km/sec)')
      subplot(4,2,3), plot(tvec(:),yvec(2,:),mark)       ; grid on; hold on;xlabel('time (hr)');ylabel('V_{\theta} (km/sec)')
      subplot(4,2,4), plot(tvec(:),evec(2,:),mark)       ; grid on; hold on;xlabel('time (hr)');ylabel('err-V_{\theta} (km/sec)')
      subplot(4,2,5), plot(tvec(:),yvec(3,:),mark)       ; grid on; hold on;xlabel('time (hr)');ylabel('r (km)')
      subplot(4,2,6), plot(tvec(:),evec(3,:),mark)       ; grid on; hold on;xlabel('time (hr)');ylabel('err-r (km)')
      subplot(4,2,7), plot(tvec(:),yvec(4,:)*pirat,mark) ; grid on; hold on;xlabel('time (hr)');ylabel('\theta (deg)')
      subplot(4,2,8), plot(yvec(5,:),yvec(6,:),mark)     ; grid on; hold on;xlabel('x (km)')   ;ylabel('y (km)')
%-------------------------------------------------------------------------
