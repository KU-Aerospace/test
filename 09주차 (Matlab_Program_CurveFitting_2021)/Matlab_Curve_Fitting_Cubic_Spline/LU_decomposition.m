%----------------------------------------
function [L_mat, U_mat] = LU_decomposition(A_mat)
    Ndim = length(A_mat(:,1));
%
    U_mat(1,1:Ndim) = A_mat(1,1:Ndim)             ;
    L_mat(1,1)      = 1.0                         ;
    L_mat(2:Ndim,1) = A_mat(2:Ndim,1)/U_mat(1,1)  ;
 %

    for j=2:Ndim
%
        for k=j:Ndim
            sum=0;
            for m=1:j-1
                sum = sum + L_mat(j,m)*U_mat(m,k) ;
            end
            U_mat(j,k)=A_mat(j,k)-sum;
        end
 %           
        L_mat(j,j)      = 1.0              ;
        for k=j+1:Ndim
            sum=0;
            for m=1:j-1
               sum = sum + L_mat(k,m)*U_mat(m,j) ;
            end
            L_mat(k,j)=(A_mat(k,j)-sum)/U_mat(j,j);
        end
    end

end
%----------------------------------------

