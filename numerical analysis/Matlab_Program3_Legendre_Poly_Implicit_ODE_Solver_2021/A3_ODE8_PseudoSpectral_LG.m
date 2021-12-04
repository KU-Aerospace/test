%-------------------------------------------------------------------------
%  Pseudospectral ODE Solver
%-------------------------------------------------------------------------
% (1) Initial conditions ans solution parameters
%-------------------------------------------------------------------------
   eccen = 0.05 ;
%   
   [y0,Nstep,taumax,T] = ODE_System_Init(eccen) ;
%
%   DeLtau = taumax/(Nstep-1) ;
%
   Iter_max = 100     ;
   ToL_max  = 1.0E-10 ; 
%
   Nq = 11  ; % Number of quadrature nodes
   Nh = 101 ; % Number of Tme horizon
   DeLtau = taumax/(Nh-1) ;
   for J = 1:Nh
       Tn(J) = DeLtau*(J-1) ; % Time Horizon Nodes
   end
%-------------------------------------------------------------------------
% (2) Compute LG-quadrature formula : Nodes, Weights, Integration Matrix
%-------------------------------------------------------------------------
   [tau_vec,Weight_vec]    = B1_Legedre_Gauss_Quadrature(Nq)  ;
   [tau_vec,Fint_mat]      = B2_Legedre_Gauss_Intg_Matrix(Nq) ;
%-------------------------------------------------------------------------
% (2) ODE Solver
%-------------------------------------------------------------------------
% (2-1) Initialze at Horizon
%-------------------------------------------------------------------------
   Yf_vec(1:4) = y0(1:4) ;
   for Jn = 1:Nq
        Xvec(1:4,Jn) = y0(1:4) ;
   end
%-------------------------------------------------------------------------
   for Jh = 1:Nh-1
%-------------------------------------------------------------------------
% (2-1) Timd node
%-------------------------------------------------------------------------
       T0 = Tn(Jh)   ;
       Tf = Tn(Jh+1) ;
       Dtp= 0.5*(Tf+T0) ;
       Dtm= 0.5*(Tf-T0) ;
       Tvec(1:Nq) = Dtm*tau_vec(1:Nq) + Dtp ;
       tf_vec(Jh) = Tf ;
%-------------------------------------------------------------------------
% (2-2) Piccard Iterative Method
%-------------------------------------------------------------------------
       Xvec0(1:4) = Yf_vec(1:4) ;
       for it = 1:Iter_max
%-------------------------------------------------------------------------
% (2-2a) Force Computing
%-------------------------------------------------------------------------
           for Jn=1:Nq
               tau = Tvec(Jn) ; y(1:4) = Xvec(1:4,Jn) ;
               [dot_y] = ODE_System_Dynamics(y,tau,T) ;
               Force(1:4,Jn) = dot_y(1:4)             ;
           end
%-------------------------------------------------------------------------
% (2-2b) Update solutions Using Piccard Method
%-------------------------------------------------------------------------
           Xvec_old(1:4,1:Nq) = Xvec(1:4,1:Nq) ;
           for Jn=1:Nq
              Sum_vec(1:4) = 0.0 ;
              for Kn = 1:Nq
                  Fint = Fint_mat(Jn,Kn) ;
                  Sum_vec(1:4) = Sum_vec(1:4) + Fint*Force(1:4,Kn)' ;
              end
              Xvec(1:4,Jn) =   Xvec0(1:4) + Dtm*Sum_vec(1:4) ;
           end
%
           err = 0.0 ;
           for Jn=1:Nq
              Ev(1:4) = Xvec(1:4,Jn) - Xvec_old(1:4,Jn) ;
%
              err = err + Ev(1)^2 + Ev(2)^2 + Ev(3)^2 + Ev(4)^2 ;
           end
           err = sqrt(err/Nq) ;
%
           if ( err < ToL_max ) 
                  itvec(Jh) = it ;
                  break
           end 
       end
%-------------------------------------------------------------------------
% (2-2b) Update solutions At the final Points
%-------------------------------------------------------------------------
      Sum_vec(1:4) = 0.0 ;
      for Jn = 1:Nq
          Sum_vec(1:4) = Sum_vec(1:4) +Weight_vec(Jn)*Force(1:4,Jn)'  ;
      end
      Yf_vec(1:4) = Xvec0(1:4) + Dtm*Sum_vec(1:4) ;
%-------------------------------------------------------------------------
% (2-2c) Save
%-------------------------------------------------------------------------
      K1 = (Nq+1)*(Jh-1) + 1 ;
      K2 = K1 + 1            ;
      K3 = K1 + Nq           ;
%
      yvec(1:4,K1)    = Xvec0(1:4)     ;
      yvec(1:4,K2:K3) = Xvec(1:4,1:Nq) ;
%
      tvec(K1)        = T0         ;
      tvec(K2:K3)     = Tvec(1:Nq) ;
      for K=K1:K3
          tau = tvec(K) ;
          [ye] = Orbit_Kepler2D_exact(tau,eccen,T)    ;
%
          y(1:4) = yvec(1:4,K) ;
%
          th = y(4) ; cth = cos(th) ; sth = sin(th) ;
          yvec(5,K)   = y(3)*cth           ; 
          yvec(6,K)   = y(3)*sth            ; 
          evec(1:4,K) = abs(y(1:4)-ye(1:4)) ;
      end
   end
   K1 = (Nq+1)*(Nh-1) + 1   ;
%
   tvec(K1)        = Tf      ;
   yvec(1:4,K1)    = Yf_vec(1:4) ;
%
   tau = Tf ;
   [ye] = Orbit_Kepler2D_exact(tau,eccen,T)    ;
%
   y(1:4) = yvec(1:4,K1)     ;
%
   th = y(4) ; cth = cos(th) ; sth = sin(th) ;
   yvec(5,K1)   = y(3)*cth           ; 
   yvec(6,K1)   = y(3)*sth            ; 
   evec(1:4,K1) = abs(y(1:4)-ye(1:4)) ;
%-------------------------------------------------------------------------
% (3) ODE Solver
%-------------------------------------------------------------------------

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
   figure(2);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
      plot(tf_vec(:), itvec(:),mark) ; grid on; hold on; ('time (hr)');ylabel('number of iterations')
%-------------------------------------------------------------------------
