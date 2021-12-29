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
    Nd = 21 ; Nv= 201 ; % Number of Data for Interpolation and Validation
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
    Xv(1:N,1) = xe(1:N,1) ;
    Yv(1:N,1) = ye(1:N,1) ;
%----------------------------------------
% (3-2) Interpolation
%----------------------------------------
    Xin(1:Nv,1) = Xv(1:Nv,1) ;
    Yin(1:Nv,1) = 0.0 ;
    for j=1:Nv
        xx = Xv(j,1)          ;
        [FunLag] = Lagrange_funtion(xx,Nd,Xdata)               ;
        sum = 0.0 ;
        for k=1:Nd
            sum = sum + FunLag(k,1)*Ydata(k,1)                ;
        end
        Yin(j,1) = sum                                        ;
    end
%----------------------------------------
% (5) Plot Results
%----------------------------------------
LW=1.5; L1 = 1.5 ;
%----------------------------------------
figure(7);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
                    p1= plot(Xv(:,1),Yv(:,1),'-k')  ;grid on; hold on ; xlabel('x') ;ylabel('y') ;
                    p2= plot(Xdata(:,1),Ydata(:,1),'ro') ; 
                    p3= plot(Xin(:,1),Yin(:,1),'--xb') ; 
                   legend([p1,p2,p3],': exact function',': Data for Interpolation',': Interpolated data')
%----------------------------------------