%----------------------------------------
%  Data Generation
%    Input: 
%          N = number of total data
%          alpa = niose amplitude
%    Output
%          xe(N,1) : independent variable x  (sequential order)
%          ye(N,1) : exact dependent function values
%          xn(N,1) : independent variable x  (random order)
%          yn(N,1): noisy dependent function values  
%----------------------------------------
% (1) Number of data
%----------------------------------------
     N=100  ; alpa = 0.0 ;
%----------------------------------------
% (2) Generation of Total Data
%----------------------------------------
    Data_Generation    ;
%----------------------------------------
% (3) Classification of Training Data (80 %) and Validation Data (20%)
%----------------------------------------
% (3-1) Training Data (80 %)  
%----------------------------------------
    Nt = int16(N*0.8)    ;
    xt(1:Nt,1)=xn(1:Nt,1);
    yt(1:Nt,1)=yn(1:Nt,1);
%----------------------------------------
% (3-2) Validation Data (20%)
%----------------------------------------
    Nv= N - Nt             ;
    xv(1:Nv,1)=xn(Nt+1:N,1);
    yv(1:Nv,1)=yn(Nt+1:N,1);
%----------------------------------------
% (4) Plot Training Data (80 %) and Validation Data (20%)
%----------------------------------------
LW=1.5; L1 = 1.5 ;
%----------------------------------------
% (4-1) Total Data  
%----------------------------------------
figure(1);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
    p1= plot(xe(:,1),ye(:,1),'-k')  ;grid on; hold on ; xlabel('x') ; ylabel('y') ;
    p2= plot(xn(:,1),yn(:,1),'ro') ; 
    legend([p1,p2],': exact data',': total data')
%----------------------------------------
% (4-2) Training Data (80 %)  
%----------------------------------------
figure(2);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
    p1= plot(xe(:,1),ye(:,1),'-k')  ;grid on; hold on ; xlabel('x') ; ylabel('y') ;
    p2= plot(xt(:,1),yt(:,1),'ro') ; 
    legend([p1,p2],': exact data',': training data')
%----------------------------------------
% (4-3) Validation Data (20%)
%----------------------------------------
figure(3);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
    p1= plot(xe(:,1),ye(:,1),'-k')  ;grid on; hold on ; xlabel('x') ; ylabel('y') ;
    p2= plot(xv(:,1),yv(:,1),'ro') ; 
    legend([p1,p2],': exact data',': validation data')
%----------------------------------------
figure(4);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
    subplot(3,1,1), p1= plot(xe(:,1),ye(:,1),'-k')  ;grid on; hold on ; ylabel('y') ;
                    p2= plot(xn(:,1),yn(:,1),'ro') ; 
                   legend([p1,p2],': exact data',': total data')
    subplot(3,1,2), p1= plot(xe(:,1),ye(:,1),'-k')  ;grid on; hold on ; ylabel('y') ;
                    p2= plot(xt(:,1),yt(:,1),'ro') ; 
                    legend([p1,p2],': exact data',': training data')
    subplot(3,1,3), p1= plot(xe(:,1),ye(:,1),'-k')  ;grid on; hold on ; xlabel('x') ; ylabel('y') ;
                    p2= plot(xv(:,1),yv(:,1),'ro') ; 
                    legend([p1,p2],': exact data',': validation data')
%----------------------------------------