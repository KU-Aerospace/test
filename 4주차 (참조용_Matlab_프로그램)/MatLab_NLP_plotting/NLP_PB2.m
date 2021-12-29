% Probelm#1 : Matlab code for NLP Graphic Method
n=50;
xmin =-10.5  ; xmax = 11.5 ; dx=(xmax-xmin)/n;
ymin =-10.5  ; ymax = 10.5 ; dy=(ymax-ymin)/n;

for i=1:n+1;
    x(i)= xmin + dx*i;
    y(i)= ymin + dy*i;
end;
%---------------------------------------------------------
% Objective function
%---------------------------------------------------------
for i=1:n+1;
    for j=1:n+1;
        x1=x(i);
        x2=y(j);
%
        xx(i,j)=x1;
        yy(i,j)=x2;
        ff(i,j)=(x1+1)^2/3 + x2;
    end;
end;
contour(xx,yy,ff,21)
hold on; 
%---------------------------------------------------------
% Constraints
%---------------------------------------------------------
for j=1:n+1;
        xc1(j) =  1.0;  xc2(j) = x(j);
        yc1(j) =  y(j); yc2(j) = 0.0;
end
plot(xc1,yc1,'-r')    
plot(xc2,yc2,'-r')  
