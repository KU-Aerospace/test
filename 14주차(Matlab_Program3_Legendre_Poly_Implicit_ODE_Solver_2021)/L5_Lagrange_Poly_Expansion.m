%-------------------------------------------------------------------------
function [c_mat] = L5_Lagrange_Poly_Expansion(N,tau_vec)
%-------------------------------------------------------------------------
    for J = 1:N
%-------------------------------------------------------------------------
%  (1) Define Alpha and Beta
%-------------------------------------------------------------------------
        Kns = 0 ;
        for K = 1:(J-1)
            Kns = Kns + 1                 ;
            Den = tau_vec(J) - tau_vec(K) ;
            ALp(Kns) = -tau_vec(K)/Den    ;
            Bet(Kns) =  1.0       /Den    ;
        end
%    
        for K = (J+1):N
            Kns = Kns + 1                 ;
            Den = tau_vec(J) - tau_vec(K) ;
            ALp(Kns) = -tau_vec(K)/Den    ;
            Bet(Kns) =  1.0       /Den    ;
        end
%-------------------------------------------------------------------------
%  (2) Recursive update of Polynomial Coefficients
%-------------------------------------------------------------------------
        Bvec(1:N+1) = 0.0 ;
%-------------------------------------------------------------------------
%  (2-1) When J=1
%-------------------------------------------------------------------------
        Bvec(1) = ALp(1) ;
        Bvec(2) = Bet(1) ;
%-------------------------------------------------------------------------
%  (2-2) When J>=2
%-------------------------------------------------------------------------
        for K = 2:(N-1)
            Avec(1) = ALp(K)*Bvec(1)   ;
            for KK = 2:K
                Km = KK-1 ;
                Avec(KK) = ALp(K)*Bvec(KK) + Bet(K)*Bvec(Km) ;
            end
            Avec(K+1)   = Bet(K)*Bvec(K)  ;
            Bvec(1:K+1) = Avec(1:K+1)     ;
        end
%-------------------------------------------------------------------------
%  (2-3) Coefficient
%-------------------------------------------------------------------------
        c_mat(1:N,J) = Bvec(1:N) ;
%-------------------------------------------------------------------------
    end  
%-------------------------------------------------------------------------
end    
%-------------------------------------------------------------------------
