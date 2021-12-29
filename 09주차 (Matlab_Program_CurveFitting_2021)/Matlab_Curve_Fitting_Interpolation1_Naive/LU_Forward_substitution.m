function [Y_vec] = LU_Forward_substitution(L_mat, E_vec)

    Ndim  = length(L_mat(:,1));
    
    Y_vec(1,1)=E_vec(1,1);
    for j=2:Ndim
        sum =0.0 ;
        for k=1:j-1
            sum =sum + L_mat(j,k)*Y_vec(k,1);
        end
        Y_vec(j,1)= E_vec(j,1) - sum ;
    end
end