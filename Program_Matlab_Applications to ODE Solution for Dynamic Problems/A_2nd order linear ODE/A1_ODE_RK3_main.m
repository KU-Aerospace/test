%-------------------------------------------------------------------------
% ODE Solver: 3rd order (3-stage) Runge-Kutta Method
%-------------------------------------------------------------------------
% (1) Initialize
%     No_state       : number of states
%     x0(1:No_state) : initial states
%     t0             : initial time
%     tf             : final time
%     dt             : time stepsize for numerical integration
%-------------------------------------------------------------------------
[No_state,x0,t0,tf,dt] = ODE_System1_A_init() ;
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
    y (1:No_state)    =  0.0               ;
    y1(1:No_state)    =  0.0               ;
    y2(1:No_state)    =  0.0               ;
    y3(1:No_state)    =  0.0               ;
%
    dot_y1(1:No_state) =  0.0              ;
    dot_y2(1:No_state) =  0.0              ;
    dot_y3(1:No_state) =  0.0              ;
%
    TT(1:Nstep)       =  0.0               ; % time history
%-------------------------------------------------------------------------
% (2-3) Time Integration using 3rd order Runge-Kutta Integrator
%-------------------------------------------------------------------------
    for k  = 1: Nstep
        kp = k + 1           ;
        t  = t0 + (k-1)*dt   ;
%
%
%   Time Stage 1
%
       T1 = t                  ;
       y1 = x(k,1:No_state)    ;
       [f1] = ODE_System1_B_Dynamics(y1,T1) ;
%
%   Time Stage 2
%
       T2 = t + 0.5*dt                                          ;
       y2(1:No_state)= y1(1:No_state) + 0.5*dt*f1(1:No_state)   ;
       [f2] = ODE_System1_B_Dynamics(y2,T2) ;
%
%   Time Stage 3
%
       T3 = t +     dt                 ;
       y3(1:No_state) = y1(1:No_state) -  dt*f1(1:No_state)  + 2.0*dt*f2(1:No_state)   ;
       [f3] = ODE_System1_B_Dynamics(y3,T3) ;
%
%   Save states at (k+1)-step
%
       ff(1:No_state) = f1(1:No_state) + 4.0*f2(1:No_state) + f3(1:No_state) ;
%
       TT(kp)           = t + dt  ;
       x(kp,1:No_state) = y1(1:No_state) + dt*ff(1:No_state)/6.0  ;
%
    end ;
%-------------------------------------------------------------------------
% (3) Exact solution
%-------------------------------------------------------------------------
    xe(1:Nstep,1:No_state) = 0.0  ; 
    ye(1:No_state) = 0.0  ; 
    for k  = 1: Nstep
        t  = TT(k);
%
        [ye] = ODE_System1_C_Exact_solution(t)    ;
         xe(k,1:No_state) = ye(1:No_state)        ; 
%
    end ;
%-------------------------------------------------------------------------
%   Plot the results
%-------------------------------------------------------------------------
figure(5),
    set(gcf,'DefaultLineLineWidth',1.5); % Set line width of line art
    set(gca,'DefaultLineLineWidth',1.5); % Set line width of axis line
%
%  Time histoty of simulation results
%
    p1=plot(TT(1:Nstep),x (1:Nstep,1),'-.r') ; hold on ; grid on ; xlabel('time (s)') ; ylabel('x ') ;
    p2=plot(TT(1:Nstep),xe(1:Nstep,1),'-b'  ) ;
    legend([p1,p2],'Simulation(RK-3)','Exact solution')
    title('Position')
%-------------------------------------------------------------------------
figure(6),
    set(gcf,'DefaultLineLineWidth',1.5); % Set line width of line art
    set(gca,'DefaultLineLineWidth',1.5); % Set line width of axis line
%
%  Time histoty of simulation results
%
    p1=plot(TT(1:Nstep),x (1:Nstep,2),'-.r') ; hold on ; grid on ; xlabel('time (s)') ; ylabel('dx/dt') ;
    p2=plot(TT(1:Nstep),xe(1:Nstep,2),'-b'  ) ;
    legend([p1,p2],'Simulation(RK-3)','Exact solution')
    title('Velocity')
  