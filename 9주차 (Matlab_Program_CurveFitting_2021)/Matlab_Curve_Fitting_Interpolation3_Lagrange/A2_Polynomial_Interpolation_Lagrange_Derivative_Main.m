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
    Nd = 21  ; Nv= 21 ; % Number of Data for Interpolation and Validation
%----------------------------------------
% (2) Generation of Data
%----------------------------------------
    N=Nd ; Data_Generation_for_Interpolation    ;
    Xdata  (1:N,1) = xe  (1:N,1) ;
    Ydata  (1:N,1) = ye  (1:N,1) ; % Exact function
    dYdata (1:N,1) = dye (1:N,1) ; % Exact first derivative
    ddYdata(1:N,1) = ddye(1:N,1) ; % Exact second derivative
%----------------------------------------
% (3) Lagrange Polynomial Interpolation
%----------------------------------------
% (3-1) Validation Data
%----------------------------------------
    xe=[];
    ye=[];
%    
    N=Nv ; Data_Generation_for_Interpolation    ;
    Xv  (1:N,1) = xe  (1:N,1) ;
    Yv  (1:N,1) = ye  (1:N,1) ;
    dYv (1:N,1) = dye (1:N,1) ;
    ddYv(1:N,1) = ddye(1:N,1) ;
%----------------------------------------
% (3-2) Estimation of 1st derivative at Nodes
%----------------------------------------
    dYp(1:Nd,1) =0.0 ;
    for j=1:Nd
        xx = Xdata(j,1)          ;
        [dot_FunLag] = Lagrange_funtion_derivative(xx,Nd,Xdata)  ;
        sum = 0.0 ;
        for k=1:Nd
            sum = sum + dot_FunLag(k,1)*Ydata(k,1)                ;
        end
        dYp(j,1) = sum                                        ;
    end
%----------------------------------------
% (3-3) Prediction of the 1st and 2nd derivative  
%----------------------------------------
    dYin (1:Nv,1) =0.0 ;
    ddYin(1:Nv,1) =0.0 ;
    for j=1:Nv
        xx = Xv(j,1)          ;
        [dot_FunLag] = Lagrange_funtion_derivative(xx,Nd,Xdata)  ;
        sum1 = 0.0 ;
        sum2 = 0.0 ;  
        for k=1:Nd
            sum1 = sum1 + dot_FunLag(k,1)*Ydata(k,1)   ;
            sum2 = sum2 + dot_FunLag(k,1)*dYp(k,1)     ;
        end
        dYin (j,1) = sum1                               ;
        ddYin(j,1) = sum2                               ;        
    end
%----------------------------------------
% (5) Plot Results
%----------------------------------------
LW=1.5; L1 = 1.5 ;
%----------------------------------------
figure(8);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
                    p1= plot(Xv(:,1),dYv(:,1),'-k')  ;grid on; hold on ; xlabel('x') ;ylabel('dy/dx') ;
                    p2= plot(Xdata(:,1),dYdata(:,1),'ro') ; 
                    p3= plot(Xv(:,1),dYin(:,1),'--xb') ; 
                   legend([p1,p2,p3],': exact function',': Data for Interpolation',': Interpolated data')
%----------------------------------------
figure(9);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
                    p1= plot(Xv(:,1),ddYv(:,1),'-k')  ;grid on; hold on ; xlabel('x') ;ylabel('d^2y/dx^2') ;
                    p2= plot(Xdata(:,1),ddYdata(:,1),'ro') ; 
                    p3= plot(Xv(:,1),ddYin(:,1),'--xb') ; 
                   legend([p1,p2,p3],': exact function',': Data for Interpolation',': Interpolated data')
%----------------------------------------