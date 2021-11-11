%-------------------------------------------------------------------------
% ODE Solver: 4th order (4-stage) Runge-Kutta Method
%-------------------------------------------------------------------------
% (1) Initialize
%     No_state       : number of states
%     x0(1:No_state) : initial states
%     t0             : initial time
%     tf             : final time
%     dt             : time stepsize for numerical integration
%-------------------------------------------------------------------------
[No_state,x0,t0,tf,dt] = ODE_System2_A_init() ;
%
%-------------------------------------------------------------------------
% (2) Euler method
%-------------------------------------------------------------------------
% (2-1) Number of integration interval
%-------------------------------------------------------------------------
    Nstep = (tf - t0)/dt + 1 ;
%-------------------------------------------------------------------------
% (2-2) Initialize time history of solution
%-------------------------------------------------------------------------
    x(1:Nstep,1:No_state) = 0.0            ;
    x(1,      1:No_state) = x0(1:No_state) ;
%
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
    TT(1:Nstep)       =  0.0               ; % time history
%-------------------------------------------------------------------------
% (2-3) Time Integration using 3rd order Runge-Kutta Integrator
%-------------------------------------------------------------------------
    for k  = 1: Nstep-1
        kp = k + 1           ;
        t  = t0 + (k-1)*dt   ;
%
%
%   Time Stage 1
%
       T1 = t                  ;
       y1 = x(k,1:No_state)    ;
       [f1] = ODE_System2_B_Dynamics(y1,T1) ;
%
%   Time Stage 2
%
       T2 = t + 0.5*dt                                          ;
       y2(1:No_state)= y1(1:No_state) + 0.5*dt*f1(1:No_state)   ;
       [f2] = ODE_System2_B_Dynamics(y2,T2) ;
%
%   Time Stage 3
%
       T3 = t + 0.5*dt                                          ;
       y3(1:No_state)= y1(1:No_state) + 0.5*dt*f2(1:No_state)   ;
       [f3] = ODE_System2_B_Dynamics(y3,T3) ;
%
%   Time Stage 4
%
       T4 = t +     dt                 ;
       y4(1:No_state) = y1(1:No_state) +  dt*f3(1:No_state) ;
       [f4] = ODE_System2_B_Dynamics(y4,T4) ;
%
%   Save states at (k+1)-step
%
       ff(1:No_state) = f1(1:No_state) + 2.0*f2(1:No_state) + 2.0*f3(1:No_state) + f4(1:No_state) ;
%
       TT(kp)           = t + dt  ;
       x(kp,1:No_state) = y1(1:No_state) + dt*ff(1:No_state)/6.0  ;
%
    end ;
%-------------------------------------------------------------------------
% (3) Exact solution
%-------------------------------------------------------------------------
    xe(1:Nstep,1:No_state) = 0.0              ; 
    xe(1,1:No_state) = x0(1:No_state) ; 
    ye(  1:No_state) = x0(1:No_state) ; 
    
    Kstep = 20 ; 
    for k  = 1: Nstep-1
        t  = TT(k);
%-------------------------------------------------------------------------
%      [ye] = ODE_System1_C_Exact_solution(t)    ;
%-------------------------------------------------------------------------
       y0(1:No_state) = ye(1:No_state) ; 
       [ye] = B1_ODE_RK4_Fine_Grid_Solution(Kstep,No_state,y0,t,dt) ;
%-------------------------------------------------------------------------
       xe(k+1,1:No_state) = ye(1:No_state)        ; 
%
    end ;
%-------------------------------------------------------------------------
%   Plot the results
%-------------------------------------------------------------------------
figure(7),
    set(gcf,'DefaultLineLineWidth',1.5); % Set line width of line art
    set(gca,'DefaultLineLineWidth',1.5); % Set line width of axis line
%
%  Time histoty of simulation results
%
    p1=plot(TT(1:Nstep),x (1:Nstep,1),'ro') ; hold on ; grid on ; xlabel('time (s)') ; ylabel('x ') ;
    p2=plot(TT(1:Nstep),xe(1:Nstep,1),'-b'  ) ;
    legend([p1,p2],'Simulation(RK-4)','nearly Exact solution')
    title('Position')
%-------------------------------------------------------------------------
figure(8),
    set(gcf,'DefaultLineLineWidth',1.5); % Set line width of line art
    set(gca,'DefaultLineLineWidth',1.5); % Set line width of axis line
%
%  Time histoty of simulation results
%
    p1=plot(TT(1:Nstep),x (1:Nstep,2),'ro') ; hold on ; grid on ; xlabel('time (s)') ; ylabel('dx/dt') ;
    p2=plot(TT(1:Nstep),xe(1:Nstep,2),'-b'  ) ;
    legend([p1,p2],'Simulation(RK-4)','nearly Exact solution')
    title('Velocity')
  