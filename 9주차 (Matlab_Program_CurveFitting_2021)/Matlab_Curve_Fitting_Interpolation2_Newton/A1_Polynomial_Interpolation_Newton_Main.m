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
    Nd = 63  ; Nv= 201 ; % Number of Data for Interpolation and Validation
%----------------------------------------
% (2) Generation of Data
%----------------------------------------
    N=Nd ; Data_Generation_for_Interpolation    ;
    Xdata(1:N,1) = xe(1:N,1) ;
    Ydata(1:N,1) = ye(1:N,1) ;
%----------------------------------------
% (3) Coefficients for Newton Polynomial Interpolation
%----------------------------------------
    A_vec(1,1) = Ydata(1,1)                                       ; % (x1,y1,a1)
    A_vec(2,1) =(Ydata(2,1) - A_vec(1,1))/(Xdata(2,1)-Xdata(1,1)) ; % (x2,y2,a2)
    for j=3:N
        jm= j-1   ;
%
        xx = Xdata(j,1)                           ; % (xj,yj,aj)
        [Pfun_vec] = Product_funtion(xx,Xdata,jm) ; % (xj,yj,aj)
%
        sum = A_vec(1,1)  ;
        for k = 2:jm
            km=k-1;
            sum = sum + A_vec(k,1)*Pfun_vec(km)    ;
        end
%            
        A_vec(j,1) =(Ydata(j,1) - sum)/Pfun_vec(jm)  ;
    end
%----------------------------------------
% (4) Validation Using Exact Data
%----------------------------------------
    xe=[];
    ye=[];
%    
    N=Nv ; Data_Generation_for_Interpolation    ;
    Xv(1:N,1) = xe(1:N,1) ;
    Yv(1:N,1) = ye(1:N,1) ;
%
    Xin(1:Nv,1) = Xv(1:Nv,1) ;
    Yin(1:Nv,1) = 0.0 ;
    for j=1:Nv
        xx = Xv(j,1)          ;
        [Pfun_vec] = Product_funtion(xx,Xdata,jm)                  ;
        Yin(j,1)   = A_vec(1,1) + A_vec(2,1)*(xx - Xdata(1,1))     ;
        for k=3:Nd
            km = k - 1                                             ;
            Yin(j,1) = Yin(j,1) + A_vec(k,1)*Pfun_vec(km,1)        ;
        end
    end        
%----------------------------------------
% (5) Plot Results
%----------------------------------------
LW=1.5; L1 = 1.5 ;
%----------------------------------------
figure(6);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
                    p1= plot(Xv(:,1),Yv(:,1),'-k')  ;grid on; hold on ; xlabel('x') ;ylabel('y') ;
                    p2= plot(Xdata(:,1),Ydata(:,1),'ro') ; 
                    p3= plot(Xin(:,1),Yin(:,1),'--xb') ; 
                   legend([p1,p2,p3],': exact function',': Data for Interpolation',': Interpolated data')
%----------------------------------------