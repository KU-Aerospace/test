%-------------------------------------------------------------------------
% ODE Solver: Euler Method
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
    y(1:No_state)     =  x0(1:No_state)    ;
    dot_y(1:No_state) =  0.0               ;
    TT(1:Nstep)       =  0.0               ; % time history
%
    yp(1:No_state)    =  0.0               ;
%-------------------------------------------------------------------------
% (2-3) Time Integration using Heun's Predictor and Corrector method
%-------------------------------------------------------------------------
    for k  = 1: Nstep
        kp = k + 1           ;
        t  = t0 + (k-1)*dt ;
%
%   Predictor Step
%
       [dot_y] = ODE_System2_B_Dynamics(y,t) ;
        yp(1:No_state) = y(1:No_state) + dt*dot_y(1:No_state) ;
%
%   Corrector Step
%
       [dot_yp] = ODE_System2_B_Dynamics(yp,t) ;
        y(1:No_state) = y(1:No_state) + 0.5*dt*(dot_y(1:No_state) + dot_yp(1:No_state)) ;
%
%   Save states at (k+1)-step
%
       TT(kp)           = t + dt  ;
       x(kp,1:No_state) = y(1:No_state) ;

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
%-------------------------------------------------------------------------
%   Plot the results
%-------------------------------------------------------------------------
figure(3),
    set(gcf,'DefaultLineLineWidth',1.5); % Set line width of line art
    set(gca,'DefaultLineLineWidth',1.5); % Set line width of axis line
%
%  Time histoty of simulation results
%
    p1=plot(TT(1:Nstep),x (1:Nstep,1),'or') ; hold on ; grid on ; xlabel('time (s)') ; ylabel('x ') ;
    p2=plot(TT(1:Nstep),xe(1:Nstep,1),'-b'  ) ;
    legend([p1,p2],'Simulation(Heun)','nearly Exact solution')
    title('Position')
%-------------------------------------------------------------------------
figure(4),
    set(gcf,'DefaultLineLineWidth',1.5); % Set line width of line art
    set(gca,'DefaultLineLineWidth',1.5); % Set line width of axis line
%
%  Time histoty of simulation results
%
    p1=plot(TT(1:Nstep),x (1:Nstep,2),'or') ; hold on ; grid on ; xlabel('time (s)') ; ylabel('dx/dt') ;
    p2=plot(TT(1:Nstep),xe(1:Nstep,2),'-b'  ) ;
    legend([p1,p2],'Simulation(Heun)','nearly Exact solution')
    title('Velocity')
  