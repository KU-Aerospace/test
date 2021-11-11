%-------------------------------------------------------------------------
% Fine grid Solution
%   using ODE Solver: 4th order (4-stage) Runge-Kutta Method
%-------------------------------------------------------------------------
% (1) Initialize
%     No_state       : number of states
%     x0(1:No_state) : initial states
%     t0             : initial time
%     tf             : final time
%     dt             : time stepsize for numerical integration
%-------------------------------------------------------------------------
function [yy] = B1_ODE_RK4_Fine_Grid_Solution(Kstep,No_state,y0,t,DeL_T) 
%
%-------------------------------------------------------------------------
% (2) Euler method
%-------------------------------------------------------------------------
% (2-1) Number of integration interval
%-------------------------------------------------------------------------
    t0 = t              ;
    dt = DeL_T/Kstep    ;
%
%-------------------------------------------------------------------------
% (2-2) Initialize time history of solution
%-------------------------------------------------------------------------
    y1(1:No_state) =  0.0               ;
    y2(1:No_state) =  0.0               ;
    y3(1:No_state) =  0.0               ;
    y4(1:No_state) =  0.0               ;
%
    f1(1:No_state) =  0.0              ;
    f2(1:No_state) =  0.0              ;
    f3(1:No_state) =  0.0              ;
    f4(1:No_state) =  0.0              ;
%
%-------------------------------------------------------------------------
% (2-3) Fine grid solution using 3rd order Runge-Kutta Integrator
%-------------------------------------------------------------------------
    y(1:No_state) = y0(1:No_state)    ;
    for k  = 1: Kstep
        kp = k + 1           ;
        t  = t0 + (k-1)*dt   ;
%
%   Time Stage 1
%
       T1 = t0                  ;
       y1 = y(1:No_state)       ;
       [f1] = ODE_System3_B_Dynamics(y1,T1) ;
%
%   Time Stage 2
%
       T2 = t0 + 0.5*dt                                          ;
       y2(1:No_state)= y1(1:No_state) + 0.5*dt*f1(1:No_state)   ;
       [f2] = ODE_System3_B_Dynamics(y2,T2) ;
%
%   Time Stage 3
%
       T3 = t0 + 0.5*dt                                          ;
       y3(1:No_state)= y1(1:No_state) + 0.5*dt*f2(1:No_state)   ;
       [f3] = ODE_System3_B_Dynamics(y3,T3) ;
%
%   Time Stage 4
%
       T4 = t0 +     dt                 ;
       y4(1:No_state) = y1(1:No_state) +  dt*f3(1:No_state) ;
       [f4] = ODE_System3_B_Dynamics(y4,T4) ;
%
%   Save states at (k+1)-step
%
       ff(1:No_state) = f1(1:No_state) + 2.0*f2(1:No_state) + 2.0*f3(1:No_state) + f4(1:No_state) ;
%
       y(1:No_state) = y1(1:No_state) + dt*ff(1:No_state)/6.0  ;
%
    end ;
    yy(1:No_state) = y(1:No_state) ;
%-------------------------------------------------------------------------
  