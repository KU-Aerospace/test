%----------------------------------------
%  Data  
%    Input: 
%          N       : Number of total nodes
%          XN(N,1) : Nodes
%    Output
%          Am(3,3,N-1) : Matrix Aj in Block Tri-diagonal Matrix
%          Bm(3,3,N-1) : Matrix Bj in Block Tri-diagonal Matrix
%          Cm(3,3,N-1) : Matrix Cj in Block Tri-diagonal Matrix
%----------------------------------------
function [Am,Bm,Cm] = CubicSpline_Build_BlockMatrix_ABC(N,XN)
%----------------------------------------
%  (1) Initialize Matrix A, B, C and Compute DX(j), Beta, Gamma.
%----------------------------------------
    Am(1:3,1:3,1:N-1) = 0.0 ;
    Bm(1:3,1:3,1:N-1) = 0.0 ;
    Cm(1:3,1:3,1:N-1) = 0.0 ;
%    
    Beta(1:N-2) = 0.0 ;
    Gama(1:N-2) = 0.0 ;
%
    for j = 1:N-1
        jp = j + 1 ;
        DX(j) = XN(jp,1) - XN(j,1) ;
    end
%
    for j = 1:N-2
        jp = j + 1 ;
        Beta(j) = DX(j)/DX(jp)  ;
        Gama(j) = 2.0*Beta(j)^2 ;
    end
%----------------------------------------
%  (2) Matrix Build
%----------------------------------------
%  (2-1) k=1
%----------------------------------------
    Bm(1,1,1) = 0.0 ;  Bm(1,2,1) = 0.0 ;  Bm(1,3,1) = 1.0 ;  
    Bm(2,1,1) = 1.0 ;  Bm(2,2,1) = 1.0 ;  Bm(2,3,1) = 1.0 ;    
    Bm(3,1,1) = 1.0 ;  Bm(3,2,1) = 2.0 ;  Bm(3,3,1) = 3.0 ;    
%
    Cm(3,1,1) = -Beta(1) ;
%----------------------------------------
%  (2-2) k=2 ~ (N-2)
%----------------------------------------
    for k=2: (N-2)
        km = k-1 ;
        Am(1,2,k)= 2.0 ; Am(1,3,k) = 6.0      ;   
%
        Bm(1,1,k)= 0.0 ; Bm(1,2,k)= -Gama(km) ; Bm(1,3,k) = 0.0 ;  
        Bm(2,1,k)= 1.0 ; Bm(2,2,k)=  1.0      ; Bm(2,3,k) = 1.0 ;    
        Bm(3,1,k)= 1.0 ; Bm(3,2,k)=  2.0      ; Bm(3,3,k) = 3.0 ;    
%
        Cm(3,1,k) = -Beta(k) ;
    end
%----------------------------------------
%  (2-3) k=N-1
%----------------------------------------
    k = N-1 ; km = k-1 ;
        Am(1,2,k)= 2.0 ; Am(1,3,k)= 6.0       ;  
%
        Bm(1,1,k)= 0.0 ; Bm(1,2,k)= -Gama(km) ; Bm(1,3,k) = 0.0 ;  
        Bm(2,1,k)= 1.0 ; Bm(2,2,k)=  1.0      ; Bm(2,3,k) = 1.0 ;    
        Bm(3,1,k)= 0.0 ; Bm(3,2,k)=  0.0      ; Bm(3,3,k) = 1.0 ;    
%----------------------------------------
end 
%----------------------------------------
