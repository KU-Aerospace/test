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
    Nd = 33  ; Nv= 60 ; % Number of Data for Interpolation and Validation
%----------------------------------------
% (2) Generation of Total Data
%----------------------------------------
    N=Nd ; Data_Generation_for_Interpolation    ;
    Xdata(1:N,1) = xe(1:N,1) ;
    Ydata(1:N,1) = ye(1:N,1) ;
%----------------------------------------
% (3) Build Matrix A consisting of Regression Function
%       Using Training Data
%----------------------------------------
% (3-1) Interpolating function  
%----------------------------------------
    AA(1:N,1:N) = 0.0 ;
    for j=1:N  
        xx = Xdata(j,1)   ;
        AA(j,1) = 1.0   ;
        x1 = 1.0       ;
        for k=2:N
            x1 = x1*xx ;
            AA(j,k) = x1;
        end
    end
%----------------------------------------
% (3-2) Output function  
%----------------------------------------
    B_vec(1:N,1) = Ydata(1:N,1) ; %  
%----------------------------------------
% (3-3) Interpolation Coefficients using LU-decomposition
%----------------------------------------
    [AL_mat, AU_mat] = LU_decomposition(AA);
    [Y_vec] = LU_Forward_substitution (AL_mat, B_vec) ; % Forward Substitution    (Ly=b)        
    [A_vec] = LU_Backward_substitution(AU_mat, Y_vec) ; % Regression Coefficients (Ua=y)      
%----------------------------------------
%   Please, don't use  A_vec = inv(AA)*B_vec;
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
        xx = Xv(j,1)   ;
        Yin(j,1) = A_vec(1) ;
        x1 = 1.0       ;
        for k=2:Nd
            x1 = x1*xx ;
            Yin(j,1) = Yin(j,1) + A_vec(k)*x1 ;
        end
    end        
%----------------------------------------
% (5) Plot Results
%----------------------------------------
LW=1.5; L1 = 1.5 ;
%----------------------------------------
figure(6);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
                    p1= plot(Xv(:,1),Yv(:,1),'-k')  ;grid on; hold on ; ylabel('y') ;
                    p2= plot(Xdata(:,1),Ydata(:,1),'ro') ; 
                    p3= plot(Xin(:,1),Yin(:,1),'--xb') ; 
                   legend([p1,p2,p3],': exact function',': Data for Interpolation',': Interpolated data')
%----------------------------------------