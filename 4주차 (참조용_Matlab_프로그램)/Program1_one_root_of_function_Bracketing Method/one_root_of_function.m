function [xroot,error_his,xroot_his,iter,fun_final] = one_root_of_function(xL,xU,epsilon,iter_max)
%-----------------------------------------------------------------------
fL = user_fun(xL);
fU = user_fun(xU);
error_init = abs(xU - xL);
%
for it = 1:iter_max
    xC = 0.5*(xL + xU);
    fC = user_fun(xC);
%
    if(fL*fC <= 0.0) 
        xU = xC;
        fU = fC;
    else
        xL = xC;
        fL = fC;
    end
%
    error_new = abs(xU - xL);
%
    error_rel = error_new/error_init;
    error_his(it,1) = error_rel;
    xroot_his(it,1) = xC;
%
    display_data =[it, error_rel*100.0,xC,fC];
    sprintf(' iter = %4d   error =   %10.4e   XX = %10.4e   FUN =   %10.4e',display_data)    
    
%
    if (error_rel < epsilon)
        break
    end
end
%
iter = it - 1;
xroot= xC    ;
fun_final = fC;
