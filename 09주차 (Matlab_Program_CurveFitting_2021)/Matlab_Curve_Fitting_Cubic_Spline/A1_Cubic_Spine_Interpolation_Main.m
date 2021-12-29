%----------------------------------------
%  Data Generation
%    Input: 
%          N      = number of total data
%    Output
%          Xin(N,1) : independent variable x  (sequential order)
%          Yin(N,1) : Interpolated function
%----------------------------------------
%   Polynomial Regression
%----------------------------------------
% (1) Number of data
%----------------------------------------
    clear all ; close all;
%      
    Nd = 121  ; Nv= 201 ; % Number of Data for Interpolation and Validation
%----------------------------------------
% (2) Generation of Data
%----------------------------------------
% (2-1) Training Data
%----------------------------------------
    N=Nd ; Data_Generation_for_Interpolation    ;
    Xdata  (1:N,1) = xe  (1:N,1) ;
    Ydata  (1:N,1) = ye  (1:N,1) ; % Exact function
    dYdata (1:N,1) = dye (1:N,1) ; % Exact first derivative
    ddYdata(1:N,1) = ddye(1:N,1) ; % Exact second derivative
%----------------------------------------
% (2-2) Validation (Exact) Data
%----------------------------------------
    xe=[];
    ye=[];
%    
    N=Nv ; Data_Generation_for_Interpolation    ;
    Xv(1:N,1) = xe(1:N,1) ;
    Yv(1:N,1) = ye(1:N,1) ;
    dYv (1:N,1) = dye (1:N,1) ;
    ddYv(1:N,1) = ddye(1:N,1) ;
%----------------------------------------
% (3) Spline Interpolation with Xdata(1:Nd,1) and Ydata(1:Nd,1)
%----------------------------------------
% (3-1) Build Block Tri-Diagonal System for Spline Interpolation
%----------------------------------------
    [Am,Bm,Cm] = CubicSpline_Build_BlockMatrix_ABC(Nd,Xdata) ;
%----------------------------------------
% (3-2) Build Block RHS (Right-Hand Side) Vector
%----------------------------------------
    [Bvec] = CubicSpline_Build_RHS_Vector(Nd,Ydata)  ;
%----------------------------------------
% (3-3) Solution of Block Tri-Diagonal Matrix System  
%----------------------------------------
    No_LAE = Nd-1 ; Nblock = 3 ;
    [Bvec] = LAE_Block_TriDiagonal_Solver(No_LAE,Nblock,Am,Bm,Cm,Bvec) ;
%----------------------------------------
% (3-4) Recover Spline Coefficients
%----------------------------------------
    Sc(1:4,1:Nd-1) = 0.0 ; % Declare Dimension and Initialization
    for j=1:Nd-1 
        Sc(  1,j) = Ydata(j,1)  ;
        Sc(2:4,j) = Bvec(1:3,j) ;
    end
%----------------------------------------
% (4) Computing function and derivatives at the Test Points
%----------------------------------------
    Xin(1:Nv,1) = Xv(1:Nv,1) ;
    Yin(1:Nv,1) = 0.0 ;
    for j=1:Nv
        xx   = Xv(j,1)          ;
        [yy] = CubicSpline_Evaluate_Function(xx,Nd,Xdata,Sc) ;
        Yin(j,1) = yy                                        ;
%
        [dYp,ddYp] = CubicSpline_Evaluate_Derivatives(xx,Nd,Xdata,Sc) ;
        dYin (j,1) = dYp  ;       
        ddYin(j,1) = ddYp ; 
    end
%----------------------------------------
% (5) Plot Results
%----------------------------------------
LW=1.5; L1 = 1.5 ;
%----------------------------------------
figure(10);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
                    p1= plot(Xv(:,1),Yv(:,1),'-k')  ;grid on; hold on ; xlabel('x') ;ylabel('y') ;
                    p2= plot(Xdata(:,1),Ydata(:,1),'ro') ; 
                    p3= plot(Xv(:,1),Yin(:,1),'--xb') ; 
                   legend([p1,p2,p3],': exact function',': Data for Interpolation',': Interpolated data')
%----------------------------------------
figure(11);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
                    p1= plot(Xv(:,1),dYv(:,1),'-k')  ;grid on; hold on ; xlabel('x') ;ylabel('dy/dx') ;
                    p2= plot(Xdata(:,1),dYdata(:,1),'ro') ; 
                    p3= plot(Xv(:,1),dYin(:,1),'--xb') ; 
                   legend([p1,p2,p3],': exact function',': Data for Interpolation',': Interpolated data')
%----------------------------------------
figure(12);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
                    p1= plot(Xv(:,1),ddYv(:,1),'-k')  ;grid on; hold on ; xlabel('x') ;ylabel('d^2y/dx^2') ;
                    p2= plot(Xdata(:,1),ddYdata(:,1),'ro') ; 
                    p3= plot(Xv(:,1),ddYin(:,1),'--xb') ; 
                   legend([p1,p2,p3],': exact function',': Data for Interpolation',': Interpolated data')
%----------------------------------------%----------------------------------------