%-------------------------------------------------------------
% (1) Data generation
%-------------------------------------------------------------
  Nx  = 11    ;
  xmin = -1.0 ;
  xmax =  1.0 ; 
  delx = (xmax-xmin)/(Nx-1) ;
%
  for j= 1:Nx 
      x1      = xmin + delx*(j-1) ;
      x2      = x1*x1             ;
      x(j)    = x1                ;
      funn(j) = x2*(1.0-x2)^4     ;
      dfun(j) = 2.0*x1*(1.0-x2)^4 -8*x1*x2*(1.0-x2)^3 ;
      dfun2(j) = dfun(j)                              ;
      dfun4(j) = dfun(j)                              ;
      dfun6(j) = dfun(j)                              ;
  end
%-------------------------------------------------------------
% (2) Richardson Extrapolation Method
%-------------------------------------------------------------
  for j= 4:(Nx-3)
      jp1 = j + 1    ;    jm1 = j - 1  ;
      jp2 = j + 2    ;    jm2 = j - 2  ;
      jp3 = j + 3    ;    jm3 = j - 3  ;
%
      df1 = ( funn(jp1)-funn(jm1) )/(2.0*delx) ;
      df2 = ( funn(jp2)-funn(jm2) )/(4.0*delx) ;
      df3 = ( funn(jp3)-funn(jm3) )/(6.0*delx) ;

      dfun2(j) =   df1                            ;
      dfun4(j) = -(df2 -4.0*df1)/3.0              ;
      dfun6(j) =  (df3 - 6.0*df2 + 15.0*df1)/10.0 ;
  end
%-------------------------------------------------------------
% (3) Compared the results
%-------------------------------------------------------------
figure(1)
    plot(x,funn,'-ro'); grid on; hold on; xlabel('x'); ylabel('f(x)')
%-------------------------------------------------------------
figure(2)
    p1 = plot(x,dfun,'-or'); grid on; hold on; xlabel('x'); ylabel('df/dx')
    p2 = plot(x,dfun2,'--bd');  
    p3 = plot(x,dfun4,'-.mv');  
    p4 = plot(x,dfun6,':ks');  
    legend([p1,p2,p3,p4],': exact solution', ': 2nd order',': 4th order',': 6th order')
%-------------------------------------------------------------
