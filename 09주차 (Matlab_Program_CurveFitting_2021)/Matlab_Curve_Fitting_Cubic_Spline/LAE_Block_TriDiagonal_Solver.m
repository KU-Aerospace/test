%----------------------------------------
%  Solution of Block Tri-Diagonal Matrix System  
%    Input: 
%          N       : Number of System of LAE
%          Nb      : Size of Submatrix in the Block 
%          Am(Nb,Nb,N-1) : Matrix Aj  in Block Tri-diagonal Matrix
%          Bm(Nb,Nb,N-1) : Matrix Bj  in Block Tri-diagonal Matrix
%          Cm(Nb,Nb,N-1) : Matrix Cj  in Block Tri-diagonal Matrix
%          Bvec( Nb,N-1) : RHS vector bj in Block Tri-diagonal Matrix
%    Output
%          Bvec(Nb,N-1)  : Results of Block LAE Solution
%----------------------------------------
function [Bvec] = LAE_Block_TriDiagonal_Solver(N,Nb,Am,Bm,Cm,Bvec)
%----------------------------------------
%  (1) Build Block Upper Triangular System of LAEs
%----------------------------------------
    for j=2:N
%----------------------------------------
%  (1-1) Diagonal Matrix Inverse
%----------------------------------------
        jm = j-1 ;
        BB(1:Nb,1:Nb) = Bm(1:Nb,1:Nb,j)     ;
%---------------------------------------- Be careful for zero-diagonal--> use Pivoted LU-decomposition Solver for such a case
%       [BB_inv] = LU_Matrix_Inverse(Nb,BB) ;
%----------------------------------------
        [BB_inv] = inv(BB) ;
%----------------------------------------
%  (1-2) Build Upper Block Triangular System
%----------------------------------------
        Tm(1:Nb,1:Nb)   = Am(1:Nb,1:Nb,j)*BB_inv(1:Nb,1:Nb) ;
        Bm(1:Nb,1:Nb,j) = Bm(1:Nb,1:Nb,j) - Tm(1:Nb,1:Nb)*Cm(1:Nb,1:Nb,jm) ;
        Bvec(1:Nb,j)    = Bvec(   1:Nb,j) - Tm(1:Nb,1:Nb)*Bvec(   1:Nb,jm) ;
    end
%----------------------------------------
%  (2) Solution using Back Substitution
%----------------------------------------
%  (2-1) k= N
%----------------------------------------
    Dvec(1:Nb,1) = Bvec(1:Nb,N)             ;
    BB(1:Nb,1:Nb) = Bm(1:Nb,1:Nb,N)          ;
%---------------------------------------- Be careful for zero-diagonal--> use Pivoted LU-decomposition Solver for such a case
%    [BL_mat, BU_mat] = LU_decomposition(BB)  ;
%    [Yvec] = LU_Forward_substitution (BL_mat, Dvec) ; % Forward Substitution    (Ly=b)        
%    [Dvec] = LU_Backward_substitution(BU_mat, Yvec) ; % Regression Coefficients (Ua=y) 
%----------------------------------------
    Dvec(1:Nb,1) = BB(1:Nb,1:Nb)\Dvec(1:Nb,1);
    Bvec(1:Nb,N) = Dvec(1:Nb,1)              ;
%----------------------------------------
%  (2-2) k= N-1 ~ 1
%----------------------------------------
    for k  =(N-1):-1:1
        kp = k + 1                               ;
        Dvec(1:Nb,1) = Bvec(1:Nb,k) - Cm(1:Nb,1:Nb,k)*Bvec(1:Nb,kp) ;
        BB(1:Nb,1:Nb) = Bm(1:Nb,1:Nb,k)          ;
%---------------------------------------- Be careful for zero-diagonal--> use Pivoted LU-decomposition Solver for such a case
%       [BL_mat, BU_mat] = LU_decomposition(BB)  ;
%       [Yvec] = LU_Forward_substitution (BL_mat, Dvec) ; % Forward Substitution    (Ly=b)        
%       [Dvec] = LU_Backward_substitution(BU_mat, Yvec) ; % Regression Coefficients (Ua=y) 
%----------------------------------------
        Dvec(1:Nb,1) = BB(1:Nb,1:Nb)\Dvec(1:Nb,1);
        Bvec(1:Nb,k) = Dvec(1:Nb,1)              ;
    end
%----------------------------------------
end 
%----------------------------------------
