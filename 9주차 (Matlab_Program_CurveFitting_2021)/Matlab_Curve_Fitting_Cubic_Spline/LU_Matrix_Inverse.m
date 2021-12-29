%----------------------------------------
%  Data  
%    Input: 
%          N       : Number of Rows
%          Am(N,N) : Matrix to be inverted
%    Output
%          Am_inv(N,N) : LAE Solution
%----------------------------------------
function [Am_inv] = LU_Matrix_Inverse(N,Am)
%----------------------------------------
%  (1) Initialize Am_inv aith Am
%----------------------------------------
    Am_inv(1:N,1:N) = Am(1:N,1:N) ;
%----------------------------------------
%  (2) LU-Decoposition
%----------------------------------------
    [AL_mat, AU_mat] = LU_decomposition(Am_inv) ;
%----------------------------------------
%  (3) Build Inverse Matrix
%----------------------------------------
    for j=1:N
%----------------------------------------
%  (3-1) Unit vector
%----------------------------------------
        Evec(1:N,1) = 0.0 ;
        Evec(  j,1) = 1.0 ;
%----------------------------------------
%  (3-2) Column Vector
%----------------------------------------
        [Yvec] = LU_Forward_substitution (AL_mat, Evec)  ; % Forward Substitution    (Ly=b)        
        [Evec] = LU_Backward_substitution(AU_mat, Yvec) ; % Regression Coefficients (Ua=y) 
%
        Am_inv(1:N,j) = Evec(1:N,1)    ;         
%----------------------------------------
     end
%----------------------------------------
end
%----------------------------------------

