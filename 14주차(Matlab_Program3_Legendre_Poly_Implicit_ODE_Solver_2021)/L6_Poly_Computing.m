%-------------------------------------------------------------------------
function [fun] = L6_Poly_Computing(N,coef_vec,tau)
%-------------------------------------------------------------------------
    fun = coef_vec(N+1)             ;
%    
    for J = 1:N
        K = N-J+1                   ;
        fun = coef_vec(K) + tau*fun ;
    end
%-------------------------------------------------------------------------
end
%-------------------------------------------------------------------------
