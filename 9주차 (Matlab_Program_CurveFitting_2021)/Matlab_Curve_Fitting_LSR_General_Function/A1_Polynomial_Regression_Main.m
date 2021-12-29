%----------------------------------------
%  Data Generation
%    Input: 
%          Norder = order of Regression Polynomial
%          N      = number of total data
%          alpa   = niose amplitude
%    Output
%          xe(N,1) : independent variable x  (sequential order)
%          ye(N,1) : exact dependent function values
%          xn(N,1) : independent variable x  (random order)
%          yn(N,1): noisy dependent function values  
%----------------------------------------
%   Polynomial Regression
%----------------------------------------
% (1) Number of data
%----------------------------------------
    clear all ; close all;
%      
    Norder = 12 ; N=100  ; alpa = 0.5 ;
%----------------------------------------
% (2) Generation of Total Data
%----------------------------------------
    Data_Generation_Main    ;
%----------------------------------------
% (3) Build Matrix A consisting of Regression Function
%       Using Training Data
%----------------------------------------
% (3-1) Regressor function  
%----------------------------------------
    NN = Norder + 1    ;
    A(1:Nt,1:NN) = 0.0 ;
    for j=1:Nt  
        xx = xn(j,1)   ;
        A(j,1) = 1.0   ;
        x1 = 1.0       ;
        for k=2:NN
            x1 = x1*xx ;
            A(j,k) = x1;
        end
    end
%----------------------------------------
% (3-2) Output function  
%----------------------------------------
    B_vec(1:NN,1) = A'*yn(1:Nt,1) ; % =Transpose(A)*y
%----------------------------------------
% (3-3) Leading Matrix  
%----------------------------------------
    AA = A'*A                 ; % =Transpose(A)*A
%----------------------------------------
% (3-4) Regression Coefficients using LU-decomposition
%----------------------------------------
    [AL_mat, AU_mat] = LU_decomposition(AA);
    [Y_vec] = LU_Forward_substitution (AL_mat, B_vec) ; % Forward Substitution    (Ly=b)        
    [A_vec] = LU_Backward_substitution(AU_mat, Y_vec) ; % Regression Coefficients (Ua=y)      
%----------------------------------------
%   Please, don't use  A_vec = inv(AA)*B_vec;
%----------------------------------------
% (4) Validation Using Exact Data
%----------------------------------------
    yer(1:N,1) = 0.0 ;
    for j=1:N
        xx = xe(j,1)   ;
        yer(j,1) = A_vec(1) ;
        x1 = 1.0       ;
        for k=2:NN
            x1 = x1*xx ;
            yer(j,1) = yer(j,1) + A_vec(k)*x1 ;
        end
    end        
%----------------------------------------
% (5) Validation Using Validation Data
%----------------------------------------
    yvr(1:Nv,1) = 0.0  ;
    for j=1:Nv
        xx = xv(j,1)   ;
        yvr(j,1) = A_vec(1) ;
        x1 = 1.0       ;
        for k=2:NN
            x1 = x1*xx ;
            yvr(j,1) = yvr(j,1) + A_vec(k)*x1 ;
        end
    end 
%----------------------------------------
% (6) Plot Results
%----------------------------------------
LW=1.5; L1 = 1.5 ;
%----------------------------------------
figure(5);set(gcf,'DefaultLineLineWidth',LW);set(gca,'DefaultLineLineWidth',LW)
    subplot(2,1,1), p1= plot(xe(:,1),ye(:,1),'-k')  ;grid on; hold on ; ylabel('y') ;
                    p2= plot(xe(:,1),yer(:,1),'ro') ; 
                   legend([p1,p2],': exact data',': regression polynomial')
    subplot(2,1,2), p1= plot(xe(:,1),ye(:,1),'-k')  ;grid on; hold on ;  xlabel('x') ; ylabel('y') ;
                    p2= plot(xv(:,1),yvr(:,1),'ro') ; 
                    p3= plot(xt(:,1),yt(:,1),'bs') ;                    
                    legend([p1,p2,p3],': exact data',': Validation point',': traing data')
%----------------------------------------