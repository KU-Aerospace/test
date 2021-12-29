clear all; close all; clc;
h=0.1;
x1=0; x2=0;
format long
%% Function 1
% forward difference
J_for1(1,1) = (fun1(x1+h,x2  ) - fun1(x1,x2))/h;
J_for1(1,2) = (fun1(x1  ,x2+h) - fun1(x1,x2))/h;
J_for1(2,1) = (fun2(x1+h,x2  ) - fun2(x1,x2))/h;
J_for1(2,2) = (fun2(x1  ,x2+h) - fun2(x1,x2))/h;

% backward difference
J_back1(1,1) = (fun1(x1,x2) - fun1(x1-h,x2  ))/h;
J_back1(1,2) = (fun1(x1,x2) - fun1(x1  ,x2-h))/h;
J_back1(2,1) = (fun2(x1,x2) - fun2(x1-h,x2  ))/h;
J_back1(2,2) = (fun2(x1,x2) - fun2(x1  ,x2-h))/h;

% central difference
J_cen1(1,1) = (fun1(x1+h,x2  ) - fun1(x1-h,x2  ))/(2*h);
J_cen1(1,2) = (fun1(x1  ,x2+h) - fun1(x1  ,x2-h))/(2*h);
J_cen1(2,1) = (fun2(x1+h,x2  ) - fun2(x1-h,x2  ))/(2*h);
J_cen1(2,2) = (fun2(x1  ,x2+h) - fun2(x1  ,x2-h))/(2*h);

J_exa=[1 0 ; 0 -12 ];

err_for_J1 = abs(J_for1 - J_exa);
err_bak_J1 = abs(J_back1- J_exa);
err_cen_J1 = abs(J_cen1 - J_exa);

abs_err_for1 = sum(sum(err_for_J1));
abs_err_bak1 = sum(sum(err_bak_J1));
abs_err_cen1 = sum(sum(err_cen_J1));

%% Function 2
% forward difference
J_for2(1,1) = (fun3(x1+h,x2  ) - fun3(x1,x2))/h;
J_for2(1,2) = (fun3(x1  ,x2+h) - fun3(x1,x2))/h;
J_for2(2,1) = (fun4(x1+h,x2  ) - fun4(x1,x2))/h;
J_for2(2,2) = (fun4(x1  ,x2+h) - fun4(x1,x2))/h;

% backward difference
J_back2(1,1) = (fun3(x1,x2) - fun3(x1-h,x2  ))/h;
J_back2(1,2) = (fun3(x1,x2) - fun3(x1  ,x2-h))/h;
J_back2(2,1) = (fun4(x1,x2) - fun4(x1-h,x2  ))/h;
J_back2(2,2) = (fun4(x1,x2) - fun4(x1  ,x2-h))/h;

% central difference
J_cen2(1,1) = (fun3(x1+h,x2  ) - fun3(x1-h,x2  ))/(2*h);
J_cen2(1,2) = (fun3(x1  ,x2+h) - fun3(x1  ,x2-h))/(2*h);
J_cen2(2,1) = (fun4(x1+h,x2  ) - fun4(x1-h,x2  ))/(2*h);
J_cen2(2,2) = (fun4(x1  ,x2+h) - fun4(x1  ,x2-h))/(2*h);

J_exa=[0 -1 ; -1 0];

err_for_J2 = abs(J_for2 - J_exa);
err_bak_J2 = abs(J_back2- J_exa);
err_cen_J2 = abs(J_cen2 - J_exa);

abs_err_for2 = sum(sum(err_for_J2));
abs_err_bak2 = sum(sum(err_bak_J2));
abs_err_cen2 = sum(sum(err_cen_J2));
