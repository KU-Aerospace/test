function [X_vec] = LU_Backward_substitution(U_mat, Y_vec)

    Ndim  = length(U_mat(:,1));
    
    X_vec(Ndim,1)=Y_vec(Ndim,1)/U_mat(Ndim,Ndim);
%        
    for j=Ndim-1:-1:1
        sum = 0.0 ;
        for k=j+1:Ndim
            sum = sum + U_mat(j,k)*X_vec(k,1);
        end
        X_vec(j,1)=(Y_vec(j,1) - sum)/U_mat(j,j);
    end
%
end