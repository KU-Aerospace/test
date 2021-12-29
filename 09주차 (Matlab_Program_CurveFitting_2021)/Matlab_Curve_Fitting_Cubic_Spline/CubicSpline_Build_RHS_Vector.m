%----------------------------------------
%  Data  
%    Input: 
%          N       : Number of total nodes
%          YN(N,1) : Function Data at each node
%    Output
%          Bvec(3,N-1) : Matrix Aj in Block Tri-diagonal Matrix
%----------------------------------------
function [Bvec] = CubicSpline_Build_RHS_Vector(N,YN)
%----------------------------------------
%  (1) Initialize Matrix A, B, C and Compute DX(j), Beta, Gamma.
%----------------------------------------
    Bvec(1:3,1:N-1) = 0.0 ;
%
    for j = 1:N-1
        jp = j + 1 ;
        Bvec(2,j) = YN(jp,1) - YN(j,1) ;
    end
%----------------------------------------
end 
%----------------------------------------
