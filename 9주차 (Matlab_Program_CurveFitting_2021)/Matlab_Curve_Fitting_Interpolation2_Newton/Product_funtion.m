function [Pfun_vec] = Product_funtion(x,xvec,j)
%
    Pfun_vec(1,1) = x - xvec(1,1)           ;
    for k=2:j
        km = k-1                            ;
        dx   = x - xvec(k,1)                ;
        Pfun_vec(k,1) = Pfun_vec(km,1)*dx   ;
    end
%
end