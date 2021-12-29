%----------------------------------------
%  Basis Function Coefficients
%----------------------------------------
function [W] = B3_Basis_Function_Intg(Node,Beta)
%-----------------------------------------
%  (4) Integration of Basis Functions 
%-----------------------------------------
    W(1:Node-1) = Beta(1,1:Node-1) ;
    for j =1:Node-1
        sum = 0.0    ;
        for k=1:j
            kp = k + 1                ;
            sum = sum + Beta(kp,j)/kp ;
        end
        W(j) = W(j) + sum ;
    end
%-----------------------------------------
end
%-----------------------------------------